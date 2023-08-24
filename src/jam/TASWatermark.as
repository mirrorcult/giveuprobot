package jam
{
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.graphics.Text;
   import net.flashpunk.utils.Input;
   
   public class TASWatermark extends Entity
   {
      private var text:Text;
      
      public function TASWatermark()
      {
         super(0,0);
         Text.size = 8;
         graphic = this.text = new Text("> PLAYER <", 160, 235);
         this.text.scrollX = this.text.scrollY = 0;
         this.text.centerOO();
         this.text.color = 16777215;
         layer = Layer.ABOVE_ALL;
      }

      public function updateState() : void
      {
         if (FP.tas._playingBack)
         {
            this.text.text = "> TAS <";
         }
         else
         {
            this.text.text = "> PLAYER <";
         }
         this.text.centerOO();
      }
   }
}