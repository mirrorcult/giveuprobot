package net.flashpunk.debug
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import flash.text.TextFieldType;
	
	public class TASConsole extends Sprite
    {
        public var CurInputLabel:TextField = new TextField;
        public var NextInputLabel:TextField = new TextField;
        public var CurInputField:TextField = new TextField;
        public var NextInputField:TextField = new TextField;
        public var CurTasFramesLabel:TextField = new TextField;
        public var CurTasFramesField:TextField = new TextField;
        public var TasFramesLeftLabel:TextField = new TextField;
        public var TasFramesLeftField:TextField = new TextField;

        public var SaveButton:Bitmap;
        public var StopButton:Bitmap;

        public function TASConsole()
        {
        }

        public function Enable(console:Console):void
        {
            x = FP.width / 2 + 100;
            y = 40;

            graphics.clear();
            graphics.beginFill(0, .75);
            graphics.drawRoundRectComplex(0, 0, 140, 100, 5, 5, 5, 5);


            addChild(CurTasFramesLabel);
            CurTasFramesLabel.defaultTextFormat = console.format(12, 0xFFFFFF, "left");
            CurTasFramesLabel.text = "Current Frame: ";
            CurTasFramesLabel.embedFonts = true;
            CurTasFramesLabel.selectable = false;
            CurTasFramesLabel.width = 100;
            CurTasFramesLabel.height = 16;
            CurTasFramesLabel.x = 4;
            CurTasFramesLabel.y = 4;

            addChild(CurTasFramesField);
            CurTasFramesField.defaultTextFormat = console.format(12, 0xFFFFFF, "right");
            CurTasFramesField.text = "...";
            CurTasFramesField.embedFonts = true;
            CurTasFramesField.selectable = false;
            CurTasFramesField.type = TextFieldType.INPUT;
            CurTasFramesField.width = 40;
            CurTasFramesField.height = 16;
            CurTasFramesField.x = 100;
            CurTasFramesField.y = 4;

            addChild(TasFramesLeftLabel);
            TasFramesLeftLabel.defaultTextFormat = console.format(12, 0xFFFFFF, "left");
            TasFramesLeftLabel.text = "Frames Left: ";
            TasFramesLeftLabel.embedFonts = true;
            TasFramesLeftLabel.selectable = false;
            TasFramesLeftLabel.width = 100;
            TasFramesLeftLabel.height = 16;
            TasFramesLeftLabel.x = 4;
            TasFramesLeftLabel.y = 24;

            addChild(TasFramesLeftField);
            TasFramesLeftField.defaultTextFormat = console.format(12, 0xFFFFFF, "right");
            TasFramesLeftField.text = "...";
            TasFramesLeftField.embedFonts = true;
            TasFramesLeftField.selectable = false;
            TasFramesLeftField.type = TextFieldType.INPUT;
            TasFramesLeftField.width = 40;
            TasFramesLeftField.height = 16;
            TasFramesLeftField.x = 100;
            TasFramesLeftField.y = 24;

            /* Inputs */

            addChild(CurInputLabel);
            CurInputLabel.defaultTextFormat = console.format(12, 0xFFFFFF, "left");
            CurInputLabel.text = "Current Input: ";
            CurInputLabel.embedFonts = true;
            CurInputLabel.selectable = false;
            CurInputLabel.width = 100;
            CurInputLabel.height = 16;
            CurInputLabel.x = 4;
            CurInputLabel.y = 44;

            addChild(CurInputField);
            CurInputField.defaultTextFormat = console.format(12, 0xFFFFFF, "right");
            CurInputField.text = "...";
            CurInputField.embedFonts = true;
            CurInputField.selectable = true;
            CurInputField.type = TextFieldType.INPUT;
            CurInputField.width = 40;
            CurInputField.height = 16;
            CurInputField.x = 100;
            CurInputField.y = 44;

            addChild(NextInputLabel);
            NextInputLabel.defaultTextFormat = console.format(12, 0xFFFFFF, "left");
            NextInputLabel.text = "Next Input: ";
            NextInputLabel.embedFonts = true;
            NextInputLabel.selectable = false;
            NextInputLabel.width = 100;
            NextInputLabel.height = 16;
            NextInputLabel.x = 4;
            NextInputLabel.y = 64;

            addChild(NextInputField);
            NextInputField.defaultTextFormat = console.format(12, 0xFFFFFF, "right");
            NextInputField.text = "...";
            NextInputField.embedFonts = true;
            NextInputField.selectable = true;
            NextInputField.type = TextFieldType.INPUT;
            NextInputField.width = 40;
            NextInputField.height = 16;
            NextInputField.x = 100;
            NextInputField.y = 64;

            addChild(SaveButton = new CONSOLE_SAVE);
            SaveButton.x = 120;
            SaveButton.y = 80;
            SaveButton.alpha = .5;

            addChild(StopButton = new CONSOLE_STOP);
            StopButton.x = 4;
            StopButton.y = 80;
            StopButton.alpha = .5;
        }

        [Embed(source = 'console_save.png')] private const CONSOLE_SAVE:Class;
        [Embed(source = 'console_stop.png')] private const CONSOLE_STOP:Class;
    }

}