package jam
{
   import net.flashpunk.graphics.Spritemap;
   import net.flashpunk.Entity;
   import net.flashpunk.graphics.Text;
   import net.flashpunk.graphics.Backdrop;
   
   // this doesn't really feel right. but thats ok
   public class BGEntity extends Entity
   {
      public function BGEntity(bg:Backdrop)
      {
         super(0,0,bg);
         this.layer = 1000000000;
      }
   }
}