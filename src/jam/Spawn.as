package jam
{
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Spritemap;
   
   public class Spawn extends Entity
   {
      public var spr:Spritemap;
      
      public function Spawn(x:int, y:int)
      {
         super();
         this.x = x;
         this.y = y;
         graphic = spr = new Spritemap(Player.ImgIdle, 10, 18);
         spr.set(5, 13);
         spr.rate = 0;
         spr.color = 0xFFFFFF;
         spr.alpha = 0;
      }
      
      override public function update() : void
      {
         spr.alpha = spr.alpha + 0.05;
         if (spr.alpha + 0.05 >= 1 && (FP.world as Level).player)
         {
            // next frame player will be active, so start TAS now
            (FP.world as Level).startTAS();
         }
         if(spr.alpha >= 1 && (FP.world as Level).player)
         {
            FP.world.remove(this);
            (FP.world as Level).player.visible = true;
            (FP.world as Level).player.active = true;
         }
      }
   }
}
