package jam
{
   public class MenuParticle extends Particle
   {
       
      
      public function MenuParticle()
      {
         super();
      }
      
      override public function die() : void
      {
         visible = false;
         active = false;
         alarm.active = false;
         FP.world.remove(this);
         (FP.world as MenuWorld).particles.push(this);
      }
   }
}
