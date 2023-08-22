package jam
{
   import net.flashpunk.graphics.Spritemap;
   import net.flashpunk.FP;
   
   public class ElectricBlock extends Block
   {
      
      private static const ImgElec:Class = Library.ElectricBlock_ImgElec;
      
      private var SprElec:Spritemap;
       
      
      public function ElectricBlock(x:int, y:int, width:uint, height:uint)
      {
         super(x,y,width,height);
         graphic = SprElec = new Spritemap(ImgElec, 8, 8);
         SprElec.rate = 10;
         SprElec.frameCount
         SprElec.frame = y / 8;
      }
      
      override public function render() : void
      {
         // TODO ENGINE making this actually use tilemaps might speed up the game a lot. that would be nice.
         var j:int = 0;
         var ox:int = graphic.x;
         var oy:int = graphic.y;
         for(var i:int = x; i < x + width; i = i + 8)
         {
            for(j = y; j < y + height; j = j + 8)
            {
               SprElec.frame = (SprElec.frame + j / 8) % SprElec.frameCount;
               graphic.x = ox + i - x;
               graphic.y = oy + j - y;
               super.render();
            }
         }
         graphic.x = ox;
         graphic.y = oy;
      }
   }
}
