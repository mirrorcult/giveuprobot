package jam
{
   import flash.system.System;
   import flash.utils.ByteArray;
   import net.flashpunk.graphics.Backdrop;;
   import net.flashpunk.graphics.Text;
   import net.flashpunk.tweens.misc.Alarm;
   import net.flashpunk.Entity;
   import net.flashpunk.World;
   import net.flashpunk.FP;
   import net.flashpunk.Tween;
   import net.flashpunk.Sfx;
   
   public class Level extends World
   {
      
      public static const ImgBG:Class = Level_ImgBG;
       
      
      private var bg:Backdrop;
      
      public var shake:Boolean = false;
      
      private var countTime:Boolean = true;
      
      public var width:uint;
      
      private var levelText:Text;
      
      public var time:uint;
      
      public var shakeAmount:uint;
      
      private var xml:XML;
      
      private var timer:Text;
      
      public var player:Player;
      
      public var levelNum:uint;
      
      public var height:uint;
      
      public var particles:Vector.<Particle>;
      
      private var alarmShake:Alarm;
      
      private var alarmRestart:Alarm;
      
      public function Level(num:uint)
      {
         this.alarmShake = new Alarm(1,this.onAlarmShake,Tween.PERSIST);
         this.alarmRestart = new Alarm(40,this.onAlarmRestart,Tween.PERSIST);
         super();
         this.particles = new Vector.<Particle>();
         this.levelNum = num;
         this.getXML();
         addTween(this.alarmRestart,false);
         addTween(this.alarmShake,false);
      }

      // GUR TRAINER ADD

      // l52, h10
      public function toString() : String
      {
         return getPrefix() + levelNum.toString();
      }

      // l or h
      public function getPrefix() : String
      {
         return Stats.saveData.mode == 1 ? "H" : "L";
      }

      // GUR TRAINER STOP
      
      public function die() : void
      {
         if(this.player == null)
         {
            return;
         }
         Assets.playGoodJob();
         remove(this.player);
         this.player = null;
         Stats.saveData.addDeath();
         Stats.saveData.addTime((FP.world as Level).time);
         this.time = 0;
         this.countTime = false;
         this.alarmRestart.start();
      }
      
      override public function update() : void
      {
         if(this.countTime)
         {
            this.time++;
         }
         this.bg.x = this.bg.x - 0.25;
         this.bg.y = this.bg.y - 0.25;
         this.levelText.x = 20 + FP.camera.x;
         this.levelText.y = 20 + FP.camera.y;
         if(Assets.timer)
         {
            this.timer.text = Stats.saveData.getTimePlus(this.time);
            this.timer.x = 20 + FP.camera.x;
            this.timer.y = 60 + FP.camera.y;
         }
      }
      
      public function restart() : void
      {
         this.clearParticles();
         removeAll();
         System.gc();
         this.build();
      }
      
      override public function begin() : void
      {
         this.build();
      }
      
      private function onAlarmRestart() : void
      {
         add(new FuzzTransition(FuzzTransition.RESTART));
      }
      
      public function createParticles(amount:uint, x:uint, y:uint, posRand:uint, color:uint, size:uint, sizeRand:uint, speed:Number, speedRand:Number, direction:Number, dirRand:Number, life:uint, lifeRand:uint, delay:uint = 0) : void
      {
         var p:Particle = null;
         if(!Assets.particles)
         {
            return;
         }
         for(var i:int = 0; i < amount; i++)
         {
            if(this.particles.length == 0)
            {
               p = new Particle();
            }
            else
            {
               p = this.particles.pop();
            }
            p.setDraw(x - posRand + Math.random() * posRand * 2,y - posRand + Math.random() * posRand * 2,color,size - sizeRand + Math.random() * sizeRand * 2,speed - speedRand + Math.random() * speedRand * 2,direction - dirRand + Math.random() * dirRand * 2,life - lifeRand + Math.random() * lifeRand * 2,delay);
            add(p);
         }
      }
      
      public function win() : void
      {
         if(this.player == null)
         {
            return;
         }
         remove(this.player);
         this.player = null;
         Stats.saveData.addTime(this.time);
         this.time = 0;
         this.countTime = false;
         var win:Sfx = new Sfx(Assets.SndWin);
         win.play();
         if(this.levelNum < Assets.TOTAL_LEVELS[Stats.saveData.mode])
         {
            if(this.levelNum == 1 && Stats.saveData.mode == 0)
            {
               var giv:Sfx = new Sfx(Assets.VcGiveUp10);
               giv.play(Assets.VCVOL);
            }
            else
            {
               Assets.playGiveUp();
            }
            if(Stats.saveData.mode == 0 && this.levelNum % 10 == 0 || Stats.saveData.mode == 1 && this.levelNum == 5)
            {
               add(new FuzzTransition(FuzzTransition.MENU,SubmitMenu));
            }
            else
            {
               add(new FuzzTransition(FuzzTransition.GOTO_NEXT));
            }
         }
         else
         {
            var end:Sfx = new Sfx(Assets.VcEnding);
            end.play(Assets.VCVOL);
            add(new FuzzTransition(FuzzTransition.GOTO_NEXT,null,true));
         }
      }
      
      private function clearParticles() : void
      {
         var p:Particle = null;
         var vec:Vector.<Entity> = new Vector.<Entity>();
         getClass(Particle, vec);
         for each(p in vec)
         {
            p.die();
         }
      }
      
      private function getXML() : void
      {
         var file:ByteArray = new Assets[Assets.PREFIXES[Stats.saveData.mode] + this.levelNum]();
         this.xml = new XML(file.readUTFBytes(file.length));
      }
      
      private function onAlarmShake() : void
      {
         this.shake = false;
      }
      
      public function gotoNext() : void
      {
         this.levelNum++;
         if(this.levelNum > Assets.TOTAL_LEVELS[Stats.saveData.mode])
         {
            FP.world = new EndMenu();
            return;
         }
         this.getXML();
         this.restart();
      }
      
      public function screenShake(time:uint, amount:uint = 2) : void
      {
         this.shake = true;
         this.shakeAmount = amount;
         this.alarmShake.reset(2);
      }
      
      private function build() : void
      {
         var o:XML = null;
         var h:int = 0;
         var vec:Vector.<Entity> = null;
         var e:Block = null;
         var yy:int = 0;
         var t:Text = null;
         Stats.saveData.levelNum = this.levelNum;
         Stats.save();
         this.width = this.xml.width[0];
         this.height = this.xml.height[0];
         for each(o in this.xml.solids[0].rect)
         {
            if(int(o.@y) + int(o.@h) == this.height)
            {
               h = int(o.@h) + 24;
            }
            else
            {
               h = int(o.@h);
            }
            add(new Block(o.@x,o.@y,o.@w,h));
         }
         for each(o in this.xml.objects[0].children())
         {
            if(o.localName() == "player")
            {
               yy = int(o.@y) + 3;
               add(this.player = new Player(this,o.@x,yy));
               add(new Spawn(o.@x,yy));
            }
            else if(o.localName() == "electricBlock")
            {
               if(int(o.@y) + int(o.@height) == this.height)
               {
                  h = int(o.@height) + 24;
               }
               else
               {
                  h = int(o.@height);
               }
               add(new ElectricBlock(o.@x,o.@y,o.@width,h));
            }
            else if(o.localName() == "saw")
            {
               add(new Saw(o.@x,o.@y,o.@flip == "true"));
            }
            else if(o.localName() == "fallingPlat")
            {
               add(new FallingPlat(o.@x,o.@y,o.@width,o.@height));
            }
            else if(o.localName() == "movingPlat")
            {
               add(new MovingPlat(o.@x,o.@y,o.@width,o.@height,o.node[0].@x,o.node[0].@y,o.@speed,o.@dontMove == "true",o.@stopAtEnd == "true"));
            }
         }
         add(new Block(-8,0,8,this.height));
         add(new Block(0,-8,this.width,8));
         //FP.camera.setBounds(0,0,this.width,this.height);
         //FP.camera.setOrigin(160,120);
         FP.camera.x = this.player.x;
         FP.camera.y = this.player.y;
         getClass(Block, vec);
         for each(e in vec)
         {
            e.player = this.player;
            if(e is FallingPlat)
            {
               (e as FallingPlat).getEndY();
            }
         }
         if(Stats.saveData.mode == 0)
         {
            this.levelText = new Text("Level " + this.levelNum,20,20);
         }
         else
         {
            this.levelText = new Text("Hard " + this.levelNum,20,20);
         }
         this.levelText.color = 3355443;
         this.levelText.size = 48;
         this.levelText.x = 20 + FP.camera.x;
         this.levelText.y = 20 + FP.camera.y;
         var lte:TextEntity = new TextEntity(this.levelText);
         lte.layer = 100000;
         add(lte);
         if(Assets.timer)
         {
            this.timer = new Text(Stats.saveData.formattedTime,20,60);
            this.timer.size = 24;
            this.timer.color = 2236962;
            this.timer.x = 20 + FP.camera.x;
            this.timer.y = 60 + FP.camera.y;
            var ltte:TextEntity = new TextEntity(this.timer);
            ltte.layer = 100000;
            add(ltte);
         }
         if(Stats.saveData.mode == 0)
         {
            if(this.levelNum == 1)
            {
               t = new Text("LEFT / RIGHT to move\nX or S or UP to jump",32,146);
               t.color = 3355443;
               t.size = 16;
               var t1:TextEntity = new TextEntity(t);
               t1.layer = 100000;
               add(t1);
               t = new Text("when jumping, hold it\nfor maximum height",324,128);
               t.color = 3355443;
               t.size = 16;
               var t2:TextEntity = new TextEntity(t);
               t2.layer = 100000;
               add(t2);
               t = new Text("Z or A to grapple, then\nUP / DOWN to adjust\nand LEFT / RIGHT to swing",704,96);
               t.color = 3355443;
               t.size = 16;
               var t3:TextEntity = new TextEntity(t);
               t3.layer = 100000;
               add(t3);
            }
            else if(this.levelNum == 2)
            {
               t = new Text("REMEMBER:\nZ or A to grapple, then\nUP / DOWN to adjust\nand LEFT / RIGHT to swing",32,116);
               t.color = 3355443;
               t.size = 16;
               var t4:TextEntity = new TextEntity(t);
               t4.layer = 100000;
               add(t4);
            }
            else if(this.levelNum == 3)
            {
               t = new Text("RECALL:\nZ or A to grapple, then\nUP / DOWN to adjust\nand LEFT / RIGHT to swing",56,128);
               t.color = 3355443;
               t.size = 16;
               var t5:TextEntity = new TextEntity(t);
               t5.layer = 100000;
               add(t5);
            }
            else if(this.levelNum == 4)
            {
               t = new Text("SERIOUSLY:\nZ or A to grapple, then\nUP / DOWN to adjust\nand LEFT / RIGHT to swing",24,116);
               t.color = 3355443;
               t.size = 16;
               var t6:TextEntity = new TextEntity(t);
               t6.layer = 100000;
               add(t6);
            }
            else if(this.levelNum == 49)
            {
               t = new Text("Go for distance!",128,160);
               t.color = 3355443;
               t.size = 16;
               var t7:TextEntity = new TextEntity(t);
               t7.layer = 100000;
               add(t7);
            }
         }
         add(new BGEntity(this.bg = new Backdrop(ImgBG)));
         add(new EndLine());
         if(Assets.fuzz != null)
         {
            add(Assets.fuzz);
            Assets.fuzz = null;
         }
         this.time = 0;
         this.countTime = true;
      }
   }
}
