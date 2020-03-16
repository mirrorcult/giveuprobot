package jam
{
   import flash.display.Stage;
   
   public class Assets
   {
      
      private static const VcBye1:Class = Assets_VcBye1;
      
      private static const VcBye4:Class = Assets_VcBye4;
      
      public static const SndNewGame:Class = Assets_SndNewGame;
      
      public static var currentMusic:Class;
      
      private static const ARR_GOODLUCK:Array = [VcGoodLuck1,VcGoodLuck2];
      
      public static const MusGame:Class = Assets_MusGame;
      
      public static const SndGrappleSaw:Class = Assets_SndGrappleSaw;
      
      private static var lastGoodJob:int = -1;
      
      public static var fuzz:FuzzTransition = null;
      
      public static const VcEnding:Class = Assets_VcEnding;
      
      private static const VcGoodJob1:Class = Assets_VcGoodJob1;
      
      private static const VcGoodJob2:Class = Assets_VcGoodJob2;
      
      private static const VcGoodJob3:Class = Assets_VcGoodJob3;
      
      private static const VcGoodJob4:Class = Assets_VcGoodJob4;
      
      private static const VcGoodJob5:Class = Assets_VcGoodJob5;
      
      private static const VcGoodJob6:Class = Assets_VcGoodJob6;
      
      public static const SndFall:Class = Assets_SndFall;
      
      private static const VcGoodJob8:Class = Assets_VcGoodJob8;
      
      private static const VcGoodJob9:Class = Assets_VcGoodJob9;
      
      public static const H10:Class = Assets_H10;
      
      public static const H11:Class = Assets_H11;
      
      public static const SndGrappleElec:Class = Assets_SndGrappleElec;
      
      public static const VcIntro1:Class = Assets_VcIntro1;
      
      private static const VcGoodJob7:Class = Assets_VcGoodJob7;
      
      public static const VcIntro3:Class = Assets_VcIntro3;
      
      public static const VcIntro4:Class = Assets_VcIntro4;
      
      public static const VcIntro5:Class = Assets_VcIntro5;
      
      public static const SndDie:Class = Assets_SndDie;
      
      public static const VcIntro6:Class = Assets_VcIntro6;
      
      public static const VcIntro2:Class = Assets_VcIntro2;
      
      private static const VcGiveUp1:Class = Assets_VcGiveUp1;
      
      public static const SndStart:Class = Assets_SndStart;
      
      private static const VcGiveUp3:Class = Assets_VcGiveUp3;
      
      private static const VcGiveUp4:Class = Assets_VcGiveUp4;
      
      private static const VcGiveUp5:Class = Assets_VcGiveUp5;
      
      private static const VcGiveUp6:Class = Assets_VcGiveUp6;
      
      private static const VcGiveUp7:Class = Assets_VcGiveUp7;
      
      private static const VcGiveUp8:Class = Assets_VcGiveUp8;
      
      private static const VcGiveUp2:Class = Assets_VcGiveUp2;
      
      private static const VcGiveUp12:Class = Assets_VcGiveUp12;
      
      private static const VcGiveUp13:Class = Assets_VcGiveUp13;
      
      private static const VcGiveUp14:Class = Assets_VcGiveUp14;
      
      private static const VcGiveUp15:Class = Assets_VcGiveUp15;
      
      private static const VcGiveUp16:Class = Assets_VcGiveUp16;
      
      private static const VcGiveUp17:Class = Assets_VcGiveUp17;
      
      private static const VcGiveUp9:Class = Assets_VcGiveUp9;
      
      private static const VcGiveUp11:Class = Assets_VcGiveUp11;
      
      private static const VcGiveUp18:Class = Assets_VcGiveUp18;
      
      public static const VcGiveUp10:Class = Assets_VcGiveUp10;
      
      public static var particles:Boolean = true;
      
      private static const VcGiveUp20:Class = Assets_VcGiveUp20;
      
      private static const VcGiveUp21:Class = Assets_VcGiveUp21;
      
      private static const VcGiveUp19:Class = Assets_VcGiveUp19;
      
      private static const VcGiveUp23:Class = Assets_VcGiveUp23;
      
      private static const VcGiveUp24:Class = Assets_VcGiveUp24;
      
      private static const VcGiveUp25:Class = Assets_VcGiveUp25;
      
      private static const VcGiveUp26:Class = Assets_VcGiveUp26;
      
      private static const VcGiveUp27:Class = Assets_VcGiveUp27;
      
      private static const VcGiveUp28:Class = Assets_VcGiveUp28;
      
      public static const PREFIXES:Array = ["L","H"];
      
      private static const VcGiveUp29:Class = Assets_VcGiveUp29;
      
      private static const VcGiveUp22:Class = Assets_VcGiveUp22;
      
      public static const SndLand:Class = Assets_SndLand;
      
      public static const SndEnd:Class = Assets_SndEnd;
      
      public static const SndMouse:Class = Assets_SndMouse;
      
      public static const VCVOL:Number = 10;
      
      private static const VcGiveUp32:Class = Assets_VcGiveUp32;
      
      public static const H1:Class = Assets_H1;
      
      public static const TOTAL_LEVELS:Array = [50,11];
      
      public static const H3:Class = Assets_H3;
      
      public static const H4:Class = Assets_H4;
      
      public static const H7:Class = Assets_H7;
      
      public static const H8:Class = Assets_H8;
      
      public static const H9:Class = Assets_H9;
      
      private static const VcGiveUp34:Class = Assets_VcGiveUp34;
      
      private static const VcGiveUp35:Class = Assets_VcGiveUp35;
      
      public static const H5:Class = Assets_H5;
      
      public static const H6:Class = Assets_H6;
      
      private static const VcGiveUp30:Class = Assets_VcGiveUp30;
      
      public static const H2:Class = Assets_H2;
      
      private static const VcGiveUp33:Class = Assets_VcGiveUp33;
      
      private static const VcGiveUp36:Class = Assets_VcGiveUp36;
      
      private static const VcGiveUp31:Class = Assets_VcGiveUp31;
      
      public static const VcPresents:Class = Assets_VcPresents;
      
      public static const VcBestEver:Class = Assets_VcBestEver;
      
      public static const SndJump:Class = Assets_SndJump;
      
      public static const SndThrow:Class = Assets_SndThrow;
      
      public static const NAMES:Array = ["Normal","HARD"];
      
      private static const ARR_GIVEUP:Array = [VcGiveUp1,VcGiveUp2,VcGiveUp3,VcGiveUp4,VcGiveUp5,VcGiveUp6,VcGiveUp7,VcGiveUp8,VcGiveUp9,VcGiveUp10,VcGiveUp11,VcGiveUp12,VcGiveUp13,VcGiveUp14,VcGiveUp15,VcGiveUp16,VcGiveUp17,VcGiveUp18,VcGiveUp19,VcGiveUp20,VcGiveUp21,VcGiveUp22,VcGiveUp23,VcGiveUp24,VcGiveUp25,VcGiveUp26,VcGiveUp27,VcGiveUp28,VcGiveUp29,VcGiveUp30,VcGiveUp31,VcGiveUp32,VcGiveUp33,VcGiveUp34,VcGiveUp35,VcGiveUp36];
      
      public static const SndDeselect:Class = Assets_SndDeselect;
      
      public static const SndStatic:Class = Assets_SndStatic;
      
      public static const SndShake:Class = Assets_SndShake;
      
      public static var timer:Boolean = false;
      
      public static const L1:Class = Assets_L1;
      
      public static const L2:Class = Assets_L2;
      
      public static const L3:Class = Assets_L3;
      
      public static const L4:Class = Assets_L4;
      
      public static const L5:Class = Assets_L5;
      
      public static const L6:Class = Assets_L6;
      
      public static const L7:Class = Assets_L7;
      
      public static const L8:Class = Assets_L8;
      
      public static const L9:Class = Assets_L9;
      
      public static const L13:Class = Assets_L13;
      
      public static const L14:Class = Assets_L14;
      
      public static const L15:Class = Assets_L15;
      
      public static const L16:Class = Assets_L16;
      
      public static const L17:Class = Assets_L17;
      
      public static const L18:Class = Assets_L18;
      
      public static const L19:Class = Assets_L19;
      
      public static const L10:Class = Assets_L10;
      
      public static const L11:Class = Assets_L11;
      
      public static const L12:Class = Assets_L12;
      
      public static const MusIntro:Class = Assets_MusIntro;
      
      public static const L20:Class = Assets_L20;
      
      public static const L21:Class = Assets_L21;
      
      public static const L22:Class = Assets_L22;
      
      public static const L23:Class = Assets_L23;
      
      public static const L25:Class = Assets_L25;
      
      public static const L26:Class = Assets_L26;
      
      public static const L27:Class = Assets_L27;
      
      public static const L28:Class = Assets_L28;
      
      public static const L29:Class = Assets_L29;
      
      public static const L24:Class = Assets_L24;
      
      private static const VcGoodJob14:Class = Assets_VcGoodJob14;
      
      private static const VcGoodJob16:Class = Assets_VcGoodJob16;
      
      private static const VcGoodJob12:Class = Assets_VcGoodJob12;
      
      public static const SndSelect:Class = Assets_SndSelect;
      
      public static const L30:Class = Assets_L30;
      
      public static const L31:Class = Assets_L31;
      
      public static const L32:Class = Assets_L32;
      
      public static const L33:Class = Assets_L33;
      
      public static const L34:Class = Assets_L34;
      
      public static const L35:Class = Assets_L35;
      
      public static const L36:Class = Assets_L36;
      
      public static const L37:Class = Assets_L37;
      
      public static const L38:Class = Assets_L38;
      
      public static const L39:Class = Assets_L39;
      
      public static const MusMenu:Class = Assets_MusMenu;
      
      private static const VcGoodJob22:Class = Assets_VcGoodJob22;
      
      private static const VcGoodJob17:Class = Assets_VcGoodJob17;
      
      public static const SndRank1:Class = Assets_SndRank1;
      
      public static const SndRank2:Class = Assets_SndRank2;
      
      public static const SndRank3:Class = Assets_SndRank3;
      
      public static const SndRank4:Class = Assets_SndRank4;
      
      public static const SndRank5:Class = Assets_SndRank5;
      
      public static const SndRank6:Class = Assets_SndRank6;
      
      private static const VcGoodJob13:Class = Assets_VcGoodJob13;
      
      private static const VcGoodJob23:Class = Assets_VcGoodJob23;
      
      private static const VcGoodJob15:Class = Assets_VcGoodJob15;
      
      private static const VcBye2:Class = Assets_VcBye2;
      
      public static const SndGrapple:Class = Assets_SndGrapple;
      
      public static const GIVEUPVOL:Number = 9;
      
      public static const L40:Class = Assets_L40;
      
      public static const L41:Class = Assets_L41;
      
      public static const L42:Class = Assets_L42;
      
      public static const L43:Class = Assets_L43;
      
      public static const L45:Class = Assets_L45;
      
      public static const L46:Class = Assets_L46;
      
      public static const L47:Class = Assets_L47;
      
      public static const L48:Class = Assets_L48;
      
      public static const L49:Class = Assets_L49;
      
      public static const SndWin:Class = Assets_SndWin;
      
      private static const VcBye5:Class = Assets_VcBye5;
      
      public static const SndDrop:Class = Assets_SndDrop;
      
      private static const VcGoodJob11:Class = Assets_VcGoodJob11;
      
      public static const L44:Class = Assets_L44;
      
      private static const VcGoodJob19:Class = Assets_VcGoodJob19;
      
      public static const SndHardGame:Class = Assets_SndHardGame;
      
      public static const L50:Class = Assets_L50;
      
      private static const VcBye6:Class = Assets_VcBye6;
      
      private static const VcGoodJob20:Class = Assets_VcGoodJob20;
      
      private static const VcGoodJob18:Class = Assets_VcGoodJob18;
      
      private static const ARR_GOODJOB:Array = [VcGoodJob1,VcGoodJob2,VcGoodJob3,VcGoodJob4,VcGoodJob5,VcGoodJob6,VcGoodJob7,VcGoodJob8,VcGoodJob9,VcGoodJob10,VcGoodJob11,VcGoodJob12,VcGoodJob13,VcGoodJob14,VcGoodJob15,VcGoodJob16,VcGoodJob17,VcGoodJob18,VcGoodJob19,VcGoodJob20,VcGoodJob21,VcGoodJob22,VcGoodJob23];
      
      public static const SUBMIT_IDS:Array = ["3172","3173"];
      
      private static const ARR_BYE:Array = [VcBye1,VcBye2,VcBye3,VcBye4,VcBye5,VcBye6];
      
      private static const VcGoodJob10:Class = Assets_VcGoodJob10;
      
      private static const VcBye3:Class = Assets_VcBye3;
      
      private static const VcGoodJob21:Class = Assets_VcGoodJob21;
      
      private static const VcGoodLuck1:Class = Assets_VcGoodLuck1;
      
      private static const VcGoodLuck2:Class = Assets_VcGoodLuck2;
      
      private static var lastGiveUp:int = -1;
       
      
      public function Assets()
      {
         super();
      }
      
      public static function playGiveUp() : void
      {
         var c:int = 0;
         if(lastGiveUp == -1)
         {
            lastGiveUp = Math.floor(Math.random() * ARR_GIVEUP.length);
         }
         else
         {
            c = lastGiveUp;
            while(c == lastGiveUp)
            {
               lastGiveUp = Math.floor(Math.random() * ARR_GIVEUP.length);
            }
         }
         FP.play(ARR_GIVEUP[lastGiveUp],GIVEUPVOL);
      }
      
      public static function playGoodJob() : void
      {
         var c:int = 0;
         if(FP.choose(true,false,false,false))
         {
            return;
         }
         if(lastGoodJob == -1)
         {
            lastGoodJob = Math.floor(Math.random() * ARR_GOODJOB.length);
         }
         else
         {
            c = lastGoodJob;
            while(c == lastGoodJob)
            {
               lastGoodJob = Math.floor(Math.random() * ARR_GOODJOB.length);
            }
         }
         FP.play(ARR_GOODJOB[lastGoodJob],VCVOL);
      }
      
      public static function checkDomain(stage:Stage, domain:String) : Boolean
      {
         var url:String = stage.loaderInfo.url;
         var startCheck:int = url.indexOf("://") + 3;
         var domainLen:int = url.indexOf("/",startCheck) - startCheck;
         var d:String = url.substr(startCheck,domainLen);
         var splits:Array = d.split(".");
         d = splits[splits.length - 2] + "." + splits[splits.length - 1];
         if(d == domain)
         {
            return true;
         }
         return false;
      }
      
      public static function playLoad() : void
      {
         FP.play(ARR_GOODLUCK[Math.floor(Math.random() * ARR_GOODLUCK.length)],VCVOL);
      }
      
      public static function playBye() : void
      {
         FP.play(ARR_BYE[Math.floor(Math.random() * ARR_BYE.length)],VCVOL);
      }
   }
}
