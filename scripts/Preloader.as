package
{
   import com.adultswim.Preroll.GlobalVarContainer;
   import com.adultswim.Preroll.Preroller;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.geom.Matrix;
   import flash.utils.getDefinitionByName;
   import prerollAssets._mcPlay;
   
   public class Preloader extends MovieClip
   {
      
      public static var preloader:Preloader;
      
      private static const ImgBG:Class = Preloader_ImgBG;
      
      private static const ImgLoading:Class = Preloader_ImgLoading;
       
      
      private var done:Boolean = false;
      
      private var re:RegExp;
      
      private var oStage:Object;
      
      private var oRoot:Object;
      
      private var bar:Sprite;
      
      private var Preroller:Preroller;
      
      private var pplay:_mcPlay;
      
      private var gameName:String = "giveuprobot";
      
      public function Preloader()
      {
         this.re = /http://i.cdn.turner.com/adultswim/games2/tools/swf/preroll-asg-syndicated(-\w+)?-(\d+)x(\d+).flv/i;
         this.pplay = new _mcPlay();
         super();
         preloader = this;
         switch(stage)
         {
            case null:
               this.oStage = GlobalVarContainer.vars.stage;
               trace("@@@@stage is null. Now set to object: ",this.oStage);
               break;
            default:
               this.oStage = stage;
               GlobalVarContainer.vars.stage = this.oStage;
               trace("@@@@stage is available!");
         }
         switch(root)
         {
            case null:
               this.oRoot = GlobalVarContainer.vars.root;
               trace("####root is null. Now set to object: ",this.oRoot);
               break;
            default:
               this.oRoot = root;
               GlobalVarContainer.vars.root = this.oRoot;
               trace("####root is available!");
         }
         trace("MAIN0");
         if(this.oStage)
         {
            this.init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.init);
         }
         addEventListener(Event.ENTER_FRAME,this.checkFrame);
         loaderInfo.addEventListener(ProgressEvent.PROGRESS,this.progress);
         var s:Sprite = new Sprite();
         var m:Matrix = new Matrix();
         m.scale(2,2);
         s.graphics.beginBitmapFill((new ImgBG() as Bitmap).bitmapData,m);
         s.graphics.drawRect(0,0,640,480);
         s.graphics.endFill();
         m.scale(1,1);
         m.translate(161,129);
         s.graphics.beginBitmapFill((new ImgLoading() as Bitmap).bitmapData,m,false);
         s.graphics.drawRect(0,0,640,480);
         s.graphics.endFill();
         addChild(s);
         this.bar = new Sprite();
         this.bar.graphics.beginFill(5592405);
         this.bar.graphics.drawRect(260,230,120,20);
         this.bar.graphics.endFill();
         addChild(this.bar);
      }
      
      private function progress(e:ProgressEvent) : void
      {
         this.bar.graphics.clear();
         this.bar.graphics.beginFill(5592405);
         this.bar.graphics.drawRect(260,230,120,20);
         this.bar.graphics.endFill();
         this.bar.graphics.beginFill(16777215);
         this.bar.graphics.drawRect(260,230,e.bytesLoaded / e.bytesTotal * 120,20);
         this.bar.graphics.endFill();
      }
      
      private function checkFrame(e:Event) : void
      {
         if(currentFrame == totalFrames)
         {
            removeEventListener(Event.ENTER_FRAME,this.checkFrame);
            this.startUp();
         }
      }
      
      private function init(e:Event = null) : void
      {
         trace("INIT0");
         removeEventListener(Event.ADDED_TO_STAGE,this.init);
         GlobalVarContainer.vars.gameName = this.gameName;
         GlobalVarContainer.vars.flvPath = "http://i.cdn.turner.com/adultswim/games2/tools/swf/preroll-asg-syndicated-noplay-728x500.flv";
         GlobalVarContainer.vars.flvWidth = parseInt(GlobalVarContainer.vars.flvPath.replace(this.re,"$2"));
         GlobalVarContainer.vars.flvHeight = parseInt(GlobalVarContainer.vars.flvPath.replace(this.re,"$3"));
         trace(GlobalVarContainer.vars.flvPath.replace(this.re,"$0"),GlobalVarContainer.vars.flvPath.replace(this.re,"$1"),GlobalVarContainer.vars.flvPath.replace(this.re,"$2"),GlobalVarContainer.vars.flvPath.replace(this.re,"$3"));
         GlobalVarContainer.vars.stageWidth = this.oStage.stageWidth;
         GlobalVarContainer.vars.stageHeight = this.oStage.stageHeight;
         GlobalVarContainer.vars.mcPlay = this.pplay;
         this.Preroller = new Preroller();
      }
      
      public function startUp() : void
      {
         var mainClass:Class = null;
         if(this.done)
         {
            mainClass = getDefinitionByName("Main") as Class;
            addChild(new mainClass() as DisplayObject);
         }
         else
         {
            this.done = true;
         }
      }
   }
}
