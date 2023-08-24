package jam
{
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import net.flashpunk.graphics.Text;
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Image;
   
   public class FuzzTransition extends Entity
   {
      
      public static const NEW:uint = 4;
      
      public static const MENU:uint = 2;
      
      public static const GOTO_NEXT:uint = 0;
      
      public static const LOAD:uint = 3;
      
      public static const RESTART:uint = 1;
             
      private var lvl:uint;
      
      private var goto1:Class;
      
      private var colorTransform:ColorTransform;

      private var img:Image;
      
      private var mode:uint;
      
      private var long:Boolean;
      
      private var up:Boolean = true;
      
      private var alpha:Number = 0;
      
      public function FuzzTransition(mode:uint, goto1:Class = null, long:Boolean = false, lvl:uint = 1)
      {
         super();
         this.mode = mode;
         this.goto1 = goto1;
         this.long = long;
         this.lvl = lvl;
         graphic = img = new Image(new BitmapData(320,240));
         this.colorTransform = new ColorTransform(1,1,1,0);
         img.tint = this.colorTransform;
         layer = Layer.ABOVE_ALL;
         if(mode == GOTO_NEXT)
         {
            var tent:Title = new Title(36, "Give Up, ROBOT",FP.camera.x + 160,FP.camera.y + 120);
            tent.text.angle = 290 + Math.random() * 140;
            tent.layer = Layer.ABOVE_ALL + 1; // hehe
            FP.world.add(tent);
         }
      }
      
      override public function render() : void
      {
         img.source.noise(Math.random() * 100);

         if(this.up)
         {
            if(this.long)
            {
               this.alpha = this.alpha + 0.02;
            }
            else
            {
               this.alpha = this.alpha + 0.1;
            }
            if(this.alpha >= 1.5)
            {
               this.up = false;
               Assets.fuzz = this;
               if(this.mode == GOTO_NEXT)
               {
                  (FP.world as Level).gotoNext();
               }
               else if(this.mode == RESTART)
               {
                  (FP.world as Level).restart();
                  FP.world.add(this);
               }
               else if(this.mode == MENU)
               {
                  FP.world = new this.goto1();
               }
               else if(this.mode == LOAD)
               {
                  FP.world = new Level(Stats.saveData.levelNum);
               }
               else if(this.mode == NEW)
               {
                  FP.world = new Level(this.lvl);
               }
            }
         }
         else
         {
            if(this.long)
            {
               this.alpha = this.alpha - 0.02;
            }
            else
            {
               this.alpha = this.alpha - 0.1;
            }
            if(this.alpha <= 0)
            {
               FP.world.remove(this);
            }
         }
         img.alpha = this.alpha;
         super.render();
      }
   }
}
