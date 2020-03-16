package punk
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import punk.core.Entity;
   import punk.core.Spritemap;
   
   public class Actor extends Entity
   {
       
      
      public var delay:int = 1;
      
      var _zero:Point;
      
      var _rect:Rectangle;
      
      public var flipX:Boolean = false;
      
      public var flipY:Boolean = false;
      
      var _count:int = 0;
      
      public var anim:Function = null;
      
      var _image:int = 0;
      
      public var loop:Boolean = true;
      
      var _matrix:Matrix;
      
      var _point:Point;
      
      var _sprite:Spritemap = null;
      
      public function Actor()
      {
         this._rect = new Rectangle();
         this._point = FP.point;
         this._zero = FP.zero;
         this._matrix = FP.matrix;
         super();
      }
      
      public function get sprite() : Spritemap
      {
         return this._sprite;
      }
      
      public function set sprite(value:Spritemap) : void
      {
         if(!this._sprite && !width && !height)
         {
            width = value.width;
            height = value.height;
         }
         this._sprite = value;
         this._image = this._image % this._sprite.number;
         this._rect.width = this._sprite.imageW;
         this._rect.height = this._sprite.imageH;
      }
      
      public function updateImage(totalFrames:int = 0) : void
      {
         if(!this.delay)
         {
            return;
         }
         this._count++;
         if(this._count >= this.delay)
         {
            this._count = 0;
            this._image++;
            if(this._image == totalFrames)
            {
               this._image = !!this.loop?0:int(this._image - 1);
               if(!§§pop())
               {
                  this.anim();
               }
            }
         }
      }
      
      override public function render() : void
      {
         if(!this._sprite)
         {
            return;
         }
         this._rect.x = !!this.flipX?Number(this._sprite.imageR - this._image * this._sprite.imageW):Number(this._image * this._sprite.imageW);
         this._rect.y = !!this.flipY?Number(this._sprite.imageB):Number(0);
         this._point.x = x - this._sprite.originX - FP.camera.x;
         this._point.y = y - this._sprite.originY - FP.camera.y;
         FP.screen.copyPixels(this.sprite,this._rect,this._point);
         if(!this.delay)
         {
            return;
         }
         this._count++;
         if(this._count >= this.delay)
         {
            this._count = 0;
            this._image++;
            if(this._image == this._sprite.number)
            {
               this._image = !!this.loop?0:int(this._image - 1);
               if(!§§pop())
               {
                  this.anim();
               }
            }
         }
      }
      
      public function get image() : int
      {
         return this._image;
      }
      
      public function set image(value:int) : void
      {
         this._image = value % this._sprite.number;
      }
   }
}
