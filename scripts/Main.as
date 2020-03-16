package
{
   import com.adultswim.Preroll.GlobalVarContainer;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import jam.MainMenu;
   import punk.core.Engine;
   import punk.util.Input;
   import punk.util.Key;
   
   public class Main extends Engine
   {
      
      public static var strDomain:String = GlobalVarContainer.vars.strDomain;
      
      public static var gameName:String = GlobalVarContainer.vars.gameName;
       
      
      public function Main()
      {
         super(320,240,60,2,MainMenu);
      }
      
      public static function link(from:String) : void
      {
         var strURI:String = "http://games.adultswim.com";
         var variables:URLVariables = new URLVariables();
         variables.cid = "GAME_Ext_" + gameName + "_" + strDomain + "_" + from;
         trace("variables.cid",variables.cid);
         var request:URLRequest = new URLRequest(strURI);
         request.data = variables;
         navigateToURL(request,"_blank");
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
