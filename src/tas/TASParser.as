package tas
{
    import tas.TASCommand;
    import mx.utils.StringUtil;

    public class TASParser
    {
        // Parses a GTAS string into a vector of TAS commands.
        public static function ParseGTAS(data:String) : Vector.<TASCommand>
        {
            var commands:Vector.<TASCommand> = new Vector.<TASCommand>();

            for each (var line:String in data.split("\n"))
            {
                // Remove spaces.
                line = StringUtil.trim(line);
                if (line == "")
                {
                    // Empty case.
                    commands.push(new TASCommand(TASCommand.INPUT, ""));
                    continue;
                }

                var first:String = line.charAt(0);

                switch (first)
                {
                    case TOKEN_COMMENT:
                        continue;
                    case TOKEN_TIMESCALE:
                    {
                        var value:Number = GetTimescaleValue(line);
                        commands.push(new TASCommand(TASCommand.TIMESCALE, value));
                        continue;
                    }
                    case TOKEN_FRAMEHOLD:
                    {
                        // Empty case, but with a framehold.
                        var emptyFramehold:int = GetFrameholdValue(line);
                        for (var i:int = 0; i < emptyFramehold; i++)
                        {
                            commands.push(new TASCommand(TASCommand.INPUT, ""));
                        }
                        continue;
                    }
                }

                // Parse as a normal input with or without framehold.
                var framehold:int = GetFrameholdValue(line);
                var chars:String = GetCharactersUntilFramehold(line);

                if (!TASUtility.ValidateGTASInputs(chars)) continue;

                for (var j:int = 0; j < framehold; j++)
                {
                    commands.push(new TASCommand(TASCommand.INPUT, chars));
                }
            }

            return commands;
        }

        private static function GetTimescaleValue(line:String):Number
        {
            return parseFloat(line.substring(1));
        }

        private static function GetCharactersUntilFramehold(line:String):String
        {
            var commaPlace:int = line.indexOf(",");
            if (commaPlace == -1) return line;

            return line.substring(0, commaPlace);
        }

        private static function GetFrameholdValue(line:String):int
        {
            var commaPlace:int = line.indexOf(",");
            if (commaPlace == -1) return 1; // it gets -1 so this is intended i swear!!

            return parseInt(line.substring(commaPlace + 1));
        }

        // Converts a buffer of TAS commands into a maximally efficient (w/ frameholds) GTAS representation
        public static function EmitGTAS(buffer:Vector.<TASCommand>) : String
        {
            var gtas:String = "";

            for (var i:int = 0; i < buffer.length - 1; i++)
            {
                if (buffer[i].Type == TASCommand.TIMESCALE)
                {
                    gtas += ("*" + (buffer[i].Data as Number));
                }
                else if (buffer[i].Type == TASCommand.INPUT)
                {
                    var d:String = buffer[i].Data as String;
                    gtas += d;
                    var acc:int = 1;

                    for (var j:int = i + 1; j < buffer.length - 1; j++)
                    {
                        if (buffer[j].Type != TASCommand.INPUT) break;
                        if (buffer[j].Data as String != d) break;
                        acc++;
                        i = j;
                    }

                    if (acc > 1) gtas += "," + acc;
                }

                gtas += "\n";
            }

            return gtas;
        }

        public static const TOKEN_COMMENT:String = "#";
        public static const TOKEN_TIMESCALE:String = "*";
        public static const TOKEN_FRAMEHOLD:String = ",";
    }
}