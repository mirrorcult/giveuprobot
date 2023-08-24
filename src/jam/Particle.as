package jam
{
   import flash.geom.Point;
   import net.flashpunk.Entity;
   import net.flashpunk.tweens.misc.Alarm;
   import net.flashpunk.Tween;
   import net.flashpunk.FP;
   import net.flashpunk.utils.Draw;
   
   public class Particle extends Entity
   {
       
      
      private var size:uint;
      
      private var color:uint;
      
      protected var alarm:Alarm;
      
      private var alarmDelay:Alarm;
      
      private var vSpeed:Number;
      
      private var hSpeed:Number;
      
      public function Particle()
      {
         this.alarm = new Alarm(1,this.die,Tween.PERSIST);
         this.alarmDelay = new Alarm(1,this.onDelay,Tween.PERSIST);
         super();
         visible = false;
         active = false;
         layer = Layer.ABOVE_PLAYER;
         addTween(this.alarm,false);
         addTween(this.alarmDelay,false);
      }
      
      public function die(levelDying:Boolean = false) : void
      {
         visible = false;
         active = false;
         this.alarm.active = false;
         if (!levelDying)
            FP.world.remove(this);
         (FP.world as Level).particles.push(this);
      }
      
      private function onDelay() : void
      {
         this.alarm.start();
         visible = true;
         active = true;
      }
      
      public function setDraw(x:uint, y:uint, color:uint, size:uint, speed:Number, direction:Number, life:uint, delay:uint = 0) : void
      {
         this.x = x - size / 2;
         this.y = y - size / 2;
         this.color = color;
         this.size = size;
         var p:Point = new Point;
         FP.angleXY(p,speed);
         this.hSpeed = p.x;
         this.vSpeed = p.y;
         this.alarm.reset(life);
         this.alarm.active = false;
         if(delay > 0)
         {
            this.alarmDelay.reset(delay);
            this.alarmDelay.start();
         }
         else
         {
            visible = true;
            active = true;
            this.alarm.start();
         }
      }
      
      override public function update() : void
      {
         x = x + this.hSpeed;
         y = y + this.vSpeed;
      }
      
      override public function render() : void
      {
         Draw.rect(x,y,this.size,this.size,this.color,this.alarm.remaining / (this.alarm.duration / 8));
      }
   }
}
