package jam
{
   import net.flashpunk.graphics.Text;
   import net.flashpunk.tweens.misc.Alarm;
   import net.flashpunk.utils.Input;
   import net.flashpunk.Tween;
   import net.flashpunk.FP;
   import net.flashpunk.Sfx;
   
   public class EndMenu extends MenuWorld
   {
       
      
      private var rank:uint;
      
      private var alarm:Alarm;
      
      private const REQS:Array = [160,100,50,25,10];
      
      private var drawn:uint = 0;
      
      private var balls:Vector.<DiscoBall>;
      
      private var canGo:Boolean = false;
      
      public function EndMenu()
      {
         this.alarm = new Alarm(120,this.cont,Tween.PERSIST);
         super();
         addTween(this.alarm, true);
         // TODO engine handle music properly like gur2 does
         Assets.setMusic();
         this.rank = 1;
         for(var i:int = 0; i < this.REQS.length; i++)
         {
            if(Stats.saveData.deaths <= this.REQS[i])
            {
               this.rank++;
            }
         }
         this.balls = new Vector.<DiscoBall>();
      }
      
      override public function update() : void
      {
         super.update();
         if(this.canGo && Input.pressed("skip"))
         {
            var sfx:Sfx = new Sfx(Assets.SndWin());
            sfx.play();
            add(new FuzzTransition(FuzzTransition.MENU,StatsMenu));
            this.canGo = false;
         }
      }
      
      private function cont() : void
      {
         var t:Text = null;
         if(this.drawn == 0)
         {
            add(new Title(36, "Good Job ROBOT!!", 160, 24, true, 0xFFFFFF, true));
            this.alarm.start();
         }
         else if(this.drawn == 1)
         {
            add(new Title(16, "Your rank is...", 160, 48, true, 0xFFFFFF, true));
            this.alarm.start();
         }
         else if(this.drawn < this.rank + 2)
         {
            this.balls[this.drawn - 2].start();
            var sfx:Sfx = new Sfx(Assets["SndRank" + (this.drawn - 1)]);
            sfx.play();
            this.alarm.reset(60);
         }
         else
         {
            add(new Title(16, "Press Enter!", 160, 224, true, 0xFFFFFF, true));
            this.canGo = true;
         }
         this.drawn++;
      }
      
      override public function begin() : void
      {
         super.begin();
         FP.camera.x = 0;
         FP.camera.y = 0;
         for(var i:int = 0; i < 6; i++)
         {
            this.balls.push(add(new DiscoBall(80 + 80 * (i % 3),96 + Math.floor(i / 3) * 80)) as DiscoBall);
         }
      }
   }
}
