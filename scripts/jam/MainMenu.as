package jam
{
   import punk.Acrobat;
   import punk.Backdrop;
   import punk.Text;
   import punk.core.Alarm;
   import punk.core.Entity;
   import punk.core.Spritemap;
   
   public class MainMenu extends MenuWorld
   {
      
      private static const ImgMMG:Class = MainMenu_ImgMMG;
      
      private static const SprMMG:Spritemap = FP.getSprite(ImgMMG,90,32,false,false,45,16);
      
      private static const ImgFP:Class = MainMenu_ImgFP;
      
      private static const SprFP:Spritemap = FP.getSprite(ImgFP,89,31,false,false,45,15);
       
      
      private var presAlarm:Alarm;
      
      private var bg:Backdrop;
      
      private var sss:Number = 0;
      
      private var title:FlashingText;
      
      private var canGo:Boolean = true;
      
      private var toRemove:Vector.<Entity>;
      
      private var pres:uint = 0;
      
      private var presents:Text;
      
      public function MainMenu()
      {
         this.presAlarm = new Alarm(120,this.onPres,Alarm.PERSIST);
         super();
      }
      
      private function newGameNormal(m:MenuButton = null) : void
      {
         Stats.resetStats();
         Stats.saveData.mode = 0;
         if(Stats.exists())
         {
            this.gotoMenuConfirm();
         }
         else
         {
            this.newGame();
         }
      }
      
      override public function update() : void
      {
         super.update();
         this.sss = (this.sss + Math.PI / 16) % (Math.PI * 8);
         this.title.angle = Math.sin(this.sss / 4) * 10;
         this.title.scaleX = this.title.scaleY = Math.sin(this.sss / 2) * 0.2 + 0.8;
      }
      
      private function clearMenu() : void
      {
         removeVector(this.toRemove);
         this.toRemove = new Vector.<Entity>();
      }
      
      override public function init() : void
      {
         var a:Acrobat = null;
         super.init();
         addAlarm(this.presAlarm);
         this.presents = new Text("Adult Swim Games Presents",160,40);
         this.presents.color = 6710886;
         this.presents.depth = 1050;
         this.presents.size = 16;
         this.presents.center();
         add(this.presents);
         this.title = new FlashingText("Give Up, ROBOT",160,64);
         this.title.size = 36;
         this.title.depth = 1000;
         this.title.center();
         add(this.title);
         a = new Acrobat();
         a.sprite = DiscoBall.SprBall;
         a.scaleX = 4;
         a.scaleY = 4;
         a.alpha = 0.1;
         a.delay = 6;
         a.depth = 1000;
         a.x = 160;
         a.y = 120;
         add(a);
         a = new Acrobat();
         a.sprite = SprMMG;
         a.color = 16777215;
         a.x = 46;
         a.y = 223;
         a.scaleX = 1;
         a.scaleY = 1;
         add(a);
         a = new Acrobat();
         a.sprite = SprFP;
         a.color = 16777215;
         a.x = 274;
         a.y = 224;
         a.scaleX = 1;
         a.scaleY = 1;
         add(a);
         FP.musicPlay(Assets.MusMenu);
         this.toRemove = new Vector.<Entity>();
         this.gotoMenuMain();
      }
      
      private function toggleTimer(m:MenuButton) : void
      {
         Assets.timer = !Assets.timer;
         if(Assets.timer)
         {
            m.text = "Game Timer: On";
         }
         else
         {
            m.text = "Game Timer: Off";
         }
         m.center();
      }
      
      private function loadStats(m:MenuButton = null) : void
      {
         if(!Stats.exists() || !this.canGo)
         {
            return;
         }
         Stats.load();
         this.gotoMenuContinue();
      }
      
      private function gotoMenuOptions(m:MenuButton = null) : void
      {
         this.clearMenu();
         this.toRemove.push(add(new MenuButton("Music: " + (FP.musicVolume * 100).toFixed(0) + "%",160,100,this.musicVolume)));
         this.toRemove.push(add(new MenuButton("Sounds: " + (FP.soundVolume * 100).toFixed(0) + "%",160,120,this.soundVolume)));
         this.toRemove.push(add(new MenuButton("Particles: " + (!!Assets.particles?"On":"Off"),160,140,this.toggleParticles)));
         this.toRemove.push(add(new MenuButton("Game Timer: " + (!!Assets.timer?"On":"Off"),160,160,this.toggleTimer)));
         this.toRemove.push(add(new MenuButton("Back",160,200,this.gotoMenuMain)));
      }
      
      private function gotoMenuCredits(m:MenuButton = null) : void
      {
         var t:Text = null;
         this.clearMenu();
         this.title.visible = false;
         this.presents.visible = false;
         t = new Text("graphics, audio,",160,22);
         t.size = 8;
         t.color = 16777215;
         t.center();
         this.toRemove.push(add(t));
         t = new Text("programming and design by",160,28);
         t.size = 8;
         t.color = 16777215;
         t.center();
         this.toRemove.push(add(t));
         t = new Text("Matt Thorson",160,40);
         t.size = 16;
         t.color = 16777215;
         t.center();
         this.toRemove.push(add(t));
         t = new Text("with additional graphics,",160,60);
         t.size = 8;
         t.color = 16777215;
         t.center();
         this.toRemove.push(add(t));
         t = new Text("design and testing by",160,66);
         t.size = 8;
         t.color = 16777215;
         t.center();
         this.toRemove.push(add(t));
         t = new Text("Coriander Dickinson",160,78);
         t.size = 16;
         t.color = 16777215;
         t.center();
         this.toRemove.push(add(t));
         t = new Text("and voices by",160,98);
         t.size = 8;
         t.color = 16777215;
         t.center();
         this.toRemove.push(add(t));
         t = new Text("Rachel Williamson",160,110);
         t.size = 16;
         t.color = 16777215;
         t.center();
         this.toRemove.push(add(t));
         t = new Text("based on a prototype",160,130);
         t.size = 8;
         t.color = 16777215;
         t.center();
         this.toRemove.push(add(t));
         t = new Text("developed at",160,138);
         t.size = 8;
         t.color = 16777215;
         t.center();
         this.toRemove.push(add(t));
         t = new Text("Edmonton Game Jam 2010",160,150);
         t.size = 16;
         t.color = 16777215;
         t.center();
         this.toRemove.push(add(t));
         t = new Text("presented by",160,170);
         t.size = 8;
         t.color = 16777215;
         t.center();
         this.toRemove.push(add(t));
         t = new Text("Adult Swim Games",160,182);
         t.size = 16;
         t.color = 16777215;
         t.center();
         this.toRemove.push(add(t));
         this.toRemove.push(add(new MenuButton("Back",160,220,this.gotoMenuMain)));
      }
      
      private function musicVolume(m:MenuButton) : void
      {
         if(FP.musicVolume == 0)
         {
            FP.musicVolume = 1;
         }
         else
         {
            FP.musicVolume = FP.musicVolume - 0.25;
         }
         if(FP.musicVolume == 0)
         {
            m.text = "Music: Off";
         }
         else
         {
            m.text = "Music: " + (FP.musicVolume * 100).toFixed(0) + "%";
         }
         m.center();
      }
      
      private function soundVolume(m:MenuButton) : void
      {
         if(FP.soundVolume == 0)
         {
            FP.soundVolume = 1;
         }
         else
         {
            FP.soundVolume = FP.soundVolume - 0.25;
         }
         if(FP.soundVolume == 0)
         {
            m.text = "Sounds: Off";
         }
         else
         {
            m.text = "Sounds: " + (FP.soundVolume * 100).toFixed(0) + "%";
         }
         m.center();
      }
      
      private function gotoMenuContinue(m:MenuButton = null) : void
      {
         var t:Text = null;
         this.clearMenu();
         t = new Text(Assets.NAMES[Stats.saveData.mode] + " Mode",160,120);
         t.size = 16;
         t.color = 16777215;
         t.center();
         this.toRemove.push(add(t));
         t = new Text("Level " + Stats.saveData.levelNum,160,135);
         t.size = 8;
         t.color = 16777215;
         t.center();
         this.toRemove.push(add(t));
         t = new Text(Stats.saveData.deaths + " Deaths",160,145);
         t.size = 8;
         t.color = 16777215;
         t.center();
         this.toRemove.push(add(t));
         t = new Text(Stats.saveData.formattedTime,160,155);
         t.size = 8;
         t.color = 16777215;
         t.center();
         this.toRemove.push(add(t));
         this.toRemove.push(add(new MenuButton("Continue",160,180,this.loadGame)));
         this.toRemove.push(add(new MenuButton("Cancel",160,200,this.gotoMenuMain)));
      }
      
      private function moreGames(m:MenuButton = null) : void
      {
         Main.link("menu");
      }
      
      private function onPres() : void
      {
         if(!this.canGo)
         {
            return;
         }
         if(this.pres == 0)
         {
            FP.play(Assets.VcPresents,Assets.VCVOL);
            this.presAlarm.totalFrames = 140;
            this.presAlarm.start();
            this.pres++;
         }
         else if(this.pres == 1)
         {
            FP.play(Assets.VcBestEver,Assets.VCVOL);
            removeAlarm(this.presAlarm);
         }
      }
      
      private function newGame(m:MenuButton = null) : void
      {
         if(!this.canGo)
         {
            return;
         }
         if(Stats.saveData.mode == 0)
         {
            FP.play(Assets.SndNewGame);
         }
         else
         {
            FP.play(Assets.SndHardGame);
         }
         this.canGo = false;
         FP.musicStop();
         add(new FuzzTransition(FuzzTransition.MENU,Intro,true));
      }
      
      private function loadGame(m:MenuButton = null) : void
      {
         if(!this.canGo)
         {
            return;
         }
         if(Stats.saveData.mode == 0)
         {
            FP.play(Assets.SndNewGame);
         }
         else
         {
            FP.play(Assets.SndHardGame);
         }
         this.canGo = false;
         Assets.playLoad();
         FP.musicPlay(Assets.MusGame);
         add(new FuzzTransition(FuzzTransition.LOAD));
      }
      
      private function toggleParticles(m:MenuButton) : void
      {
         Assets.particles = !Assets.particles;
         if(Assets.particles)
         {
            m.text = "Particles: On";
         }
         else
         {
            m.text = "Particles: Off";
         }
         m.center();
      }
      
      private function gotoMenuMain(m:MenuButton = null) : void
      {
         var t:Text = null;
         this.clearMenu();
         this.title.visible = true;
         this.presents.visible = true;
         this.toRemove.push(add(new MenuButton("New Game",160,120,this.newGameNormal)));
         if(Stats.haveHardMode())
         {
            this.toRemove.push(add(new MenuButton("New HARD Game",160,140,this.newGameHard)));
         }
         else
         {
            t = new Text("New HARD Game",160,140);
            t.color = 3355443;
            t.size = 16;
            t.center();
            this.toRemove.push(add(t));
         }
         if(Stats.exists())
         {
            this.toRemove.push(add(new MenuButton("Continue",160,160,this.loadStats)));
         }
         else
         {
            t = new Text("Continue",160,160);
            t.color = 3355443;
            t.size = 16;
            t.center();
            this.toRemove.push(add(t));
         }
         this.toRemove.push(add(new MenuButton("Options",160,190,this.gotoMenuOptions)));
         this.toRemove.push(add(new MenuButton("Credits",160,210,this.gotoMenuCredits)));
         this.toRemove.push(add(new MenuButton("More Games",160,230,this.moreGames)));
      }
      
      private function newGameHard(m:MenuButton = null) : void
      {
         Stats.resetStats();
         Stats.saveData.mode = 1;
         if(Stats.exists())
         {
            this.gotoMenuConfirm();
         }
         else
         {
            this.newGame();
         }
      }
      
      private function gotoMenuConfirm(m:MenuButton = null) : void
      {
         this.clearMenu();
         var t:Text = new Text("Are You Sure?",160,120);
         t.size = 24;
         t.color = 16777215;
         t.center();
         this.toRemove.push(add(t));
         t = new Text("Current savefile will be deleted!",160,140);
         t.size = 16;
         t.color = 16777215;
         t.center();
         this.toRemove.push(add(t));
         this.toRemove.push(add(new MenuButton("Do It!",160,180,this.newGame)));
         this.toRemove.push(add(new MenuButton("Cancel",160,200,this.gotoMenuMain)));
      }
   }
}
