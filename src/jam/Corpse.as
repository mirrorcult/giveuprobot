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
         this.graphic = spr = new Spritemap(ImgIdle,10,18,true,false,5,13); // TODO MIRR huh? 5 13?
         spr.delay = 0; // TODO mirr what??
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
