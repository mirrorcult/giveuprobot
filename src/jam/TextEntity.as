package jam
{
   import net.flashpunk.graphics.Spritemap;
   import net.flashpunk.Entity;
   import net.flashpunk.graphics.Text;
   
   // this doesn't really feel right. but thats ok
   public class TextEntity extends Entity
   {
      public function TextEntity(text:Text, layer:int=0)
      {
         super(0,0,text);
         this.layer = layer;
      }
   }
}