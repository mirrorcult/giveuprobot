package jam
{
   import net.flashpunk.Entity;
   import net.flashpunk.graphics.Spritemap;
   import net.flashpunk.FP;
   import net.flashpunk.utils.Draw;
   
   public class Block extends Entity
   {
      private var SprTiles:Spritemap;
      
      private static const ImgTiles:Class = Library.Block_ImgTiles;
      
      private static const Colors:Array = [4294901760,4294967040,4278255360,4278255615,4278190335,4294902015];
       
      
      protected var vCounter:Number = 0;
      
      public var grapple:Grapple;
      
      public var player:Player;
      
      protected var hCounter:Number = 0;
      
      public function Block(x:int, y:int, width:int, height:int)
      {
         super();
         this.x = x;
         this.y = y;
         this.width = width;
         this.height = height;
         type = "solid";
         this.graphic = SprTiles = new Spritemap(ImgTiles,8,8)
      }

      public function moveV(num:Number) : void
      {
         var move:int = 0;
         this.vCounter = this.vCounter + num;
         var go:int = Math.round(this.vCounter);
         this.vCounter = this.vCounter - go;
         if(go == 0)
         {
            return;
         }
         if(this.player && this.player.active)
         {
            if(go > 0)
            {
               if(collideWith(this.player,x,y - 1))
               {
                  y = y - 100000;
                  this.player.moveV(go);
                  y = y + 100000;
               }
               else if(collideWith(this.player,x,y + go))
               {
                  move = go - (this.player.y - this.player.originY - (y + height));
                  this.player.moveV(move,this.player.die);
               }
            }
            else if(collideWith(this.player,x,y + go))
            {
               move = go + (y - (this.player.y - this.player.originY + this.player.height));
               this.player.moveV(move,this.player.die);
            }
         }
         y = y + go;
         if(this.grapple)
         {
            this.grapple.move(0,go);
         }
      }

      protected function drawTiles(x:int, y:int) : void
      {
         // TODO ENGINE making this actually use tilemaps might speed up the game a lot. that would be nice.
         var j:int = 0;
         super.render();
         var ox:int = graphic.x;
         var oy:int = graphic.y;
         for(var i:int = 0; i < width; i = i + 8)
         {
            for(j = 0; j < height; j = j + 8)
            {
               // TODO ENGINE see if this works.
               SprTiles.frame = Math.floor((i + j * 3) / 8);
               graphic.x = ox + i;
               graphic.y = oy + j;
               super.render();
            }
         }
         graphic.x = ox;
         graphic.y = oy;
      }
      
      override public function render() : void
      {
         if(this is Saw || this is ElectricBlock)
         {
            super.render();
         }
         else
         {
            drawTiles(x, y);
         }
      }
      
      public function moveH(num:Number) : void
      {
         var sign:int = 0;
         var move:int = 0;
         this.hCounter = this.hCounter + num;
         var go:int = Math.round(this.hCounter);
         this.hCounter = this.hCounter - go;
         if(go == 0)
         {
            return;
         }
         if(this.player && this.player.active)
         {
            if(collideWith(this.player,x,y - 1))
            {
               this.player.moveH(go);
            }
            else if(collideWith(this.player,x + go,y))
            {
               sign = go > 0?1:-1;
               if(sign == 1)
               {
                  move = go - (this.player.x - this.player.originX - (x + width));
               }
               else
               {
                  move = go - (x - (this.player.x - this.player.originX + this.player.width));
               }
               this.player.moveH(move,this.player.die);
            }
         }
         x = x + go;
         if(this.grapple)
         {
            this.grapple.move(go,0);
         }
      }
      
      protected function particleBurst() : void
      {
         var j:int = 0;
         for(j = x; j < x + width; j = j + 4)
         {
            (FP.world as Level).createParticles(1,j,y + height,2,16777215,3,1,0.7,0.2,270,20,10,3);
            (FP.world as Level).createParticles(1,j,y,2,16777215,3,1,0.7,0.2,90,20,10,3);
         }
         for(j = y; j < y + height; j = j + 4)
         {
            (FP.world as Level).createParticles(1,x + width,j,2,16777215,3,1,0.7,0.2,0,20,10,3);
            (FP.world as Level).createParticles(1,x,j,2,16777215,3,1,0.7,0.2,180,20,10,3);
         }
      }
   }
}
