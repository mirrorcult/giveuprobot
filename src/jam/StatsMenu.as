package jam
{
   import net.flashpunk.tweens.misc.Alarm;
   import net.flashpunk.utils.Input;
   import net.flashpunk.Tween;
   import net.flashpunk.utils.Draw;
   import net.flashpunk.Sfx;
   
   public class StatsMenu extends MenuWorld
   {
       
      
      private var current:uint = 0;
      
      private var dots:Vector.<GraphDot>;
      
      private var canGo:Boolean = true;
      
      private const G_HEIGHT:uint = 200;
      
      private const G_X:uint = 10;
      
      private const G_Y:uint = 20;
      
      private var mode:Boolean = true;
      
      private var hitText:FlashingText;
      
      private var alarmColors:Alarm;
      
      public var color:uint;
      
      private var text:FlashingText;
      
      private const G_WIDTH:uint = 300;
      
      private const colors:Array = [16711680,16776960,65280,65535,255,16711935];
      
      private var inText:FlashingText;
      
      public function StatsMenu()
      {
         this.alarmColors = new Alarm(5,this.onColor,Tween.LOOPING);
         super();
         this.color = this.colors[0];
         this.dots = new Vector.<GraphDot>();
      }
      
      private function onColor() : void
      {
         this.current++;
         if(this.current >= this.colors.length)
         {
            this.current = 0;
         }
         this.color = this.colors[this.current];
      }
      
      private function loadGraph(name:String, graph:Vector.<uint>) : void
      {
         var u:uint = 0;
         var i:int = 0;
         this.text.text = name;
         this.text.centerOO();
         var biggest:int = 0;
         for each(u in graph)
         {
            if(u > biggest)
            {
               biggest = u;
            }
         }
         if(biggest == 0)
         {
            for(i = 0; i < Assets.TOTAL_LEVELS[Stats.saveData.mode]; i++)
            {
               this.dots[i].gotoY = this.G_Y + this.G_HEIGHT;
            }
         }
         else
         {
            for(i = 0; i < Assets.TOTAL_LEVELS[Stats.saveData.mode]; i++)
            {
               this.dots[i].gotoY = this.G_Y + this.G_HEIGHT - graph[i] / biggest * this.G_HEIGHT;
            }
         }
      }
      
      override public function begin() : void
      {
         var g:GraphDot = null;
         super.begin();
         addTween(this.alarmColors);
         this.text = new FlashingText("",160,16);
         this.text.size = 24;
         this.text.centerOO();
         add(new TextEntity(this.text));
         this.inText = new FlashingText("",160,120);
         this.inText.size = 16;
         this.inText.centerOO();
         var intexte:TextEntity = new TextEntity(this.inText);
         intexte.layer = -100;
         add(intexte);
         this.hitText = new FlashingText("Z/A - Time    ENTER - Continue",160,232);
         this.hitText.size = 8;
         this.hitText.centerOO();
         add(new TextEntity(this.hitText));
         for(var i:int = 0; i < Assets.TOTAL_LEVELS[Stats.saveData.mode]; i++)
         {
            g = new GraphDot();
            g.x = i / (Assets.TOTAL_LEVELS[Stats.saveData.mode] - 1) * this.G_WIDTH + this.G_X;
            g.y = this.G_Y + this.G_HEIGHT;
            g.gotoY = g.y;
            add(g);
            this.dots.push(g);
         }
         this.gotoDeathsGraph();
      }
      
      override public function render() : void
      {
         var last:GraphDot = null;
         var g:GraphDot = null;
         for each(g in this.dots)
         {
            if(last)
            {
               Draw.line(last.x,last.y,g.x,g.y,this.color);
            }
            last = g;
         }
      }
      
      private function gotoTimeGraph() : void
      {
         this.loadGraph("Time",Stats.saveData.time_stage);
         this.inText.text = Stats.saveData.formattedTime;
         this.hitText.text = "Z/A - Deaths    ENTER - Continue";
         this.inText.centerOO();
         this.hitText.centerOO();
      }
      
      override public function update() : void
      {
         super.update();
         if(Input.pressed("grapple"))
         {
            this.mode = !this.mode;
            var sfxs:Sfx = new Sfx(Assets.SndSelect);
            sfxs.play();
            if(this.mode)
            {
               this.gotoDeathsGraph();
            }
            else
            {
               this.gotoTimeGraph();
            }
         }
         if(Input.pressed("skip") && this.canGo)
         {
            Stats.clear();
            Stats.setHardMode(true);
            this.canGo = false;
            var sfx:Sfx = new Sfx(Assets.SndWin);
            sfx.play();
            add(new FuzzTransition(FuzzTransition.MENU,SubmitMenu));
         }
      }
      
      private function gotoDeathsGraph() : void
      {
         this.loadGraph("Deaths",Stats.saveData.deaths_stage);
         if(Stats.saveData.deaths > 0)
         {
            this.inText.text = String(Stats.saveData.deaths);
         }
         else
         {
            this.inText.text = "None!";
         }
         this.hitText.text = "Z/A - Time      ENTER - Continue";
         this.inText.centerOO();
         this.hitText.centerOO();
      }
   }
}
