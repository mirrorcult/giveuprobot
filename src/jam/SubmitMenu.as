package jam
{
   import net.flashpunk.graphics.Text;
   import net.flashpunk.tweens.misc.Alarm;
   import net.flashpunk.utils.Input;
   import net.flashpunk.Tween;
   import net.flashpunk.FP;
   import net.flashpunk.Sfx;
   
   public class SubmitMenu extends MenuWorld
   {
       
      
      private var draw:uint;
      
      private var num:uint = 0;
      
      private const TEXT_SMALLSEP:uint = 14;
      
      private const WAIT_LONG:uint = 80;
      
      private var alarm:Alarm;
      
      private var score:int;
      
      private var canGo:Boolean = false;
      
      private var timeText:Text;
      
      private const TEXT_BIGSEP:uint = 24;
      
      private var scoreText:Text;
      
      private const WAIT_SHORT:uint = 40;
      
      private var aScore:Alarm;
      
      private var partsAt:uint;
      
      private var scoreDraw:uint = 0;
      
      private const TEXT_START:uint = 42;
      
      private var menuCont:MenuButton;
      
      private var levelsText:Text;
      
      public function SubmitMenu()
      {
         this.alarm = new Alarm(120,this.onAlarm,Tween.PERSIST);
         this.aScore = new Alarm(this.WAIT_SHORT,this.onCount,Tween.PERSIST);
         this.draw = this.TEXT_START;
         super();
      }
      
      private function particleBurst(y:int, num:int = 40) : void
      {
         var ax:int = 0;
         for(var i:int = 0; i < num; i++)
         {
            ax = FP.choose(-30,-20,-10,0,10,20,30);
            (FP.world as MenuWorld).createParticles(1,160 + ax,y,10,0xFFFFFF,2,1,1.5,0.5,0,180,12,4);
         }
      }
      
      override public function update() : void
      {
         super.update();
         if(this.timeText && this.timeText.scaleX > 1)
         {
            this.timeText.scaleY = this.timeText.scaleX = this.timeText.scaleX - 0.05;
         }
         if(this.scoreText && this.scoreText.scaleX > 1)
         {
            this.scoreText.scaleY = this.scoreText.scaleX = this.scoreText.scaleX - 0.05;
         }
         if(this.levelsText && this.levelsText.scaleX > 1)
         {
            this.levelsText.scaleY = this.levelsText.scaleX = this.levelsText.scaleX - 0.05;
         }
         if(this.menuCont && Input.pressed("skip"))
         {
            this.cont(null);
         }
      }
      
      override public function begin() : void
      {
         super.begin();
         FP.camera.x = 0;
         FP.camera.y = 0;
         Assets.musicVolume = Assets.musicVolume / 2;
         this.score = (Stats.saveData.levelNum * (Stats.saveData.mode == 0?40000:90000) - Stats.saveData.time) * 10;
         this.score = Math.max(this.score,0);
         Stats.saveData.levelNum++;
         if(Stats.saveData.levelNum < Assets.TOTAL_LEVELS[Stats.saveData.mode])
         {
            Stats.save();
         }
         addTween(this.alarm, true);
         addTween(this.aScore,false);
         add(new Title(16, "Scoring Time", 160, 20));
      }
      
      private function onCount() : void
      {
         if(this.scoreDraw < this.score)
         {
            new Sfx(Assets.SndWin).play();
            var sfx:Sfx = new Sfx(Assets.SndWin);
            new Sfx(Assets.SndWin).play();
            this.particleBurst(this.partsAt,20);
            this.scoreDraw = this.scoreDraw + Math.max(1007,Math.ceil((this.score - this.scoreDraw) / 6));
            this.scoreDraw = Math.min(this.scoreDraw,this.score);
            if(this.score >= 1000000)
            {
               this.scoreText.text = String(Math.floor(this.scoreDraw / 1000000)) + "," + this.digits(Math.floor(this.scoreDraw % 1000000 / 1000)) + "," + this.digits(this.scoreDraw % 1000);
            }
            else if(this.score >= 1000)
            {
               this.scoreText.text = String(Math.floor(this.scoreDraw / 1000)) + "," + this.digits(this.scoreDraw % 1000);
            }
            else
            {
               this.scoreText.text = this.digits(this.scoreDraw);
            }
            this.scoreText.scaleX = this.scoreText.scaleY = 1.3 + Math.random() * 0.4;
            this.scoreText.centerOO();
            if(this.scoreDraw == this.score)
            {
               removeTween(this.aScore);
               this.alarm.start();
            }
            else
            {
               this.aScore.reset(5);
            }
         }
      }
      
      private function digits(num:uint, digits:uint = 2) : String
      {
         var lead:String = "";
         for(var i:int = digits; i > 0; )
         {
            if(num < Math.pow(10,i))
            {
               lead = "0" + lead;
               i--;
               continue;
            }
            break;
         }
         return lead + String(num);
      }
      
      private function onAlarm() : void
      {
         var t:String = null;
         var title:Title = null;
         var m:MenuButton = null;
         if(this.num == 0)
         {
            if(Stats.saveData.levelNum >= Assets.TOTAL_LEVELS[Stats.saveData.mode])
            {
               t ="Your Total Time Was..."
            }
            else
            {
               t = "Your Total Time So Far Is...";
            }

            add(new Title(8, t, 160,this.draw));
            this.alarm.reset(this.WAIT_SHORT);
            this.draw = this.draw + this.TEXT_SMALLSEP;
         }
         else if(this.num == 1)
         {
            new Sfx(Assets.SndRank6).play();
            this.particleBurst(this.draw);
            title = new Title(24, Stats.saveData.formattedTime, 160, this.draw);
            this.timeText = title.text;
            this.timeText.scaleX = this.timeText.scaleY = 1.5;
            add(title);
            this.alarm.reset(this.WAIT_LONG);
            this.draw = this.draw + this.TEXT_BIGSEP;
         }
         else if(this.num == 2)
         {
            if(Stats.saveData.levelNum >= Assets.TOTAL_LEVELS[Stats.saveData.mode])
            {
               t = "And You Completed...";
            }
            else
            {
               t = "And You\'ve Completed...";
            }
            add(new Title(8, t, 160,this.draw));
            this.alarm.reset(this.WAIT_SHORT);
            this.draw = this.draw + this.TEXT_SMALLSEP;
         }
         else if(this.num == 3)
         {
            new Sfx(Assets.SndRank6).play();
            this.particleBurst(this.draw);
            title = new Title(24, Stats.saveData.levelNum - 1 + " Levels",160,this.draw);
            this.levelsText = title.text;
            this.levelsText.scaleX = this.levelsText.scaleY = 1.5;
            add(title);
            this.alarm.reset(this.WAIT_LONG);
            this.draw = this.draw + this.TEXT_BIGSEP;
         }
         else if(this.num == 4)
         {
            add(new Title(8, "Which gives you a score of...",160,this.draw));
            this.alarm.reset(this.WAIT_SHORT);
            this.draw = this.draw + this.TEXT_SMALLSEP;
         }
         else if(this.num == 5)
         {
            new Sfx(Assets.SndRank6).play();
            this.particleBurst(this.draw);
            this.partsAt = this.draw;

            title = new Title(24, "0", 160, this.draw);
            this.scoreText = title.text;
            this.scoreText.scaleX = this.scoreText.scaleY = 1.5;
            add(title);
            
            this.aScore.start();
            this.draw = this.draw + 48;
         }
         else if(this.num == 6)
         {
            new Sfx(Assets.SndWin).play();
            this.particleBurst(165);
            this.particleBurst(195);
            if(Stats.saveData.levelNum >= Assets.TOTAL_LEVELS[Stats.saveData.mode])
            {
               this.menuCont = new MenuButton("Done",160,this.draw + 32,this.cont);
            }
            else
            {
               this.menuCont = new MenuButton("Onward!",160,this.draw + 32,this.cont);
            }
            add(this.menuCont);
         }
         this.num++;
      }
      
      private function cont(m:MenuButton) : void
      {
         new Sfx(Assets.SndWin).play();
         if(Stats.saveData.levelNum >= Assets.TOTAL_LEVELS[Stats.saveData.mode])
         {
            Assets.playBye();
            add(new FuzzTransition(FuzzTransition.MENU,MainMenu));
         }
         else
         {
            add(new FuzzTransition(FuzzTransition.NEW,null,false,Stats.saveData.levelNum));
         }
         Assets.musicVolume = Assets.musicVolume * 2;
         remove(this.menuCont);
         this.menuCont = null;
      }
   }
}
