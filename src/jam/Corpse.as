package jam
{
   import net.flashpunk.Entity;
   import flash.display.Sprite;
   import net.flashpunk.graphics.Spritemap;
   
   public class Corpse extends Entity
   {
      public var spr:Spritemap;
      
      public function Corpse(x:int, y:int)
      {
         super();
         this.x = x;
         this.y = y;
         this.graphic = spr = new Spritemap(Player.ImgIdle,10,18);
         spr.originX = 5;
         spr.originY = 13;
         spr.flipped = true;
         spr.rate = 0;
         spr.color = 4294967295;
      }
      
      override public function update() : void
      {
         spr.alpha = spr.alpha - 0.05;
         spr.scaleX = spr.scaleX + 0.02;
         spr.scaleY = spr.scaleY + 0.02;
      }
   }
}
