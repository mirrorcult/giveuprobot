package jam
{
   import net.flashpunk.graphics.Spritemap;
   import net.flashpunk.Entity;
   import net.flashpunk.graphics.Text;
   
   // copied from gur2 more or less
   public class Title extends Entity
   {
      private var sine:Number;
      private var angleChange:Boolean;
      public var text:Text;

      public function Title(size:int, str:String, x:int, y:int, active:Boolean = true, color:uint = 0xFFFFFF, angleChange:Boolean = false)
      {
         super(x,y);
         this.active = active;
         Text.size = size;
         graphic = this.text = new Text(str);
         this.text.color = color;
         this.text.centerOO();
         this.sine = Math.random() * Math.PI * 2;
      }
      
      override public function update() : void
      {
         super.update();

         if (!angleChange)
            return;
         
         this.sine = (this.sine + Math.PI / 64) % (Math.PI * 2);
         this.text.angle = Math.sin(this.sine) * 6;
      }
   }
}