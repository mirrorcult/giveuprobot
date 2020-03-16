package com.adultswim.Preroll
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Navigation extends Sprite
   {
       
      
      private var stageHeight:Number;
      
      private var stream:Object;
      
      private var stageWidth:Number;
      
      private var mcPlay:Object;
      
      private var oStage:Object;
      
      public function Navigation()
      {
         this.mcPlay = GlobalVarContainer.vars.mcPlay;
         this.oStage = GlobalVarContainer.vars.stage;
         this.stageWidth = GlobalVarContainer.vars.stageWidth;
         this.stageHeight = GlobalVarContainer.vars.stageHeight;
         this.stream = GlobalVarContainer.vars.stream;
         super();
         trace("Navigation initiated");
         trace("mcPlay",this.mcPlay);
         trace("mcPlay.name",this.mcPlay.name);
         this.oStage.addChild(this.mcPlay);
         this.mcPlay.mcPlayBtn.gotoAndPlay(2);
         this.mcPlay.scaleX = this.mcPlay.scaleY = 0.5;
         this.mcPlay.x = this.stageWidth / 2 - this.mcPlay.width / 2;
         this.mcPlay.y = 289;
         this.mcPlay.addEventListener(MouseEvent.MOUSE_OVER,this.clickMethod);
         this.mcPlay.addEventListener(MouseEvent.MOUSE_OUT,this.clickMethod);
         this.mcPlay.addEventListener(MouseEvent.MOUSE_DOWN,this.clickMethod);
      }
      
      public function clickMethod(event:MouseEvent) : void
      {
         switch(event.type)
         {
            case "mouseOver":
               this.mcPlay.gotoAndStop("over");
               break;
            case "mouseOut":
               this.mcPlay.gotoAndStop("off");
               break;
            case "click":
               this.mcPlay.gotoAndStop("down");
         }
      }
   }
}
