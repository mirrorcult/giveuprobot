package jam
{
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.utils.Draw;
   
   public class EndLine extends Entity
   {
       
      
      private var level:Level;
      
      public function EndLine()
      {
         super();
         this.level = FP.world as Level;
         layer = 100000;
      }
      
      override public function render() : void
      {
         Draw.rect(this.level.width - 3,0,3,this.level.height,4473924);
         Draw.rect(this.level.width - 6,0,2,this.level.height,4473924);
         Draw.rect(this.level.width - 8,0,1,this.level.height,4473924);
      }
   }
}
