package jam
{
   import net.flashpunk.graphics.Spritemap;
   
   public class ElectricBlock extends Block
   {
      
      private static const ImgElec:Class = ElectricBlock_ImgElec;
      
      private static const SprElec:Spritemap = new Spritemap(ImgElec,8,8);
       
      
      public function ElectricBlock(x:int, y:int, width:uint, height:uint)
      {
         super(x,y,width,height);
         sprite = SprElec;
         delay = 10;
         image = y / 8 % sprite.number;
      }
      
      override public function render() : void
      {
         var j:int = 0;
         super.render();
         for(var i:int = 0; i < width; i = i + 8)
         {
            for(j = 0; j < height; j = j + 8)
            {
               drawSprite(SprElec,(image + j / 8) % sprite.number,x + i,y + j);
            }
         }
      }
   }
}
