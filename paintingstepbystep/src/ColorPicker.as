package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.ui.Mouse;

	public class ColorPicker
	{
		[Embed(source = "paint/baint_normal.png")]public static const Frame:Class;
		[Embed(source = "paint/baint_selected.png")]public static const Frame1:Class;
		public static var _Bcolors:Array = [];
		public static var _sprite:Sprite = new Sprite();
		private var bitmap:Bitmap = new MyPen.BackG();
		private var _colors:Array = [[0x000000, 0xffffff, 0xff0000, 0x00ff00, 0x0000ff, 0x0a02f0],
									 [0xf000f0, 0x0f00f0, 0xaaf000, 0x000fb0, 0x0ff0f0, 0x0aa90f],
									 [0x00f00f, 0x000fff, 0xfaf000, 0x00aff0, 0x0aa00f, 0x8300ff],
									 [0x0f0f00, 0xf0fff0, 0x330000, 0x004400, 0x909044, 0x0a0f0f],
									 [0xf50550, 0xfaa00f, 0xff3030, 0x40ff00, 0x900a22, 0xffffff]];
		private var _Pen:MyPen = new MyPen();
		
		public function ColorPicker()
		{
			for(var i:int = 0;i < 5;i++)
			{
				for(var j:int = 0;j < 6;j++)
				createButton(40+j*70,140+i*70,_colors[i][j],i+j);		
			}		
			(SimpleButton)(_Bcolors[0]).upState = (SimpleButton)(_Bcolors[0]).overState;
		}
		private function createButton(X:int, Y:int, col:uint, s:int):void
		{
			var sp1:Sprite = new Sprite();
			var sp2:Sprite = new Sprite();
			var sp3:Sprite = new Sprite();
			var sp4:Sprite = new Sprite();
			var _but:SimpleButton = new SimpleButton();
			var bitmap:Bitmap = new Frame();
			var bitmap1:Bitmap = new Frame1();
			
			
			
			sp1.graphics.beginFill(col);
			sp1.graphics.drawRoundRect(X,Y+1,66,66,30,30);
			sp1.graphics.endFill();
			bitmap.x = X;
			bitmap.y = Y;
			sp1.addChild(bitmap);
			
			sp4.graphics.beginFill(col);
			sp4.graphics.drawRoundRect(X,Y+1,66,66,30,30);
			sp4.graphics.endFill();
			bitmap1.x = X;
			bitmap1.y = Y;
			sp4.addChild(bitmap1);
			
			if(s != 9)
			{
				_but.upState = sp1;
				_but.downState = sp4;
				_but.hitTestState = sp4;
				_but.overState = sp1;
			}
			else
			{
				_but.upState = bitmap;
				_but.downState = bitmap1;
				_but.hitTestState = bitmap1;
				_but.overState = bitmap;			
			}
			_sprite.addChild(_but);
			_but.addEventListener(MouseEvent.CLICK,onClick);
			_Bcolors.push(_but);
							
		}
		
		private function onClick(event:MouseEvent):void
		{
			for(var i:int = 0;i < 30; i++)
			{ 
				(SimpleButton)(_Bcolors[i]).upState = (SimpleButton)(_Bcolors[i]).overState;
			}
			for(var k:int = 0; k < 30; k++)
			{
				if(event.currentTarget == _Bcolors[k])
					(SimpleButton)(_Bcolors[k]).upState = (SimpleButton)(_Bcolors[k]).hitTestState;
			}
			for(i = 0; i < 5; i++)
			{
				for(var j:int = 0; j < 6; j++)
				{
					if(event.currentTarget == _Bcolors[i*6+j]){_Pen.changeColor(_colors[i][j],j+i == 9);}
				}
			}
		}
	}
}