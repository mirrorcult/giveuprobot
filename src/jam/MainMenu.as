package jam
{
   import net.flashpunk.Entity;
   import net.flashpunk.graphics.Backdrop;;
   import net.flashpunk.graphics.Text;
   import net.flashpunk.tweens.misc.Alarm;
   import net.flashpunk.Entity;
   import net.flashpunk.graphics.Spritemap;
   import net.flashpunk.FP;
   import net.flashpunk.Tween;
   import net.flashpunk.Sfx;
   
   public class MainMenu extends MenuWorld
   {
      
      private static const ImgMMG:Class = MainMenu_ImgMMG;
      
      private var SprMMG:Spritemap;
      
      private static const ImgFP:Class = MainMenu_ImgFP;
      
      private var SprFP:Spritemap;
       
      
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
         SprMMG = new Spritemap(ImgMMG,90,32);
         SprFP = new Spritemap(ImgFP,89,31);
         SprFP.originX = 45;
         SprFP.originY = 15;
         this.presAlarm = new Alarm(120,this.onPres,Tween.PERSIST);
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
         removeList(this.toRemove);
         this.toRemove = new Vector.<Entity>();
      }
      
      override public function begin() : void
      {
         var a:Entity = null;
         super.begin();
         addTween(this.presAlarm);
         this.presents = new Text("Adult Swim Games Presents",160,40);
         this.presents.color = 6710886;
         this.presents.size = 16;
         this.presents.centerOO();
         add(new TextEntity(this.presents, 1050));
         this.title = new FlashingText("Give Up, ROBOT",160,64);
         this.title.size = 36;
         this.title.centerOO();
         add(new TextEntity(this.title, 1000));
         a = new Entity();
         var spr:Spritemap = new Spritemap(DiscoBall.ImgBall,64,64);
         a.graphic = new Spritemap(DiscoBall.ImgBall,64,64);
         spr.scaleX = 4;
         spr.scaleY = 4;
         spr.alpha = 0.1;
         spr.rate = 6;
         a.layer = 1000;
         a.x = 160;
         a.y = 120;
         add(a);
         a = new Entity();
         a.graphic = SprMMG;
         SprMMG.color = 16777215;
         a.x = 46;
         a.y = 223;
         SprMMG.scaleX = 1;
         SprMMG.scaleY = 1;
         add(a);
         a = new Entity();
         a.graphic = SprFP;
         SprFP.color = 16777215;
         a.x = 274;
         a.y = 224;
         SprFP.scaleX = 1;
         SprFP.scaleY = 1;
         add(a);
         Assets.setMusic(new Sfx(Assets.MusMenu));
         this.toRemove = new Vector.<Entity>();
         this.gotoMenuMain();
      }
      
      private function toggleTimer(m:MenuButton) : void
      {
         Assets.timer = !Assets.timer;
         if(Assets.timer)
         {
            m.text.text = "Game Timer: On";
         }
         else
         {
            m.text.text = "Game Timer: Off";
         }
         m.text.centerOO();
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
         this.toRemove.push(add(new MenuButton("Music: " + (Assets.musicVolume * 100).toFixed(0) + "%",160,100,this.musicVolume)));
         this.toRemove.push(add(new MenuButton("Sounds: " + (FP.volume * 100).toFixed(0) + "%",160,120,this.soundVolume)));
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
         t.centerOO();
         this.toRemove.push(add(new TextEntity(t)));
         t = new Text("programming and design by",160,28);
         t.size = 8;
         t.color = 16777215;
         t.centerOO();
         this.toRemove.push(add(new TextEntity(t)));
         t = new Text("Matt Thorson",160,40);
         t.size = 16;
         t.color = 16777215;
         t.centerOO();
         this.toRemove.push(add(new TextEntity(t)));
         t = new Text("with additional graphics,",160,60);
         t.size = 8;
         t.color = 16777215;
         t.centerOO();
         this.toRemove.push(add(new TextEntity(t)));
         t = new Text("design and testing by",160,66);
         t.size = 8;
         t.color = 16777215;
         t.centerOO();
         this.toRemove.push(add(new TextEntity(t)));
         t = new Text("Coriander Dickinson",160,78);
         t.size = 16;
         t.color = 16777215;
         t.centerOO();
         this.toRemove.push(add(new TextEntity(t)));
         t = new Text("and voices by",160,98);
         t.size = 8;
         t.color = 16777215;
         t.centerOO();
         this.toRemove.push(add(new TextEntity(t)));
         t = new Text("Rachel Williamson",160,110);
         t.size = 16;
         t.color = 16777215;
         t.centerOO();
         this.toRemove.push(add(new TextEntity(t)));
         t = new Text("based on a prototype",160,130);
         t.size = 8;
         t.color = 16777215;
         t.centerOO();
         this.toRemove.push(add(new TextEntity(t)));
         t = new Text("developed at",160,138);
         t.size = 8;
         t.color = 16777215;
         t.centerOO();
         this.toRemove.push(add(new TextEntity(t)));
         t = new Text("Edmonton Game Jam 2010",160,150);
         t.size = 16;
         t.color = 16777215;
         t.centerOO();
         this.toRemove.push(add(new TextEntity(t)));
         t = new Text("presented by",160,170);
         t.size = 8;
         t.color = 16777215;
         t.centerOO();
         this.toRemove.push(add(new TextEntity(t)));
         t = new Text("Adult Swim Games",160,182);
         t.size = 16;
         t.color = 16777215;
         t.centerOO();
         this.toRemove.push(add(new TextEntity(t)));
         this.toRemove.push(add(new MenuButton("Back",160,220,this.gotoMenuMain)));
      }
      
      private function musicVolume(m:MenuButton) : void
      {
         if(Assets.musicVolume == 0)
         {
            Assets.musicVolume = 1;
         }
         else
         {
            Assets.musicVolume = Assets.musicVolume - 0.25;
         }
         if(Assets.musicVolume == 0)
         {
            m.text.text = "Music: Off";
         }
         else
         {
            m.text.text = "Music: " + (Assets.musicVolume * 100).toFixed(0) + "%";
         }
         m.text.centerOO();
      }
      
      private function soundVolume(m:MenuButton) : void
      {
         if(FP.volume == 0)
         {
            FP.volume = 1;
         }
         else
         {
            FP.volume = FP.volume - 0.25;
         }
         if(FP.volume == 0)
         {
            m.text.text = "Sounds: Off";
         }
         else
         {
            m.text.text = "Sounds: " + (FP.volume * 100).toFixed(0) + "%";
         }
         m.text.centerOO();
      }
      
      private function gotoMenuContinue(m:MenuButton = null) : void
      {
         var t:Text = null;
         this.clearMenu();
         t = new Text(Assets.NAMES[Stats.saveData.mode] + " Mode",160,120);
         t.size = 16;
         t.color = 16777215;
         t.centerOO();
         this.toRemove.push(add(new TextEntity(t)));
         t = new Text("Level " + Stats.saveData.levelNum,160,135);
         t.size = 8;
         t.color = 16777215;
         t.centerOO();
         this.toRemove.push(add(new TextEntity(t)));
         t = new Text(Stats.saveData.deaths + " Deaths",160,145);
         t.size = 8;
         t.color = 16777215;
         t.centerOO();
         this.toRemove.push(add(new TextEntity(t)));
         t = new Text(Stats.saveData.formattedTime,160,155);
         t.size = 8;
         t.color = 16777215;
         t.centerOO();
         this.toRemove.push(add(new TextEntity(t)));
         this.toRemove.push(add(new MenuButton("Continue",160,180,this.loadGame)));
         this.toRemove.push(add(new MenuButton("Cancel",160,200,this.gotoMenuMain)));
      }

      private function onPres() : void
      {
         if(!this.canGo)
         {
            return;
         }
         if(this.pres == 0)
         {
            var sfxp:Sfx = new Sfx(Assets.VcPresents);
            sfxp.volume = Assets.VCVOL;
            sfxp.play();
            this.presAlarm.reset(140);
            this.pres++;
         }
         else if(this.pres == 1)
         {
            var sfxb:Sfx = new Sfx(Assets.VcBestEver);
            sfxb.volume = Assets.VCVOL;
            sfxb.play();
            removeTween(this.presAlarm);
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
            new Sfx(Assets.SndNewGame).play();
         }
         else
         {
            new Sfx(Assets.SndHardGame).play();
         }
         this.canGo = false;
         Assets.setMusic();
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
            new Sfx(Assets.SndNewGame).play();
         }
         else
         {
            new Sfx(Assets.SndHardGame).play();
         }
         this.canGo = false;
         Assets.playLoad();
         Assets.setMusic(new Sfx(Assets.MusGame));
         add(new FuzzTransition(FuzzTransition.LOAD));
      }
      
      private function toggleParticles(m:MenuButton) : void
      {
         Assets.particles = !Assets.particles;
         if(Assets.particles)
         {
            m.text.text = "Particles: On";
         }
         else
         {
            m.text.text = "Particles: Off";
         }
         m.text.centerOO();
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
            t.centerOO();
            this.toRemove.push(add(new TextEntity(t)));
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
            t.centerOO();
            this.toRemove.push(add(new TextEntity(t)));
         }
         this.toRemove.push(add(new MenuButton("Options",160,190,this.gotoMenuOptions)));
         this.toRemove.push(add(new MenuButton("Credits",160,210,this.gotoMenuCredits)));
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
         t.centerOO();
         this.toRemove.push(add(new TextEntity(t)));
         t = new Text("Current savefile will be deleted!",160,140);
         t.size = 16;
         t.color = 16777215;
         t.centerOO();
         this.toRemove.push(add(new TextEntity(t)));
         this.toRemove.push(add(new MenuButton("Do It!",160,180,this.newGame)));
         this.toRemove.push(add(new MenuButton("Cancel",160,200,this.gotoMenuMain)));
      }
   }
}
