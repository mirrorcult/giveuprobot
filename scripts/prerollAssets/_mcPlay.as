package prerollAssets
{
   import flash.display.MovieClip;
   
   public dynamic class _mcPlay extends MovieClip
   {
       
      
      public var mcPlayBtn:MovieClip;
      
      public var over:MovieClip;
      
      public function _mcPlay()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
