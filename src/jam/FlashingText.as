package jam
{
   import net.flashpunk.graphics.Text;
   import net.flashpunk.tweens.misc.Alarm;
   import net.flashpunk.Tween;
   import net.flashpunk.Entity;
   
   public class FlashingText extends Entity
   {
      private var alarm:Alarm;
      
      private const colors:Array = [16711680,16776960,65280,65535,255,16711935];
      
      private var current:uint = 0;

      private var sine:Number;
      private var angleChange:Boolean;
      public var text:Text;

      public function FlashingText(size:int, str:String, x:int, y:int, active:Boolean = true, color:uint = 0xFFFFFF, angleChange:Boolean = false)
      {
         super(x,y);
         this.active = active;
         Text.size = size;
         graphic = this.text = new Text(str);
         this.text.color = color;
         this.text.centerOO();
         this.alarm = new Alarm(5, this.change,Tween.LOOPING);
         this.sine = Math.random() * Math.PI * 2;
         addTween(this.alarm, true);
      }
      
      override public function update() : void
      {
         super.update();

         if (!angleChange)
            return;
         
         this.sine = (this.sine + Math.PI / 64) % (Math.PI * 2);
         this.text.angle = Math.sin(this.sine) * 6;
      }

      private function change() : void
      {
         this.current++;
         if(this.current >= this.colors.length)
         {
            this.current = 0;
         }
         this.text.color = this.colors[this.current];
      }
   }
}
