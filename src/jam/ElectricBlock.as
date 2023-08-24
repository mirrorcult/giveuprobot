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
         SprElec.add("anim", [0,1,2,3], 1/10);
         SprElec.play("anim", false, y / 8 % SprElec.frameCount);
      }
      
      override public function render() : void
      {
         // TODO ENGINE making this actually use tilemaps might speed up the game a lot. that would be nice.
         var j:int = 0;
         var of:int = SprElec.frame;
         var ox:int = graphic.x;
         var oy:int = graphic.y;
         for(var i:int = 0; i < width; i = i + 8)
         {
            for(j = 0; j < height; j = j + 8)
            {
               SprElec.setFrameDirect((SprElec.frame + j / 8) % SprElec.frameCount);
               graphic.x = ox + i;
               graphic.y = oy + j;
               super.render();
               SprElec.setFrameDirect(of);
            }
         }
         graphic.x = ox;
         graphic.y = oy;
      }
   }
}
