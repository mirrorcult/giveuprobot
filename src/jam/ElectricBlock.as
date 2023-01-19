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
         var j:int = 0;
         super.render();
         var ox:int = graphic.x;
         var oy:int = graphic.y;
         for(var i:int = 0; i < width; i = i + 8)
         {
            for(j = 0; j < height; j = j + 8)
            {
               // TODO ENGINE see if this works.
               SprElec.frame = SprElec.frame + j / 8;
               graphic.x = ox + i;
               graphic.y = oy + j;
               super.render();
            }
         }
         graphic.x = ox;
         graphic.y = oy;
      }
   }
}
