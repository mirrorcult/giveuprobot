package com.adultswim.Preroll
{
   import flash.display.Sprite;
   import flash.net.LocalConnection;
   
   public class GetVars extends Sprite
   {
       
      
      private var oRoot:Object;
      
      private var my_lc:LocalConnection;
      
      public function GetVars()
      {
         this.oRoot = GlobalVarContainer.vars.root;
         this.my_lc = new LocalConnection();
         super();
         trace("~~~~",this.oRoot,GlobalVarContainer.vars.strBase);
         switch(this.oRoot.loaderInfo.parameters.strBase)
         {
            case undefined:
            case null:
            case "":
               GlobalVarContainer.vars.strBase = "http://i.cdn.turner.com/adultswim/games/hs/" + GlobalVarContainer.vars.gameName + "/";
               break;
            default:
               try
               {
                  GlobalVarContainer.vars.strBase = this.oRoot.loaderInfo.parameters.strBase;
               }
               catch(e:Error)
               {
               }
         }
         switch(this.oRoot.loaderInfo.parameters.strDomain)
         {
            case undefined:
            case null:
            case "":
               GlobalVarContainer.vars.strDomain = this.my_lc.domain;
               break;
            default:
               try
               {
                  GlobalVarContainer.vars.strDomain = this.oRoot.loaderInfo.parameters.strDomain;
               }
               catch(e:Error)
               {
               }
         }
      }
   }
}
