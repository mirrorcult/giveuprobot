package jam
{
   import punk.Textplus;
   import punk.util.Input;
   
   public class MenuButton extends Textplus
   {
       
      
      private var mouseOn:Boolean = false;
      
      private var callback:Function;
      
      private var sine:Number;
      
      public function MenuButton(str:String, x:int, y:int, callback:Function)
      {
         super(str,x,y);
         this.callback = callback;
         size = 16;
         this.sine = FP.choose(0,0.5,1,1.5,2,2.5,3,3.5) * Math.PI;
         center();
      }
      
      private function particleBurst() : void
      {
         var ax:int = 0;
         for(var i:int = 0; i < 2; i++)
         {
            ax = FP.choose(-60,-45,-30,-15,0,15,30,45,60);
            (FP.world as MenuWorld).createParticles(1,x + ax,y,10,16777215,2,1,1.5,0.5,0,180,12,4);
         }
      }
      
      override public function update() : void
      {
         if(Input.mouseX > x - 60 && Input.mouseX < x + 60 && Input.mouseY > y - 9 && Input.mouseY < y + 9)
         {
            if(!this.mouseOn)
            {
               this.mouseOn = true;
               FP.play(Assets.SndMouse);
            }
            this.particleBurst();
            color = 16777215;
            this.sine = (this.sine + Math.PI / 32) % (Math.PI * 4);
            angle = Math.sin(this.sine) * 6;
            scaleX = scaleY = 1.3 + Math.sin(this.sine / 2) * 0.1;
            if(Input.mousePressed && this.callback != null)
            {
               this.callback(this);
               if(text == "Cancel")
               {
                  FP.play(Assets.SndDeselect);
               }
               else
               {
                  FP.play(Assets.SndSelect);
               }
            }
         }
         else
         {
            this.mouseOn = false;
            this.sine = (this.sine + Math.PI / 64) % (Math.PI * 4);
            color = 8947848;
            angle = Math.sin(this.sine) * 2;
            scaleX = scaleY = 1 + Math.sin(this.sine / 2) * 0.05;
         }
      }
   }
}
