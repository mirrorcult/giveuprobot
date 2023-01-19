package jam
{
   import net.flashpunk.tweens.misc.Alarm;
   import net.flashpunk.graphics.Spritemap;
   import net.flashpunk.utils.Input;
   import net.flashpunk.FP;
   import net.flashpunk.Tween;
   import net.flashpunk.Sfx;
   import net.flashpunk.utils.Draw;
   
   public class Player extends Moveable
   {
      
      public static const ImgThrow:Class = Library.Player_ImgThrow;
      
      public static const ImgThrowDown:Class = Library.Player_ImgThrowDown;
      
      public var SprIdle:Spritemap;
      
      private var SprThrowUp:Spritemap;
      
      private static const ImgThrowUp:Class = Library.Player_ImgThrowUp;
      
      private var SprThrow:Spritemap;
      
      private var SprThrowDown:Spritemap;
      
      private static const ImgFall:Class = Library.Player_ImgFall;
      
      public static const ImgIdle:Class = Library.Player_ImgIdle;
      
      private var SprJump:Spritemap;
      
      public static const ImgRun:Class = Library.Player_ImgRun;
      
      public static const ImgGrapple:Class = Library.Player_ImgGrapple;
      
      private var SprGrappleAir:Spritemap;
      
      private static const ImgJump:Class = Library.Player_ImgJump;
      
      private var SprRun:Spritemap;
      
      private var SprFall:Spritemap;
      
      private var SprGrapple:Spritemap;
      
      private static const ImgGrappleAir:Class = Library.Player_ImgGrappleAir;
      
      private var varJ:Boolean = false;
      
      private var level:Level;
      
      private var dir:int = 1;
      
      private var grapple:Grapple;
      
      private const MAX_FALL:Number = 3.0;
      
      private const AIR_FRIC:Number = 0.1;
      
      private var alarmVarJTime:Alarm;
      
      private var currentSprite:int = -1;
      
      private const FRIC:Number = 0.6;
      
      private const VARJ_TIME:uint = 12;
      
      private const RUN:Number = 0.6;
      
      private const GRAVITY:Number = 0.15;
      
      private const MAX_RUN:Number = 2.0;
      
      public var vSpeed:Number = 0;
      
      private const JUMP:Number = -2.0;
      
      private var grappleWall:Boolean = false;
      
      public var hSpeed:Number = 0;
      
      public function Player(level:Level, x:int, y:int)
      {
         SprIdle = new Spritemap(ImgIdle,10,18);
         SprIdle.flipped = true;
         SprIdle.originX = 5;
         SprIdle.originY = 13;
         SprThrowUp = new Spritemap(ImgThrowUp,10,17);
         SprThrowUp.flipped = true;
         SprThrowUp.originX = 5;
         SprThrowUp.originY = 12;
         SprThrow = new Spritemap(ImgThrow,10,17);
         SprThrow.flipped = true;
         SprThrow.originX = 5;
         SprThrow.originY = 12;
         SprThrowDown = new Spritemap(ImgThrowDown,10,17);
         SprThrowDown.flipped = true;
         SprThrowDown.originX = 5;
         SprThrowDown.originY = 12;
         SprJump = new Spritemap(ImgJump,10,18);
         SprJump.flipped = true;
         SprJump.originX = 5;
         SprJump.originY = 13;
         SprGrappleAir = new Spritemap(ImgGrappleAir,12,17);
         SprGrappleAir.flipped = true;
         SprGrappleAir.originX = 6;
         SprGrappleAir.originY = 10;
         SprRun = new Spritemap(ImgRun,12,17);
         SprRun.flipped = true;
         SprRun.originX = 6;
         SprRun.originY = 12;
         SprFall = new Spritemap(ImgFall,10,17);
         SprFall.flipped = true;
         SprFall.originX = 5;
         SprFall.originY = 12;
         SprGrapple = new Spritemap(ImgGrapple,12,17);
         SprGrapple.flipped = true;
         SprGrapple.originX = 6;
         SprGrapple.originY = 12;
         this.alarmVarJTime = new Alarm(this.VARJ_TIME,this.onVarJTime,Tween.PERSIST);
         super();
         this.level = level;
         this.x = x;
         this.y = y;
         width = 8;
         height = 10;
         originX = 4;
         originY = 5;
         layer = -900;
         this.setSprite(SprIdle,15);
         addTween(this.alarmVarJTime,false);
         visible = false;
         active = false;
      }
      
      public function die(b:Block = null) : void
      {
         var sfx:Sfx = new Sfx(Assets.SndDie);
         sfx.play();
         this.level.screenShake(20);
         active = false;
         visible = false;
         if(this.grapple)
         {
            this.grapple.kill();
         }
         this.level.createParticles(1,x,y,0,16777215,6,1,1.5,0,0,0,60,0);
         this.level.createParticles(1,x,y,0,16777215,6,1,1.5,0,45,0,60,0);
         this.level.createParticles(1,x,y,0,16777215,6,1,1.5,0,90,0,60,0);
         this.level.createParticles(1,x,y,0,16777215,6,1,1.5,0,135,0,60,0);
         this.level.createParticles(1,x,y,0,16777215,6,1,1.5,0,180,0,60,0);
         this.level.createParticles(1,x,y,0,16777215,6,1,1.5,0,225,0,60,0);
         this.level.createParticles(1,x,y,0,16777215,6,1,1.5,0,270,0,60,0);
         this.level.createParticles(1,x,y,0,16777215,6,1,1.5,0,315,0,60,0);
         this.level.createParticles(26,x,y,6,16777215,2,1,2,1,0,180,40,10);
         this.level.createParticles(13,x,y,6,16777215,3,2,4,1,0,180,40,10);
         FP.world.add(new Corpse(x,y));
         (FP.world as Level).die();
      }
      
      private function setSprite(to:Spritemap, del:uint = 0) : void
      {
         to.flipped = (graphic as Spritemap).flipped;
         if(graphic != to)
         {
            graphic = to;
            to.frame = 0;
         }
         to.rate = del;
      }
      
      override public function update() : void
      {
         var onG:Block = getBelow();
         if(onG is ElectricBlock)
         {
            this.die();
            return;
         }
         if(Input.check("right"))
         {
            if(onG)
            {
               this.level.createParticles(1,x,y + 6,2,16777215,3,1,0.3,0.1,90,15,20,5);
            }
            (graphic as Spritemap).flipped = false;
            this.dir = 1;
            if(this.hSpeed < this.MAX_RUN)
            {
               this.hSpeed = Math.min(this.hSpeed + this.RUN,this.MAX_RUN);
            }
         }
         else if(Input.check("left"))
         {
            if(onG)
            {
               this.level.createParticles(1,x,y + 6,2,16777215,3,1,0.3,0.1,90,15,20,5);
            }
            (graphic as Spritemap).flipped = true;
            this.dir = -1;
            if(this.hSpeed > -this.MAX_RUN)
            {
               this.hSpeed = Math.max(this.hSpeed - this.RUN,-this.MAX_RUN);
            }
         }
         else
         {
            this.hSpeed = FP.approach(this.hSpeed,0,!!onG?Number(this.FRIC):Number(this.AIR_FRIC));
         }
         if(this.grapple)
         {
            if(!Input.check("grapple"))
            {
               this.grapple.destroy();
            }
         }
         else if(Input.pressed("grapple"))
         {
            var sfx:Sfx = new Sfx(Assets.SndGrapple);
            sfx.play();
            FP.world.add(this.grapple = new Grapple(this.level,this,x,y,this.dir));
         }
         if(!this.grappleWall)
         {
            if(onG)
            {
               if(Input.pressed("jump"))
               {
                  this.level.createParticles(6,x,y + 6,2,16777215,3,2,1,0.5,90,30,20,8);
                  this.varJ = true;
                  this.alarmVarJTime.start();
                  this.vSpeed = this.JUMP;
                  var sfxj:Sfx = new Sfx(Assets.SndJump);
                  sfxj.play();
               }
            }
            else
            {
               this.vSpeed = Math.min(this.vSpeed + this.GRAVITY,this.MAX_FALL);
               if(this.varJ)
               {
                  if(Input.check("jump"))
                  {
                     this.vSpeed = this.JUMP;
                  }
                  else
                  {
                     this.varJ = false;
                  }
               }
            }
            moveH(this.hSpeed,this.collideH);
            moveV(this.vSpeed,this.collideV);
         }
         if(this.grappleWall)
         {
            this.level.createParticles(2,x,y,8,16711935,3,2,2,0.5,0,180,4,1);
            if(onG)
            {
               this.setSprite(SprGrapple);
            }
            else
            {
               this.setSprite(SprGrappleAir,5);
            }
         }
         else if(onG)
         {
            if(this.grapple)
            {
               this.setSprite(SprThrow);
            }
            else if(!Input.check("left") && !Input.check("right"))
            {
               this.setSprite(SprIdle,12);
            }
            else
            {
               this.setSprite(SprRun,6);
            }
         }
         else if(this.grapple)
         {
            if(Math.abs(this.vSpeed) <= 0.8)
            {
               this.setSprite(SprThrow);
            }
            else if(this.vSpeed < 0)
            {
               this.setSprite(SprThrowUp);
            }
            else
            {
               this.setSprite(SprThrowDown);
            }
         }
         else if(Math.abs(this.vSpeed) <= 0.8)
         {
            this.setSprite(SprIdle);
         }
         else if(this.vSpeed < 0)
         {
            this.setSprite(SprJump);
         }
         else
         {
            this.setSprite(SprFall);
         }
         FP.camera.x = x;
         FP.camera.y = y;
         if(x > (FP.world as Level).width + originX - 1)
         {
            if(this.grapple)
            {
               this.grapple.destroy();
            }
            (FP.world as Level).win();
         }
         else if(y > (FP.world as Level).height + originY + 5)
         {
            this.die();
         }
      }
      
      private function collideH(b:Block) : void
      {
         if(b is ElectricBlock || b is Saw)
         {
            this.die();
         }
         this.hSpeed = 0;
      }
      
      private function collideV(b:Block) : void
      {
         if(b is ElectricBlock || b is Saw)
         {
            this.die();
         }
         this.vSpeed = 0;
      }
      
      public function onGrappleHitWall() : void
      {
         this.hSpeed = 0;
         this.vSpeed = 0;
         this.grappleWall = true;
      }
      
      private function onVarJTime() : void
      {
         this.varJ = false;
      }
      
      override public function render() : void
      {
         var ax:int = 0;
         var ay:int = 0;
         var c:uint = 0;
         if(this.grappleWall)
         {
            ax = -3 + Math.random() * 6;
            ay = -3 + Math.random() * 6;
         }
         else
         {
            ax = 0;
            ay = 0;
         }
         if(this.grapple)
         {
            if(this.grappleWall)
            {
               c = 4278255615;
            }
            else
            {
               c = 4294967040;
            }
            Draw.linePlus(this.grapple.x,this.grapple.y,x + ax,y + ay - originY - 4,c,1,2);
         }
         x = x + ax;
         y = y + ay;
         super.render();
         x = x - ax;
         y = y - ay;
      }
      
      public function removeGrapple() : void
      {
         this.grapple = null;
         this.grappleWall = false;
      }
   }
}
