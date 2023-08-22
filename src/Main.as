package
{
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import jam.MainMenu;
   import net.flashpunk.Engine;
   import net.flashpunk.utils.Input;
   import net.flashpunk.utils.Key;
   import net.flashpunk.FP;
   import flash.display.StageAlign;
   import flash.display.StageQuality;
   import flash.display.StageScaleMode;
   import flash.display.StageDisplayState;
   import net.flashpunk.debug.Console;
   
   public class Main extends Engine
   {
      public function Main()
      {
         super(320,240,60, true);
         FP.screen.scale = 2;
      }
      
      override public function init() : void
      {
         Input.define("right",Key.RIGHT);
         Input.define("left",Key.LEFT);
         Input.define("up",Key.UP);
         Input.define("down",Key.DOWN);
         Input.define("jump",Key.X,Key.UP,Key.S);
         Input.define("grapple",Key.Z,Key.A);
         Input.define("skip",Key.ENTER);
         FP.world = new MainMenu();

         FP.console.enable();
         FP.console.visible = false;
         FP.console.watch("hSpeed", "vSpeed", "direction", "momentum", "radius", "active", "timeLeft", "coinsLeft", "endY", "startY", "counter", "grappleHSpeed", "grappleVSpeed");
      }

      override public function setStageProperties():void
      {
         stage.align = StageAlign.TOP_LEFT;
         stage.quality = StageQuality.HIGH;
         stage.scaleMode = StageScaleMode.SHOW_ALL;
         stage.displayState = StageDisplayState.NORMAL;
      }
   }
}
