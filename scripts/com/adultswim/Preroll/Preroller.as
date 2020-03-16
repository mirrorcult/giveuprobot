package com.adultswim.Preroll
{
   import flash.display.Sprite;
   import flash.net.LocalConnection;
   
   public class Preroller extends Sprite
   {
       
      
      private var clickHandler:ClickHandler;
      
      private var myVid:NetStreamer;
      
      private var oStage:Object;
      
      private var oRoot:Object;
      
      private var my_lc:LocalConnection;
      
      private var getVars:GetVars;
      
      public function Preroller()
      {
         this.my_lc = new LocalConnection();
         super();
         trace("!@",this.my_lc.domain);
         switch(stage)
         {
            case null:
            case undefined:
            case "":
               this.oStage = GlobalVarContainer.vars.stage;
               trace("@@@@stage is null. Now set to object: ",this.oStage);
               break;
            default:
               this.oStage = stage;
               trace("@@@@stage is available!");
         }
         switch(root)
         {
            case null:
            case undefined:
            case "":
               this.oRoot = GlobalVarContainer.vars.root;
               trace("####root is null. Now set to object: ",this.oStage);
               break;
            default:
               this.oRoot = root;
               trace("####root is available!");
         }
         trace("$$$$jumbotron",this.oStage,this.oRoot,"::",GlobalVarContainer.vars.root);
         this.getVars = new GetVars();
         this.myVid = new NetStreamer();
         this.clickHandler = new ClickHandler();
      }
   }
}
