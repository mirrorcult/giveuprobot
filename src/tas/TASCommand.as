package tas
{
    public class TASCommand
    {
        public var Type:uint;
        public var Data:*;

        public function TASCommand(type:uint, data:*)
        {
            Type = type;
            Data = data;
        }

        public static const INPUT:uint = 0;
        public static const TIMESCALE:uint = 1;
    }
}