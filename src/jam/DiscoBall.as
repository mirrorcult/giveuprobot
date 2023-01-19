package jam
{
   import net.flashpunk.Entity;
   import net.flashpunk.graphics.Spritemap;
   import net.flashpunk.FP;
   
   public class DiscoBall extends Entity
   {
      
      public static const ImgBall:Class = DiscoBall_ImgBall;
      
      public var SprBall:Spritemap;
      
      private var appear:Boolean = false;
      
      public function DiscoBall(x:int, y:int)
      {
         super();
         this.x = x;
         this.y = y;
         graphic = SprBall = new Spritemap(ImgBall,64,64);
         SprBall.alpha = 0.1;
      }
      
      override public function update() : void
      {
         if(SprBall.scaleX > 1)
         {
           SprBall. scaleX = SprBall.scaleY = Math.max(1, SprBall.scaleX - 0.05);
         }
         else if(this.appear)
         {
            (FP.world as MenuWorld).createParticles(1,x,y,35,16777215,4,2,0.2,0.1,0,180,40,10);
         }
      }
      
      public function start() : void
      {
         SprBall.rate = 10;
         SprBall.alpha = 1;
         SprBall. scaleX = SprBall.scaleY = 1.4;
         this.appear = true;
         (FP.world as MenuWorld).createParticles(30,x,y,35,16777215,4,2,0.2,0.1,0,180,40,10);
         (FP.world as MenuWorld).createParticles(30,x,y,35,16777215,4,2,0.2,0.1,0,180,40,10,5);
      }
   }
}
