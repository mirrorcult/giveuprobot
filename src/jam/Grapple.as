package jam
{
   import flash.geom.Point;
   import net.flashpunk.Entity;
   import net.flashpunk.Entity;
   import net.flashpunk.graphics.Spritemap;
   import net.flashpunk.utils.Input;
   import net.flashpunk.FP;
   import net.flashpunk.Sfx;
   
   public class Grapple extends Entity
   {
      
      private var SprGrapple:Spritemap;
      
      private static const ImgGrapple:Class = Library.Grapple_ImgGrapple;
      
      
      private var changedRad:int = 0;
      
      private var level:Level;
      
      private var direction:Number;
      
      private var wall:Block;
      
      private var dir:int;
      
      private const SAW_MOMENTUM:Number = 5.0;
      
      private var radius:Number;
      
      private var momentum:Number = 0;
      
      private var player:Player;
      
      private const SWING:Number = 0.1;
      
      private const RADIUS_UP:Number = 1.0;
      
      private const FRIC:Number = 0.025;
      
      private const GRAVITY:Number = 0.15;
      
      private const RADIUS_DOWN:Number = 1.5;
      
      private const MAX_MOMENTUM:Number = 2.5;
      
      private const MAX_RADIUS:Number = 128;
      
      private const MAX_PMOVE:Number = 9.0;
      
      private var goBack:Boolean = false;
      
      private const MOVE_SPEED:uint = 5;
      
      private var hitWall:Boolean = false;
      
      private const MIN_RADIUS:Number = 16;
      
      public function Grapple(level:Level, player:Player, x:int, y:int, dir:int)
      {
         super();
         this.level = level;
         this.player = player;
         this.x = x;
         this.y = y;
         this.dir = dir;
         width = 6;
         height = 6;
         originX = 3;
         originY = 3;
         layer = -1000;
         graphic = SprGrapple = new Spritemap(ImgGrapple,4,4);
         SprGrapple.scaleX = 3;
         SprGrapple.scaleY = 3;
         SprGrapple.frame = 0;
         SprGrapple.rate = 0;
      }
      
      private function onHitWallSaw(b:Block = null) : void
      {
         this.direction = this.direction - this.momentum;
         this.momentum = 0;
         if(b is ElectricBlock || b is Saw)
         {
            this.player.die();
         }
         this.radius = this.radius - 2;
      }
      
      public function kill() : void
      {
         var color:uint = 0;
         var p:Point = new Point;
         if(this.hitWall)
         {
            color = 65535;
         }
         else
         {
            color = 16776960;
         }
         this.radius = FP.distance(x,y,this.player.x,this.player.y - 10);
         this.direction = FP.angle(x,y,this.player.x,this.player.y - 10);
         var j:int = 0;
         for(var i:int = this.radius; i > 0; i = i - 6)
         {
            FP.angleXY(p, this.direction,i);
            this.level.createParticles(1,x + p.x,y + p.y,1,color,2,1,0.2,0.1,0,180,6,2,j);
            j = j + 2;
         }
         this.level.createParticles(6,x,y,4,color,3,1,0.4,0.2,0,180,30,10);
         this.destroy(false);
      }
      
      override public function render() : void
      {
         SprGrapple.angle = FP.angle(this.player.x,this.player.y,x,y) - 90;
         super.render();
      }
      
      private function onHitWall(b:Block = null) : void
      {
         this.direction = this.direction - this.momentum;
         this.momentum = 0;
         if(b is ElectricBlock || b is Saw)
         {
            this.player.die();
         }
      }
      
      public function move(h:Number, v:Number) : void
      {
         x = x + h;
         y = y + v;
         this.player.moveH(h);
         this.player.moveV(v);
      }
      
      public function destroy(parts:Boolean = true) : void
      {
         var color:uint = 0;
         var i:int = 0;
         var p:Point = new Point;
         if(parts)
         {
            if(this.hitWall)
            {
               color = 65535;
            }
            else
            {
               color = 16776960;
            }
            for(i = this.radius; i > 0; i = i - 6)
            {
               FP.angleXY(p, this.direction,i);
               this.level.createParticles(1,x + p.x,y + p.y,1,color,3,1,0.2,0.1,0,180,12,2);
            }
         }
         if(this.hitWall)
         {
            var sfx:Sfx = new Sfx(Assets.SndDrop);
            sfx.play();
         }
         FP.world.remove(this);
         this.player.removeGrapple();
         if(this.wall)
         {
            this.wall.grapple = null;
         }
      }
      
      override public function update() : void
      {
         var p:Point = new Point;
         var obj:Entity = null;
         var onSaw:Boolean = false;
         var mx:Number = NaN;
         var my:Number = NaN;
         var s:Number = NaN;
         if(!this.hitWall)
         {
            if(this.goBack)
            {
               FP.angleXY(p, FP.angle(x,y,this.player.x,this.player.y),this.MOVE_SPEED * Math.SQRT2);
               x = x + p.x;
               y = y + p.y;
               if(collideWith(this.player,x,y))
               {
                  this.destroy();
               }
            }
            else
            {
               x = x + this.MOVE_SPEED * this.dir;
               y = y - this.MOVE_SPEED;
               if(FP.distance(x,y,this.player.x,this.player.y) > this.MAX_RADIUS)
               {
                  this.goBack = true;
               }
            }
            if((obj = collide("solid",x,y)) != null && (obj.x >= 0 && obj.y >= 0 || obj is MovingPlat))
            {
               SprGrapple.frame = 1;
               this.player.onGrappleHitWall();
               this.radius = FP.distance(x,y,this.player.x,this.player.y);
               this.direction = FP.angle(x,y,this.player.x,this.player.y);
               this.hitWall = true;
               this.wall = obj as Block;
               this.wall.grapple = this;
               if(obj is Saw)
               {
                  var sfx:Sfx = new Sfx(Assets.SndGrappleSaw);
                  sfx.play();
               }
               else if(obj is ElectricBlock)
               {
                  var sfxe:Sfx = new Sfx(Assets.SndGrappleElec);
                  sfxe.play();
               }
               else
               {
                  var sfxg:Sfx = new Sfx(Assets.SndGrapple);
                  sfxg.play();
               }
               if(this.wall is Saw)
               {
                  x = this.wall.x + 8;
                  y = this.wall.y + 8;
               }
               this.level.createParticles(6,x,y,4,65535,3,2,0.8,0.3,0,180,25,5);
            }
         }
         else
         {
            onSaw = false;
            if(this.wall is Saw)
            {
               var sd:Saw = this.wall as Saw;
               onSaw = true;
               this.momentum = this.SAW_MOMENTUM * (sd.SprSaw.flipped ?1:-1);
               this.level.screenShake(4,1);
            }
            else
            {
               if(this.direction < 270 && this.direction > 90)
               {
                  this.momentum = Math.min(this.momentum + this.GRAVITY,this.MAX_MOMENTUM);
               }
               else
               {
                  this.momentum = Math.max(this.momentum - this.GRAVITY,-this.MAX_MOMENTUM);
               }
               if(Input.check("right"))
               {
                  if(this.direction > 260 && this.direction < 280)
                  {
                     s = this.SWING * 3;
                  }
                  else
                  {
                     s = this.SWING;
                  }
                  this.momentum = Math.min(this.momentum + s,this.MAX_MOMENTUM);
               }
               else if(Input.check("left"))
               {
                  if(this.direction > 260 && this.direction < 280)
                  {
                     s = this.SWING * 3;
                  }
                  else
                  {
                     s = this.SWING;
                  }
                  this.momentum = Math.max(this.momentum - s,-this.MAX_MOMENTUM);
               }
               else if(this.direction > 260 && this.direction < 280)
               {
                  this.momentum = FP.approach(this.momentum,0,this.FRIC);
               }
            }
            if(Input.check("up"))
            {
               this.radius = Math.max(this.MIN_RADIUS,this.radius - this.RADIUS_UP);
            }
            else if(Input.check("down"))
            {
               this.radius = Math.min(this.MAX_RADIUS,this.radius + this.RADIUS_DOWN);
            }
            this.direction = this.direction + this.momentum;
            FP.angleXY(p, this.direction,this.radius);
            mx = p.x + x - this.player.x;
            my = p.y + y - this.player.y;
            mx = Math.min(Math.max(mx,-this.MAX_PMOVE),this.MAX_PMOVE);
            my = Math.min(Math.max(my,-this.MAX_PMOVE),this.MAX_PMOVE);
            this.player.moveH(mx,!!onSaw?this.onHitWallSaw:this.onHitWall);
            if(!this.player)
            {
               return;
            }
            this.player.moveV(my,!!onSaw?this.onHitWallSaw:this.onHitWall);
            if(!this.player)
            {
               return;
            }
            this.player.hSpeed = mx;
            this.player.vSpeed = my;
         }
      }
   }
}
