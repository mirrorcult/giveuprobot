package com.adultswim.Preroll
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.NetStatusEvent;
   import flash.events.SecurityErrorEvent;
   import flash.media.Video;
   import flash.net.NetConnection;
   import flash.net.NetStream;
   
   public class NetStreamer extends Sprite
   {
       
      
      public var nav:Navigation;
      
      private var stageHeight:Number;
      
      private var stream:NetStream;
      
      private var stageWidth:Number;
      
      private var connection:NetConnection;
      
      private var oStage:Object;
      
      private var oVideo:Object;
      
      private var videoURL:String;
      
      private var flvWidth:Number;
      
      private var flvHeight:Number;
      
      public function NetStreamer()
      {
         this.flvHeight = GlobalVarContainer.vars.flvHeight;
         this.flvWidth = GlobalVarContainer.vars.flvWidth;
         this.oStage = GlobalVarContainer.vars.stage;
         this.stageHeight = GlobalVarContainer.vars.stageHeight;
         this.stageWidth = GlobalVarContainer.vars.stageWidth;
         this.videoURL = GlobalVarContainer.vars.flvPath;
         super();
         this.connection = new NetConnection();
         this.connection.addEventListener(NetStatusEvent.NET_STATUS,this.netStatusHandler);
         this.connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler);
         this.connection.connect(null);
      }
      
      private function securityErrorHandler(event:SecurityErrorEvent) : void
      {
         trace("securityErrorHandler: " + event);
      }
      
      private function connectStream() : void
      {
         trace("|-o-| connectStream");
         trace("|-o-| rect " + this.oStage + " :: " + this.stageWidth + " : " + this.stageHeight);
         this.stream = new NetStream(this.connection);
         this.stream.addEventListener(NetStatusEvent.NET_STATUS,this.netStatusHandler);
         this.stream.client = new CustomClient();
         var blackBg:Sprite = new Sprite();
         blackBg.graphics.beginFill(0);
         blackBg.graphics.drawRect(0,0,this.stageWidth,this.stageHeight);
         this.oStage.addChild(blackBg);
         GlobalVarContainer.vars.blackBg = blackBg;
         var video:Video = new Video();
         GlobalVarContainer.vars.video = video;
         trace("!!!!!!!! width: " + this.flvWidth + " : " + this.flvHeight);
         video.x = (this.stageWidth - this.flvWidth) / 2;
         video.y = (this.stageHeight - this.flvHeight) / 2;
         video.width = this.flvWidth;
         video.height = this.flvHeight;
         video.attachNetStream(this.stream);
         this.stream.play(this.videoURL);
         GlobalVarContainer.vars.stream = this.stream;
         this.oStage.addChild(video);
         var mc:MovieClip = new MovieClip();
      }
      
      private function netStatusHandler(event:NetStatusEvent) : void
      {
         switch(event.info.code)
         {
            case "NetConnection.Connect.Success":
               this.connectStream();
               break;
            case "NetStream.Play.StreamNotFound":
               trace("Stream not found: " + this.videoURL);
               break;
            case "NetStream.Play.Stop":
               trace("All Stop, Aye");
         }
      }
   }
}

import com.adultswim.Preroll.GlobalVarContainer;
import com.adultswim.Preroll.Navigation;

class CustomClient
{
    
   
   public var nav:Navigation;
   
   function CustomClient()
   {
      super();
   }
   
   public function onXMPData(infoObject:Object) : void
   {
   }
   
   public function onCuePoint(info:Object) : void
   {
      trace("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
      switch(info.name)
      {
         case "enterPlay":
            GlobalVarContainer.vars.bReady = true;
            this.nav = new Navigation();
      }
   }
   
   public function onMetaData(info:Object) : void
   {
      trace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
   }
}
