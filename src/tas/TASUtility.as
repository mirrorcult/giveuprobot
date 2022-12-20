package tas
{
    import tas.TASCommand;
    import tas.TASParser;
    import flash.filesystem.File;
    import jam.Level;
    import flash.utils.Dictionary;
    import net.flashpunk.utils.Key;

    public class TASUtility
    {
        public static var FromKey:Dictionary = new Dictionary();
        {
            FromKey["R"] = Key.RIGHT;
            FromKey["L"] = Key.LEFT;
            FromKey["U"] = Key.UP;
            FromKey["D"] = Key.DOWN;
            FromKey["A"] = Key.A;
            FromKey["Z"] = Key.Z;
            FromKey["X"] = Key.X;
            FromKey["S"] = Key.S;
        }

        public static var ToKey:Dictionary = new Dictionary();
        {
            ToKey[Key.RIGHT] = "R";
            ToKey[Key.LEFT] = "L";
            ToKey[Key.UP] = "U";
            ToKey[Key.DOWN] = "D";
            ToKey[Key.A] = "A";
            ToKey[Key.Z] = "Z";
            ToKey[Key.X] = "X";
            ToKey[Key.S] = "S";
        }

        // Returns true if all keys are valid.
        public static function ValidateGTASInputs(gtas:String):Boolean
        {
            gtas = gtas.toUpperCase();

            if (gtas == "")
                return true;

            for (var i:int = 0; i < gtas.length; i++)
            {
                var c:String = gtas.charAt(i);
                if (!FromKey[c]) return false;
            }

            return true;
        }

        // Converts a string of GTAS inputs to a vector of int keycodes.
        public static function FromGTASInputs(gtas:String) : Vector.<int>
        {
            gtas = gtas.toUpperCase();

            var seen:Vector.<String> = new Vector.<String>();
            var keys:Vector.<int> = new Vector.<int>();

            for (var i:int = 0; i < gtas.length; i++)
            {
                var c:String = gtas.charAt(i);
                if (!FromKey[c] || seen.indexOf(c) > 0) continue;
                keys.push(FromKey[c]);
                seen.push(c);
            }

            return keys;
        }

        // Converts a vector of int keycodes to a string of GTAS inputs.
        public static function ToGTASInputs(keys:Vector.<int>) : String
        {
            var seen:Vector.<int> = new Vector.<int>();
            var names:String = ""

            for each (var key:int in keys)
            {
                if (!ToKey[key] || seen.indexOf(key) > 0) continue;
                names += ToKey[key];
                seen.push(key);
            }

            return names;
        }

        public static function GetGTASFileName(level:Level, time:uint) : String
        {
            return level.toString() + "_" + time + ".gtas";
        }

        // Does not create the directory.
        public static function GetGTASFileDirectory(level:Level) : File
        {
            var prefix:String = level.getPrefix();
            var parentDir:File = File.applicationStorageDirectory;
            var desiredDir:File = parentDir.resolvePath("TAS").resolvePath(prefix);
            return desiredDir;
        }

        // Does not create its directory.
        public static function GetGTASFile(level:Level, time:uint) : File
        {
            var dir:File = GetGTASFileDirectory(level);
            var name:String = GetGTASFileName(level, time);
            return dir.resolvePath(name);
        }

        // Warning: does create directory.
        public static function GetFastestGTASFile(level:Level) : File
        {
            var dir:File = GetGTASFileDirectory(level);
            var str:String = level.toString() + "_";
            dir.createDirectory();

            var lowest:uint = uint.MAX_VALUE;
            var fastest:File = null;
            for each (var file:File in dir.getDirectoryListing())
            {
                if (file.name.indexOf(str) == -1) continue;
                if (file.extension != "gtas") continue;
                var fc:uint = GetTimeFromFile(file);
                if (fc < lowest) 
                {
                    fastest = file;
                    lowest = fc;
                }
            }

            return fastest;
        }

        public static function GetTimeFromFile(file:File) : uint
        {
            var name:String = file.name;
            if (name.lastIndexOf("_") == -1)
                return 0;
            
            var frameCount:String = name.substring(name.lastIndexOf("_") + 1, name.length);
            return parseInt(frameCount);
        }
    }

}