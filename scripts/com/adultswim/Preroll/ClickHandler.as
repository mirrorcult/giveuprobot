package com.adultswim.Preroll
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   
   public class ClickHandler extends Sprite
   {
       
      
      private var stream:Object;
      
      private var blackBg:Object;
      
      private var stageHeight:Number;
      
      private var stageWidth:Number;
      
      private var oStage:Object;
      
      private var oRoot:Object;
      
      private var gameMethod:Function;
      
      private var strDomain:String;
      
      private var mcPlay:Object;
      
      private var video:Object;
      
      private var gameName:String;
      
      public function ClickHandler()
      {
         this.mcPlay = GlobalVarContainer.vars.mcPlay;
         this.oStage = GlobalVarContainer.vars.stage;
         this.oRoot = GlobalVarContainer.vars.root;
         this.stageWidth = GlobalVarContainer.vars.stageWidth;
         this.stageHeight = GlobalVarContainer.vars.stageHeight;
         this.stream = GlobalVarContainer.vars.stream;
         this.video = GlobalVarContainer.vars.video;
         this.blackBg = GlobalVarContainer.vars.blackBg;
         this.gameName = GlobalVarContainer.vars.gameName;
         this.strDomain = GlobalVarContainer.vars.strDomain;
         this.gameMethod = GlobalVarContainer.vars.gameMethod;
         super();
         trace("ClickHandler initiated");
         this.oStage.addEventListener(MouseEvent.CLICK,this.clickHandler);
      }
      
      private function clickHandler(event:MouseEvent) : void
      {
         switch(true)
         {
            case this.mcPlay.hitTestPoint(this.oStage.mouseX,this.oStage.mouseY,true):
               trace("mcPlay",this,this["parent"]);
               this.oStage.removeChild(this.mcPlay);
               this.oStage.removeChild(this.video);
               this.oStage.removeChild(this.blackBg);
               this.oStage.removeEventListener(MouseEvent.CLICK,this.clickHandler);
               Preloader.preloader.startUp();
               trace("clickHandler activated - play");
               GlobalVarContainer.vars.gameMethod;
               break;
            default:
               this.goToURL(GlobalVarContainer.vars.bReady);
         }
         GlobalVarContainer.vars.stream.resume();
      }
      
      private function goToURL(bPrerollEnd:Boolean = false) : void
      {
         var strURI:String = "http://games.adultswim.com";
         var strPrerollState:String = "";
         switch(bPrerollEnd)
         {
            case true:
               strPrerollState = "_end";
         }
         var variables:URLVariables = new URLVariables();
         variables.cid = "GAME_Ext_" + this.gameName + "_" + this.strDomain + "_preroll" + strPrerollState;
         trace("variables.cid",variables.cid);
         var request:URLRequest = new URLRequest(strURI);
         request.data = variables;
         navigateToURL(request,"_blank");
      }
   }
}
