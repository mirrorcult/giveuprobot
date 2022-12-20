package
{
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import jam.MainMenu;
   import net.flashpunk.Engine;
   import net.flashpunk.utils.Input;
   import net.flashpunk.utils.Key;
   
   public class Main extends Engine
   {
      public function Main()
      {
         super(320,240,60,2);

         // TODO MIRR go to MainMenu thru init
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
      }
   }
}
