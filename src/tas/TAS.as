package tas
{
    import tas.TASCommand;
    import tas.TASParser;
    import flash.filesystem.File;
    import flash.filesystem.FileStream;
    import flash.filesystem.FileMode;
    import flash.html.__HTMLScriptArray;
    import net.flashpunk.FP;
    import jam.Level; // TODO MIRR replace this
    import jam.Stats; // TODO MIRR replace this
    import net.flashpunk.utils.Input;

    public class TAS
    {
        // Stores commands to be saved later.
        public var RecordBuffer:Vector.<TASCommand>;

        // Stores the commands currently being played back.
        public var PlaybackBuffer:Vector.<TASCommand>;

        // The current index into the playback buffer. Not necessarily related to framecount/time.
        private var _idx:uint;

        // no idea why this isnt _idx + 1 but o well.
        public function get curCommand():uint { return _idx }
        public function get commandCount():uint { return PlaybackBuffer ? PlaybackBuffer.length : 0 }

        public var _recording:Boolean = false;
        public var _playingBack:Boolean = false;

        private var _lastInputs:Vector.<int>;

        public function TAS()
        {
            RecordBuffer = new Vector.<TASCommand>;
            PlaybackBuffer = new Vector.<TASCommand>;
        }

        public function Update() : void
        {
            if (!_playingBack && !_recording) return;

            if (_recording)
            {
                if (_playingBack && _idx < PlaybackBuffer.length)
                {
                    RecordBuffer.push(PlaybackBuffer[_idx]);
                }
                else
                {
                    // Take inputs from flashpunk, if there are any.
                    var inp:Vector.<int> = new Vector.<int>;
                    for (var i:int = 0; i < Input.allKeys.length - 1; i++)
                    {
                        if (!Input.allKeys[i]) continue;
                        if (!TASUtility.ToKey[i]) continue;
                        inp.push(i);
                    }

                    var gtas:String = TASUtility.ToGTASInputs(inp);

                    RecordBuffer.push(new TASCommand(TASCommand.INPUT, gtas));
                }
            }

            if (_playingBack)
            {
                if (_idx >= PlaybackBuffer.length)
                {
                    StopPlayback();
                    return;
                }

                Execute();

                // Is there a next command to process?
                var c:TASCommand = Peek();
                while (c)
                {
                    // Check next command. See if we need to execute it immediately (i.e not an input command that needs to wait a frame).
                    if (PlaybackBuffer[_idx].Type == TASCommand.INPUT) break;

                    _idx++;
                    if (_recording)
                    {
                        RecordBuffer.push(PlaybackBuffer[_idx])
                    }
                    Execute()
                    c = Peek();
                }
            }

            _idx++;
        }

        private function Peek() : TASCommand
        {
            if (_idx < PlaybackBuffer.length - 1)
            {
                return PlaybackBuffer[_idx + 1];
            }

            return null;
        }

        private function Execute() : void
        {
            var c:TASCommand = PlaybackBuffer[_idx];

            switch (c.Type)
            {
                case TASCommand.INPUT:
                {
                    // Convert current command to inputs, then send to flashpunk.
                    var v:Vector.<int> = TASUtility.FromGTASInputs(c.Data as String);

                    for each (var o:int in _lastInputs)
                    {
                        if (v.indexOf(o) < 0)
                        {
                            // An input was done last frame that was not present this frame.
                            Input.recordKeyUp(o);
                        }
                    }
                    
                    for each (var n:int in v)
                    {
                        Input.recordKeyDown(n);
                    }

                    _lastInputs = v;

                    break;
                }
                case TASCommand.TIMESCALE:
                {
                    var desired:Number = FP.assignedFrameRate * c.Data as Number;
                    if (desired == 0)
                    {
                        FP.engine.paused = true;
                        FP.engine.setFrameRate(60);
                    }
                    else
                    {
                        if (FP.engine.paused) FP.engine.paused = false;
                        FP.engine.setFrameRate(desired);
                    }
                    break;
                }
            }
        }

        /* Write/Read/Start/Stop API */

        // Writes the record buffer into a GTAS file for this level, then flushes it.
        public function Write(level:Level) : void
        {
            var file:File = TASUtility.GetGTASFile(level, Stats.saveData.time);

            // Don't overwrite a file that might have manual comments or formatting.
            if (file.exists)
                return;

            file.parent.createDirectory();
            
            var fileStream:FileStream = new FileStream();
            fileStream.open(file, FileMode.WRITE);
            fileStream.writeUTFBytes(TASParser.EmitGTAS(RecordBuffer));
            fileStream.close();
            FlushRecording();
        }

        // Does not flush record buffer. Job of the caller.
        public function StartRecording() : void
        {
            _recording = true;
        }

        // Empties the recording buffer and stops recording inputs.
        public function FlushRecording() : void
        {
            RecordBuffer = new Vector.<TASCommand>();
            StopRecording();
        }

        public function StopRecording() : void
        {
            _recording = false;
        }

        // Loads a GTAS file into the playback buffer.
        // Flushes playback but does not start playback.
        // Loads the fastest file it can find.
        public function Load(level:Level) : void
        {
            var file:File = TASUtility.GetFastestGTASFile(level);

            if (file == null)
                return;

            if (!file.exists)
                return;

            FlushPlayback();
            var fileStream:FileStream = new FileStream();
            fileStream.open(file, FileMode.READ);
            PlaybackBuffer = TASParser.ParseGTAS(fileStream.readUTFBytes(fileStream.bytesAvailable));
            fileStream.close();
        }

        // Does not flush playback buffer. Job of the caller.
        public function StartPlayback() : void
        {
            _playingBack = true;
        }

        // Empties the playback buffer and stops playing back inputs.
        public function FlushPlayback() : void
        {
            PlaybackBuffer = new Vector.<TASCommand>();
            StopPlayback();
        }

        public function StopPlayback() : void
        {
            _idx = 0;
            _playingBack = false;
            for each (var n:int in _lastInputs)
            {
                Input.recordKeyUp(n);
            }
            // Were we in the middle of a level when playback stopped?
            // Holy fuck I hate AS null handling.
            if (FP.world && FP.world is Level && (FP.world as Level).player && (FP.world as Level).player.active)
            {
                (FP.world as Level).tasWatermark.updateState();
            }
            // Timescale modifier might change this so let's set it back juuuust in case
            FP.engine.setFrameRate(60);
        }

        /* End */

        /* Get/Set Input Commands */

        public function get CurInput() : String
        {
            // This shouldn't actually be possible, but might as well.
            if (RecordBuffer[RecordBuffer.length - 1].Type != TASCommand.INPUT) return "";

            return RecordBuffer[RecordBuffer.length - 1].Data as String;
        }

        public function set CurInput(data:String) : void
        {
            // We set the record buffer here because that's what matters.
            // Setting the playback buffer in nextinput functions the same, as that cascades down to record buffer anyway.
            // But this has already passed, so we need to set it ourselves.
            if (RecordBuffer[RecordBuffer.length - 1].Type != TASCommand.INPUT) return;

            RecordBuffer[RecordBuffer.length - 1].Data = data;
        }

        // Find whatever the next input command's data is. Not necessarily the 'next' command.
        public function get NextInput() : String
        {
            // We start from the current index, not the next:
            // TAS runs before FP update, so the idx will already be incremented by that point.
            for (var i:int = _idx; i < PlaybackBuffer.length - 1; i++)
            {
                if (PlaybackBuffer[i].Type != TASCommand.INPUT) continue;
                return PlaybackBuffer[i].Data as String;
            }

            return "";
        }

        // Set the next input command's data to whatever. Not necessarily the 'next' command.
        public function set NextInput(data:String) : void
        {
            // Are we at the end of playback? If so, expand.
            if (_idx == PlaybackBuffer.length)
            {
                PlaybackBuffer.push(new TASCommand(TASCommand.INPUT, data));
                return;
            }

            for (var i:int = _idx; i < PlaybackBuffer.length - 1; i++)
            {
                if (PlaybackBuffer[i].Type != TASCommand.INPUT) continue;
                PlaybackBuffer[i].Data = data;
                return;
            }
        }

        /* End */
    }
}