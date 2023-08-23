package jam
{
   import net.flashpunk.graphics.Spritemap;
   
   public class Saw extends Block
   {      
      public var SprSaw:Spritemap;
      
      private static const ImgSaw:Class = Library.Saw_ImgSaw;
       
      
      public function Saw(x:int, y:int, flip:Boolean)
      {
         super(x,y,16,16);
         graphic = SprSaw = new Spritemap(ImgSaw,16,16);
         SprSaw.flipped = flip;
         layer = 10;
         SprSaw.add("spin", [0,1,2,3], 1/3, true);
         SprSaw.play("spin");
      }
   }
}
