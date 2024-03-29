package jam
{
   import net.flashpunk.utils.Input;
   import net.flashpunk.graphics.Text;
   import net.flashpunk.FP;
   import net.flashpunk.Sfx;
   import net.flashpunk.Entity;
   
   public class MenuButton extends Entity
   {      
      private var mouseOn:Boolean = false;
      
      private var callback:Function;
      
      private var sine:Number;

      public var text:Text;
      
      public function MenuButton(str:String, x:int, y:int, callback:Function)
      {
         Text.size = 16;
         text = new Text(str, 0, 0);
         super(x,y,text);
         this.callback = callback;
         this.sine = FP.choose(0,0.5,1,1.5,2,2.5,3,3.5) * Math.PI;
         text.centerOO();
      }
      
      private function particleBurst() : void
      {
         var ax:int = 0;
         for(var i:int = 0; i < 2; i++)
         {
            ax = FP.choose(-60,-45,-30,-15,0,15,30,45,60);
            (FP.world as MenuWorld).createParticles(1,x + ax,y,10,0xFFFFFF,2,1,1.5,0.5,0,180,12,4);
         }
      }
      
      override public function update() : void
      {
         super.update();
         if(Input.mouseX > x - 60 && Input.mouseX < x + 60 && Input.mouseY > y - 9 && Input.mouseY < y + 9)
         {
            if(!this.mouseOn)
            {
               this.mouseOn = true;
               var sfx:Sfx = new Sfx(Assets.SndMouse);
               sfx.play();
            }
            this.particleBurst();
            text.color = 0xFFFFFF;
            this.sine = (this.sine + Math.PI / 32) % (Math.PI * 4);
            text.angle = Math.sin(this.sine) * 6;
            text.scaleX = text.scaleY = 1.3 + Math.sin(this.sine / 2) * 0.1;
            if(Input.mousePressed && this.callback != null)
            {
               this.callback(this);
               /* NOTE: OPINIONATED ADDITION */
               if(text.text == "Cancel" || text.text == "Back")
               {
                  var sfxd:Sfx = new Sfx(Assets.SndDeselect);
                  sfxd.play();
               }
               else
               {
                  var sfsx:Sfx = new Sfx(Assets.SndSelect);
                  sfsx.play();
               }
            }
         }
         else
         {
            this.mouseOn = false;
            this.sine = (this.sine + Math.PI / 64) % (Math.PI * 4);
            text.color = 8947848;
            text.angle = Math.sin(this.sine) * 2;
            text.scaleX = text.scaleY = 1 + Math.sin(this.sine / 2) * 0.05;
         }
      }
   }
}
