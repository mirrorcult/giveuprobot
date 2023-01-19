package jam
{
   import net.flashpunk.graphics.Spritemap;
   
   public class Saw extends Block
   {      
      public var SprSaw:Spritemap;
      
      private static const ImgSaw:Class = Saw_ImgSaw;
       
      
      public function Saw(x:int, y:int, flip:Boolean)
      {
         super(x,y,16,16);
         graphic = SprSaw = new Spritemap(ImgSaw,16,16);
         SprSaw.rate = 3;
         // TODO engine is this right for flip?
         SprSaw.flipped = !flip;
         layer = 10;
      }
   }
}
