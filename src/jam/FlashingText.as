package jam
{
   import net.flashpunk.graphics.Text;
   import net.flashpunk.tweens.misc.Alarm;
   import net.flashpunk.Tween;
   
   public class FlashingText extends Text
   {
      private var alarm:Alarm;
      
      private const colors:Array = [16711680,16776960,65280,65535,255,16711935];
      
      private var current:uint = 0;
      
      public function FlashingText(str:String = "", x:int = 0, y:int = 0)
      {
         this.alarm = new Alarm(5,this.change,Tween.LOOPING);
         super(str,x,y);
         color = this.colors[0];
         // TODO engine ???????
         addTween(this.alarm);
      }
      
      private function change() : void
      {
         this.current++;
         if(this.current >= this.colors.length)
         {
            this.current = 0;
         }
         color = this.colors[this.current];
      }
   }
}
