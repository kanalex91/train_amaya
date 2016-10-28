package
{
	//import PNGEncoder;
	import com.greensock.*;
	import com.greensock.TweenAlign;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Graphics;
	import flash.display.IGraphicsData;
	import flash.display.Loader;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.*;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.*;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.engine.SpaceJustifier;
	import flash.ui.Mouse;
	import flash.utils.ByteArray;
	import flash.xml.*;
	
	import flashx.textLayout.formats.BackgroundColor;

	public class MyPen
	{
		[Embed(source = "inside lesson/draw_bg.png")]public static const BackG:Class;
		[Embed(source = "inside lesson/clear_paper.png")]public static const ClearP:Class;
		[Embed(source = "menu/menu_bg_bottom_bar.png")]public static const BackG2:Class;
		[Embed(source = "paint/brush_1.png")]public static const Br1:Class;
		[Embed(source = "paint/brush_2.png")]public static const Br2:Class;
		[Embed(source = "paint/brush_3.png")]public static const Br3:Class;
		[Embed(source = "paint/brush_4.png")]public static const Br4:Class;
		[Embed(source = "paint/brush_5.png")]public static const Br5:Class;
		
		[Embed(source = "inside lesson/back_1.png")]public static const Back1:Class;
		[Embed(source = "inside lesson/back_2.png")]public static const Back2:Class;
		[Embed(source = "inside lesson/erase_1.png")]public static const Er1:Class;
		[Embed(source = "inside lesson/erase_2.png")]public static const Er2:Class;
		[Embed(source = "paint/but_11.png")]public static const But11:Class;
		[Embed(source = "paint/but_12.png")]public static const But12:Class;
		[Embed(source = "paint/but_21.png")]public static const But21:Class;
		[Embed(source = "paint/but_22.png")]public static const But22:Class;
		[Embed(source = "paint/but_31.png")]public static const But31:Class;
		[Embed(source = "paint/but_32.png")]public static const But32:Class;
		
		[Embed(source = "paint/avtive.png")]public static const Act:Class;
		[Embed(source = "paint/lines_11.png")]public static const L1:Class;
		[Embed(source = "paint/lines_12.png")]public static const L12:Class;
		[Embed(source = "paint/lines_21.png")]public static const L2:Class;
		[Embed(source = "paint/lines_22.png")]public static const L22:Class;
		[Embed(source = "paint/lines_31.png")]public static const L3:Class;
		[Embed(source = "paint/lines_32.png")]public static const L32:Class;
		[Embed(source = "paint/lines_41.png")]public static const L4:Class;
		[Embed(source = "paint/lines_42.png")]public static const L42:Class;
		[Embed(source = "paint/lines_51.png")]public static const L5:Class;
		[Embed(source = "paint/lines_52.png")]public static const L52:Class;
		
		public static var _sprite:Sprite = new Sprite();
		private var _spr:Array = [];
		private var _buttons:Array = [];
		private var _type:int = 8;
		private var _curColor:uint = 0x000000;
		private var _alpha:int = 1;
		
		private var _picture:Sprite = new Sprite();
		public static var raw:BitmapData;
		public static var brr:ByteArray;
		public static var fil:FileReference;

		private var _topBg:Bitmap = new Paint.BackG3();
		private var timeline:TimelineMax = new TimelineMax({repeat:0});
		private var bitmap:Bitmap = new BackG();
		private var _clearP:Bitmap = new ClearP();
		private var bg:BitmapData = bitmap.bitmapData;
		private var bitmap2:Bitmap = new BackG2();
		private var PenStyle:Array = [8,13,17,23,35];
		private var timeline_pen:Array = [];
		private var timeline_penBack:Array = [];
		public static var _sheetofPaper:Sprite = new Sprite();
		private var curPen:int = -1;
		private var _Im:Array = [];
		public static var _index:int = 1;
		private var xx:Number;
		private var yy:Number;
		
		public function MyPen()
		{
			bitmap2.y = 995;

			_sheetofPaper.graphics.beginFill(0x000000,0);
			_sheetofPaper.graphics.drawRect(0,0,768,496);
			_sheetofPaper.graphics.endFill();
			_sheetofPaper.y = 528;
			_sprite.addChild(_sheetofPaper);
			
			_topBg.x = 0;
			_topBg.y = -528;
			_sheetofPaper.addChild(_topBg);
			
			_sheetofPaper.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_sheetofPaper.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			_picture.graphics.beginFill(0xffffff,0);
			_picture.graphics.drawRect(0,0,bitmap.width,bitmap.height);
			_picture.graphics.endFill();
			_sprite.graphics.beginBitmapFill(bg);
			
			
			_sprite.addChild(bitmap2);
			_sprite.graphics.drawRect(0,0,bitmap.width,bitmap.height);
			_sprite.graphics.endFill();
			
			_sprite.addChild(ColorPicker._sprite);
			for(var i:int = 0;i<5;i++)
			{
				createButton(620,i*70+150,80,40,i+1);
			}
			createBut(160,20,80,40,1);
			createBut(20,20,80,40,2);
			
			createBut(380,20,80,40,3);
			createBut(505,20,80,40,4);
			createBut(630,20,80,40,5);
			
			
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			/*if(_alpha == 0){_sheetofPaper.graphics.lineStyle(_type,0);_sheetofPaper.graphics.lineBitmapStyle(_clearP.bitmapData);}
			if(_alpha == 100)*/{ _sheetofPaper.graphics.lineStyle(_type,_curColor,_alpha);}
			
			xx = _sheetofPaper.mouseX;
			yy = _sheetofPaper.mouseY;
			_sheetofPaper.graphics.moveTo(_sheetofPaper.mouseX,_sheetofPaper.mouseY);
			_sheetofPaper.graphics.lineTo(_sheetofPaper.mouseX,_sheetofPaper.mouseY+1);
			_sheetofPaper.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		private function onMouseUp(e:MouseEvent):void
		{
			_sheetofPaper.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		private function onMouseMove(e:MouseEvent):void
		{
		
			_sheetofPaper.graphics.lineStyle(_type,_curColor,_alpha);
			_sheetofPaper.graphics.moveTo(xx,yy);
			_sheetofPaper.graphics.lineTo(_sheetofPaper.mouseX,_sheetofPaper.mouseY);
			_sheetofPaper.graphics.lineStyle(_type-4, 0, 0);
			_sheetofPaper.graphics.moveTo(xx,yy);
			_sheetofPaper.graphics.lineTo(_sheetofPaper.mouseX,_sheetofPaper.mouseY);
			xx = _sheetofPaper.mouseX;
			yy = _sheetofPaper.mouseY;
		}

		private function changeType(x:int):void
		{
			_type = x;
		}
		private function createButton(X:int, Y:int, H:int, W:int, br:int):void
		{
			var sp1:Sprite = new Sprite();
			var sp2:Sprite = new Sprite();
			var sp3:Sprite = new Sprite();
			var sp4:Sprite = new Sprite();
			var _but:SimpleButton = new SimpleButton();
			var pen:Bitmap = new Br1();
			var pen2:Bitmap = new Br1();
			var line1:Bitmap = new Br1();
			var line2:Bitmap = new Br1();
			var av:Bitmap = new Act();
			
			if(br == 1){pen = new Br1();pen2 = new Br1();line1 = new L1;line2 = new L12;}
			else if(br == 2){pen = new Br2();pen2 = new Br2();line1 = new L2;line2 = new L22;}
			else if(br == 3){pen = new Br3();pen2 = new Br3();line1 = new L3;line2 = new L32;}
			else if(br == 4){pen = new Br4();pen2 = new Br4();line1 = new L4;line2 = new L42;}
			else if(br == 5){pen = new Br5();pen2 = new Br5();line1 = new L5;line2 = new L52;}
				
			pen.x = X;
			pen.y = Y;
			pen2.x = X;
			pen2.y = Y;
			
			line1.x = X-180;
			line1.y = Y - 5;
			line2.x = X-180;
			line2.y = Y - 5;
			av.x = X - 110;
			av.y = Y - 35;
			
			sp1.addChild(line1);
			sp1.addChild(pen);
			
			sp2.addChild(line2);
			sp2.addChild(av);
			
			sp4.addChild(line2);
			sp4.addChild(av);
			sp4.addChild(pen2);
			//sp4.x -= 50;
			
			_but.x += 50;
			_but.upState = sp1;
			_but.downState = sp1;
			_but.hitTestState = sp4;
			_but.overState = sp1;
		
			_sprite.addChild(_but);
			_but.addEventListener(MouseEvent.CLICK,onClick);
			_buttons.push(_but);
			var tmp:TimelineLite = new TimelineLite();
			var tmp1:TimelineLite = new TimelineLite();
			tmp.append(TweenLite.to(pen2, 0.5, {x:"-40"}));
			tmp.stop();
			timeline_pen.push(tmp);
			tmp1.stop();
			tmp1.append(TweenLite.from(pen, 0.5, {x:"-40"}));
			TweenLite.to(pen, 0.5, {x:"40"});
			timeline_penBack.push(tmp1);
	
		}
		
		private function createBut(X:int, Y:int, H:int, W:int, br:int):void
		{
			var sp1:Sprite = new Sprite();
			var sp2:Sprite = new Sprite();
			var sp3:Sprite = new Sprite();
			var sp4:Sprite = new Sprite();
			var _but:SimpleButton = new SimpleButton();
			var but:Bitmap;
			var butact:Bitmap;
			
			if(br == 2){but = new Back1;butact = new Back2;}
			else if(br == 1){but = new Er1;butact = new Er2;}
			else if(br == 3){but = new But11;butact = new But12;}
			else if(br == 4){but = new But21;butact = new But22;}
			else if(br == 5){but = new But31;butact = new But32;}
			
			but.x = X;
			but.y = Y;
			butact.x = X;
			butact.y = Y;
			
			_but.upState = but;
			_but.downState = butact;
			_but.hitTestState = but;
			_but.overState = butact;
			
			_sprite.addChild(_but);
			_but.addEventListener(MouseEvent.CLICK,onClick);
			_buttons.push(_but);
			
		}
		
				
		private function onClick(event:MouseEvent):void
		{
//			for(var i:int = 0;i < 5; i++)
//			{
//				(SimpleButton)(_buttons[i]).upState = (SimpleButton)(_buttons[i]).downState;
//			}
			for(var k:int = 0; k < 5; k++)
			{
				for(var i:int = 0;i<5;i++)
				{
					if(k == curPen && event.currentTarget == _buttons[i])
					{
						(SimpleButton)(_buttons[k]).upState = (SimpleButton)(_buttons[k]).downState;
						(SimpleButton)(_buttons[k]).overState = (SimpleButton)(_buttons[k]).upState;
						(TimelineLite)(timeline_penBack[k]).restart();
					}
				}
			}
			for(k = 0; k < 5; k++)
			{
				if(event.currentTarget == _buttons[k])
				{
					curPen = k;
					changeType(PenStyle[k]);	
					(SimpleButton)(_buttons[k]).upState = (SimpleButton)(_buttons[k]).hitTestState;
					(SimpleButton)(_buttons[k]).overState = (SimpleButton)(_buttons[k]).upState;
					(TimelineLite)(timeline_pen[k]).restart();
				}	
			}
			if(event.currentTarget == _buttons[5])
			{
				
				_sheetofPaper.graphics.clear();
				_sheetofPaper.graphics.beginFill(0x000000,0);
				_sheetofPaper.graphics.drawRect(0,0,768,496);
				_sheetofPaper.graphics.endFill();
				_sheetofPaper.graphics.lineStyle(10,0x000000);	
				
				changeType(_type);
//				for(k = 0;k < 5;k++)
//				{
//					if(_type == PenStyle[k])(SimpleButton)(_buttons[k]).upState = (SimpleButton)(_buttons[k]).overState;
//				}
				
				_sprite.graphics.lineStyle(10,0X000000);
								
			}
			else if(event.currentTarget == _buttons[6])
			{
				MainWindow1.container.visible = true;
				
				TweenLite.to(MainWindow1.container,0.5,{x:"768"});
				TweenLite.to(_sprite,0.5,{x:"768",onComplete:saveHandler});
				
				for(k = 0;k < 30; k++)
				{ 
					(SimpleButton)(ColorPicker._Bcolors[k]).upState = (SimpleButton)(ColorPicker._Bcolors[k]).overState;
				}
				(SimpleButton)(ColorPicker._Bcolors[0]).upState = (SimpleButton)(ColorPicker._Bcolors[0]).hitTestState;
			}
		} 
		public function changeColor(col:uint,clear:Boolean = false):void
		{
			if(clear)_alpha = 0;
			else _alpha = 1;
			_curColor = col;
		}
		
		public function saveHandler():void
		{
			_sheetofPaper.removeChild(Source._pictures[MainWindow1._curTarget]);
			var bd:BitmapData = new BitmapData(768, 472, true, 0x000000);
			var _rect:Rectangle = new Rectangle(0,0,768,500);
			bd.draw(_sheetofPaper);
			var bitmap:Bitmap = new Bitmap(bd);
			var bitmap1:Bitmap = new Bitmap(bd.clone());
			var bitmap2:Bitmap = new Bitmap(bd.clone());
			bitmap1.smoothing = true;
			bitmap1.x -= 35;
			bitmap1.y -= 25;
			bitmap1.width = 100;
			bitmap1.height = 70;
			bitmap2.smoothing = true;
			bitmap2.x -= 35;
			bitmap2.y -= 25;
			bitmap2.width = 100;
			bitmap2.height = 70;
			
			(Sprite)((SimpleButton)(MainWindow1._pictures2[_index]).upState).removeChildAt(2);
			(Sprite)((SimpleButton)(MainWindow1._pictures2[_index]).upState).addChildAt(bitmap1,2);
			(Sprite)((SimpleButton)(MainWindow1._pictures2[_index]).downState).removeChildAt(2);
			(Sprite)((SimpleButton)(MainWindow1._pictures2[_index]).downState).addChildAt(bitmap2,2);

			Source._pictures2[_index] = bitmap;
			var _brr:ByteArray = bd.getPixels(_rect);
			_brr = PNGEncoder.encode(bd);
			
			var file:File = File.applicationStorageDirectory.resolvePath("RGBImage_"+_index+".png");
			var f:FileStream = new FileStream();
			f.openAsync(file,FileMode.WRITE);
			f.writeBytes(_brr);
			f.close();
			
			_sheetofPaper.graphics.clear();
			_sheetofPaper.graphics.beginFill(0x000000,0);
			_sheetofPaper.graphics.drawRect(0,0,768,496);
			_sheetofPaper.graphics.endFill();
			_sheetofPaper.graphics.lineStyle(10,0x000000);
			changeType(10);
			_alpha = 1;
			changeColor(0x000000);
		}
	}
}