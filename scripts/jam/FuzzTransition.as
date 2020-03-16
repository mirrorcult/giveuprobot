package jam
{
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import punk.Textplus;
   import punk.core.Entity;
   
   public class FuzzTransition extends Entity
   {
      
      public static const NEW:uint = 4;
      
      public static const MENU:uint = 2;
      
      public static const GOTO_NEXT:uint = 0;
      
      public static const LOAD:uint = 3;
      
      public static const RESTART:uint = 1;
       
      
      private var bitmapData:BitmapData;
      
      private var lvl:uint;
      
      private var goto:Class;
      
      private var colorTransform:ColorTransform;
      
      private var mode:uint;
      
      private var long:Boolean;
      
      private var up:Boolean = true;
      
      private var alpha:Number = 0;
      
      public function FuzzTransition(mode:uint, goto:Class = null, long:Boolean = false, lvl:uint = 1)
      {
         var t:Textplus = null;
         super();
         this.mode = mode;
         this.goto = goto;
         this.long = long;
         this.lvl = lvl;
         this.bitmapData = new BitmapData(320,240);
         this.colorTransform = new ColorTransform(1,1,1,0);
         depth = -500000000;
         if(mode == GOTO_NEXT)
         {
            t = new Textplus("Give Up, ROBOT",FP.camera.x + 160,FP.camera.y + 120);
            t.size = 36;
            t.angle = 290 + Math.random() * 140;
            t.color = 16777215;
            t.depth = -500000001;
            t.center();
            FP.world.add(t);
         }
      }
      
      override public function update() : void
      {
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
                  FP.goto = new this.goto();
               }
               else if(this.mode == LOAD)
               {
                  FP.goto = new Level(Stats.saveData.levelNum);
               }
               else if(this.mode == NEW)
               {
                  FP.goto = new Level(this.lvl);
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
      }
      
      override public function render() : void
      {
         this.bitmapData.noise(Math.random() * 100);
         this.colorTransform.alphaMultiplier = this.alpha;
         FP.screen.draw(this.bitmapData,null,this.colorTransform);
      }
   }
}
