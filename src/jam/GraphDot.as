package jam
{
   import net.flashpunk.Entity;
   import net.flashpunk.FP;
   import net.flashpunk.utils.Draw;
   
   public class GraphDot extends Entity
   {
       
      
      public var gotoY:uint;
      
      public function GraphDot()
      {
         super();
      }
      
      override public function update() : void
      {
         y = FP.approach(y,this.gotoY,Math.max(0.5,Math.abs(y - this.gotoY) / 4));
      }
      
      override public function render() : void
      {
         Draw.rect(x - 1,y - 1,2,2,(FP.world as StatsMenu).color);
      }
   }
}
