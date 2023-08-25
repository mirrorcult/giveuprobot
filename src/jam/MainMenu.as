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
   import net.flashpunk.Engine;
   
   public class MainMenu extends MenuWorld
   {
      
      private static const ImgMMG:Class = Library.MainMenu_ImgMMG;
      
      private var SprMMG:Spritemap;
      
      private static const ImgFP:Class = Library.MainMenu_ImgFP;
      
      private var SprFP:Spritemap;
       
      
      private var presAlarm:Alarm;
      
      private var bg:Backdrop;
      
      private var sss:Number = 0;
      
      private var title:Text;
      
      private var canGo:Boolean = true;
      
      private var toRemove:Vector.<Entity>;
      
      private var pres:uint = 0;
      
      private var presents:Text;
      
      public function MainMenu()
      {
         SprMMG = new Spritemap(ImgMMG,90,32);
         SprMMG.set(45, 16);
         SprFP = new Spritemap(ImgFP,89,31);
         SprFP.set(45, 15);
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
         var i:int = 0;
         for(i = 0; i < this.toRemove.length; i++)
         {
            remove(this.toRemove[i]);
         }
         this.toRemove = new Vector.<Entity>();
      }
      
      override public function begin() : void
      {
         var a:Entity = null;
         var t:Title = null;
         var f:FlashingText = null;
         super.begin();
         addTween(this.presAlarm, true);
         t = new Title(16, "mirrorcult Presents",160,40, true, 6710886, true)
         t.layer = Layer.MENU_TEXT;
         this.presents = t.text;
         add(t);
         f = new FlashingText(36, "GURTaser Deluxe",160,64, true, 0xFFFFFF, true)
         f.layer = Layer.MENU_TEXT;
         this.title = f.text;
         add(f);
         a = new Entity();
         var spr:Spritemap = new Spritemap(DiscoBall.ImgBall,64,64);
         a.graphic = spr;
         spr.add("spin", [0,1,2,3], 1/6, true);
         spr.scaleX = 4;
         spr.scaleY = 4;
         spr.alpha = 0.1;
         spr.play("spin");
         a.layer = Layer.BEHIND_MENU_TEXT;
         a.x = 32;
         a.y = -8;
         add(a);
         var b:Entity = new Entity();
         b.graphic = SprMMG;
         SprMMG.setColorWhite();
         b.x = 46;
         b.y = 223;
         SprMMG.scaleX = 1;
         SprMMG.scaleY = 1;
         add(b);
         var c:Entity = new Entity();
         c.graphic = SprFP;
         SprFP.setColorWhite();
         c.x = 274;
         c.y = 224;
         SprFP.scaleX = 1;
         SprFP.scaleY = 1;
         add(c);
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
         this.toRemove.push(add(new MenuButton("Particles: " + (Assets.particles?"On ":"Off"),160,140,this.toggleParticles)));
         this.toRemove.push(add(new MenuButton("Game Timer: " + (Assets.timer?"On ":"Off"),160,160,this.toggleTimer)));
         this.toRemove.push(add(new MenuButton("Blur: " + (Engine.canFlash?"On ":"Off"),160,180,this.toggleBlur)));
         this.toRemove.push(add(new MenuButton("Screenshake: " + (Assets.screenshake?"On ":"Off"),160,200,this.toggleScreenshake)));
         this.toRemove.push(add(new MenuButton("Back",160,220,this.gotoMenuMain)));
      }
      
      private function gotoMenuCredits(m:MenuButton = null) : void
      {
         var t:Text = null;
         this.clearMenu();
         this.title.visible = false;
         this.presents.visible = false;
         this.toRemove.push(add(new Title(8, "graphics, audio,",160,22)));
         this.toRemove.push(add(new Title(8, "programming and design by",160,28)));
         this.toRemove.push(add(new Title(16, "Matt Thorson",160,40)));
         this.toRemove.push(add(new Title(8, "with additional graphics,",160,60)));
         this.toRemove.push(add(new Title(8, "design and testing by",160,66)));
         this.toRemove.push(add(new Title(16, "Coriander Dickinson",160,78)));
         this.toRemove.push(add(new Title(8, "and voices by",160,98)));
         this.toRemove.push(add(new Title(16, "Rachel Williamson",160,110)));
         this.toRemove.push(add(new Title(8, "based on a prototype",160,130)));
         this.toRemove.push(add(new Title(8, "developed at",160,138)));
         this.toRemove.push(add(new Title(16, "Edmonton Game Jam 2010",160,150)));
         this.toRemove.push(add(new Title(8, "presented by",160,170)));
         this.toRemove.push(add(new Title(16, "Adult Swim Games",160,182)));
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
         this.clearMenu();
         this.toRemove.push(add(new Title(16, Assets.NAMES[Stats.saveData.mode] + " Mode",160,120)));
         this.toRemove.push(add(new Title(8, "Level " + Stats.saveData.levelNum,160,135)));
         this.toRemove.push(add(new Title(8, Stats.saveData.deaths + " Deaths",160,145)));
         this.toRemove.push(add(new Title(8, Stats.saveData.formattedTime,160,155)));
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
         Engine.flash = true;
      }
      
      private function toggleParticles(m:MenuButton) : void
      {
         Assets.particles = !Assets.particles;
         if(Assets.particles)
         {
            m.text.text = "Particles: On ";
         }
         else
         {
            m.text.text = "Particles: Off";
         }
         m.text.centerOO();
      }

      private function toggleBlur(m:MenuButton) : void
      {
         Engine.canFlash = !Engine.canFlash;
         if(Engine.canFlash)
         {
            m.text.text = "Blur: On ";
         }
         else
         {
            m.text.text = "Blur: Off";
         }
         m.text.centerOO();
      }

      private function toggleScreenshake(m:MenuButton) : void
      {
         Assets.screenshake = !Assets.screenshake;
         if(Assets.screenshake)
         {
            m.text.text = "Screenshake: On ";
         }
         else
         {
            m.text.text = "Screenshake: Off";
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
            this.toRemove.push(add(new Title(16, "New HARD Game",160,140, true, 3355443)));
         }
         if(Stats.exists())
         {
            this.toRemove.push(add(new MenuButton("Continue",160,160,this.loadStats)));
         }
         else
         {
            this.toRemove.push(add(new Title(16, "Continue",160,160, true, 3355443)));
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
         this.toRemove.push(add(new Title(24, "Are You Sure?",160,120)));
         this.toRemove.push(add(new Title(16, "Current savefile will be deleted!",160,140)));
         this.toRemove.push(add(new MenuButton("Do It!",160,180,this.newGame)));
         this.toRemove.push(add(new MenuButton("Cancel",160,200,this.gotoMenuMain)));
      }
   }
}
