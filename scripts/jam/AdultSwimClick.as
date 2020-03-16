package jam
{
   import punk.Textplus;
   import punk.util.Input;
   
   public class AdultSwimClick extends Textplus
   {
       
      
      private var mouseOn:Boolean = false;
      
      private const Y:int = 234;
      
      public function AdultSwimClick()
      {
         super("[AdultSwim.com]",160,224);
         size = 8;
         x = 160 - width / 2;
         y = 224 - height / 2;
         depth = -999999999;
      }
      
      override public function update() : void
      {
         if(Input.mouseX >= FP.camera.x + 110 && Input.mouseY >= FP.camera.y + this.Y - 8 && Input.mouseX < FP.camera.x + 210 && Input.mouseY < FP.camera.y + this.Y + 8)
         {
            if(!this.mouseOn)
            {
               this.mouseOn = true;
               FP.play(Assets.SndMouse);
            }
            size = 12;
            color = 16777215;
            if(Input.mousePressed)
            {
               Main.link("gameplay");
            }
         }
         else
         {
            size = 8;
            this.mouseOn = false;
            color = 8947848;
         }
         x = FP.camera.x + 160 - width / 2;
         y = FP.camera.y + this.Y - height / 2;
      }
      
      override public function render() : void
      {
         if(size == 8)
         {
            drawRect(FP.camera.x + 125,FP.camera.y + this.Y - 6,70,11);
         }
         else
         {
            drawRect(FP.camera.x + 110,FP.camera.y + this.Y - 8,100,15);
         }
         super.render();
      }
   }
}
