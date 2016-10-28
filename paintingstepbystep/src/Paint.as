package
{
	
	import PNGEncoder;
	
	import com.greensock.TweenAlign;
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.ColorCorrection;
	import flash.display.IGraphicsData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
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
	import flash.text.*;
	import flash.text.engine.SpaceJustifier;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.utils.ByteArray;
	import flash.xml.*;
	
	import org.osmf.net.StreamingURLResource;
	
	public class Paint
	{
		[Embed(source = "inside lesson/draw_bg3.png")]public static const BackG3:Class;
		[Embed(source = "inside lesson/dot_1.png")]public static const Dot1:Class;
		[Embed(source = "inside lesson/dot_2.png")]public static const Dot2:Class;
		
		[Embed(source = "inside lesson/arrow_1.png")]public static const Arr1:Class;
		[Embed(source = "inside lesson/arrow_2.png")]public static const Arr2:Class;
		[Embed(source = "inside lesson/arrow_1_1.png")]public static const Arr21:Class;
		[Embed(source = "inside lesson/arrow_2_1.png")]public static const Arr22:Class;
		[Embed(source = "inside lesson/undo_1.png")]public static const Un1:Class;
		[Embed(source = "inside lesson/undo_2.png")]public static const Un2:Class;
		[Embed(source = "inside lesson/lines_1.png")]public static const Lin1:Class;
		[Embed(source = "inside lesson/lines_2.png")]public static const Lin2:Class;
		
		public static var _first:Boolean = true;
		private var _curP:int = 0;
		private var _delP:int = -1;
		public static var _sprite:Sprite = new Sprite();
		private var bitmap:Bitmap = new MyPen.BackG();
		private var _topBg:Bitmap = new BackG3();
		private var bg:BitmapData = bitmap.bitmapData;
		private var bitmap2:Bitmap = new MyPen.BackG2();
		private var _buttons:Array = [];
		public static var img:Bitmap = new Bitmap;
		private var _dot:Bitmap = new Dot1;
		private var _dot2:Bitmap = new Dot2;
		private var _del:Boolean = false;
		public static var _Im:Array = [];
		private var pos:int = 1;
		public static var _sheetofPaper:Sprite = new Sprite();
		public static var _index:int = 1;
		
		public function Paint()
		{
			_sheetofPaper.graphics.beginFill(0xffffff,0);
			_sheetofPaper.graphics.drawRect(0,0,768,496);
			_sheetofPaper.graphics.endFill();
			_sheetofPaper.y = 528;
			
			_sheetofPaper.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_sheetofPaper.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_sprite.addChild(_sheetofPaper);
			
			_topBg.x = 0;
			_topBg.y = -528;
			_sheetofPaper.addChild(_topBg);
			
			_sprite.graphics.beginBitmapFill(bg);
			bitmap2.y = 995;
			_sprite.addChild(bitmap2);
			_sprite.graphics.drawRect(0,0,bitmap.width,bitmap.height);
			_sprite.graphics.endFill();
			
			createButton(30,150,80,40,1);
			createButton(660,150,80,40,2);
			createButton(30,400,80,40,3);
			createButton(30,30,80,40,4);
			createButton(630,30,80,40,5);
			createButton(630,400,80,40,6);
			for(var i:int=0;i<6;i++)
			{
				var copy:BitmapData = _dot.bitmapData.clone();
				var copydot:Bitmap = new Bitmap();
				copydot.bitmapData = copy;
				copydot.x = 285 + i*35;
				copydot.y = 450;
				
				_sprite.addChild(copydot);
			}
	
			_dot2.x = 285;
			_dot2.y = 450;
			
			_sprite.addChild(_dot2);
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			_sheetofPaper.graphics.lineStyle(8,0x000000,1);
			_Im.push(new MyLine(10,0,0,_sheetofPaper.mouseX,_sheetofPaper.mouseY,"false"));
			_Im.push(new MyLine(10,_sheetofPaper.mouseX,_sheetofPaper.mouseY+1,0,0,"true"));
			_sheetofPaper.graphics.moveTo(_sheetofPaper.mouseX,_sheetofPaper.mouseY);
			_sheetofPaper.graphics.lineTo(_sheetofPaper.mouseX,_sheetofPaper.mouseY+1);
				_sheetofPaper.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		private function onMouseUp(e:MouseEvent):void
		{
			_Im.push(new MyLine(10,0,0,_sheetofPaper.mouseX,_sheetofPaper.mouseY,"false"));
			_sheetofPaper.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		private function onMouseMove(e:MouseEvent):void
		{
			_Im.push(new MyLine(10,_sheetofPaper.mouseX,_sheetofPaper.mouseY,0,0,"true"));
			_sheetofPaper.graphics.lineTo(_sheetofPaper.mouseX,_sheetofPaper.mouseY);
		}
		
		private function createButton(X:int, Y:int, H:int, W:int, br:int):void
		{
			var _but:SimpleButton = new SimpleButton();
			var bit:Bitmap;
			var bit2:Bitmap;
			if(br == 1){bit = new Arr1();bit2 = new Arr2();}
			else if(br == 2){bit = new Arr21();bit2 = new Arr22();}
			else if(br == 3){bit = new Un1();bit2 = new Un2();}
			else if(br == 4){bit = new MyPen.Back1();bit2 = new MyPen.Back2();}
			else if(br == 5){bit = new MyPen.Er1();bit2 = new MyPen.Er2();}
			else if(br == 6){bit = new Lin1();bit2 = new Lin2();}
			
			
			
			_but.x = X;
			_but.y = Y;
			
			_but.upState = bit;
			_but.downState = bit2;
			_but.hitTestState = bit;
			_but.overState = bit2;
			
			_sprite.addChild(_but);
			_but.addEventListener(MouseEvent.CLICK,onClick);
			_buttons.push(_but);
			
		}
		
		private function onClick(event:MouseEvent):void
		{
			if(event.currentTarget == _buttons[0])
			{
				_sprite.removeChild(MyPictures._pictures[MainWindow1._curTarget2*6+_curP]);
				_sprite.removeChild(img);
				if(_curP != 0){_dot2.x -= 35;_curP--;}	
				helper(_curP,150,100);
			}
			else if(event.currentTarget == _buttons[1])
			{
				_sprite.removeChild(MyPictures._pictures[MainWindow1._curTarget2*6+_curP]);
				
				_sprite.removeChild(img);
				if(_curP != 5){_dot2.x += 35;_curP++;}
				helper(_curP,150,100);
			}
			else if(event.currentTarget == _buttons[2])
			{
				_sheetofPaper.graphics.clear();
				
				if(_first)_sheetofPaper.graphics.beginBitmapFill(Source._pictures[MainWindow1._curTarget2].bitmapData);
				else _sheetofPaper.graphics.beginFill(0x000000,0);
				_sheetofPaper.graphics.drawRect(0,0,768,496);
				_sheetofPaper.graphics.endFill();
				_sheetofPaper.graphics.lineStyle(10,0x000000);
				var tmp:MyLine;
				if(_Im.length != 0)
				{
					tmp = _Im.pop();
					
					do
					{
						tmp = _Im.pop();
					}
					while(tmp._draw == "true" && _Im.length != 0)
						
					while(tmp._draw == "false" && _Im.length != 0)
					{
						tmp = _Im.pop();
					}
					if(tmp._draw == "true")_Im.push(tmp);
					
				}
				for(var i:int = 0;i<_Im.length;i++)
				{
					tmp = _Im[i];
					if(tmp._draw == "true")
					{
						_sheetofPaper.graphics.lineTo(tmp._X,tmp._Y);
					}
					else
					{
						_sheetofPaper.graphics.moveTo(tmp._MoveX,tmp._MoveY);
					}
				}
				
					
			}
			else if(event.currentTarget == _buttons[3])
			{
				//saveHandler();
				_Im = [];
				_sprite.removeChild(MyPictures._pictures[MainWindow1._curTarget2*6+_curP]);
				_curP = 0;
				_delP = -1;
				_del = false;
				_dot2.x = 285;
				if(_sprite.contains(img))_sprite.removeChild(img);
				
				MainWindow1.container2.visible = true;
				
				TweenLite.to(_sprite,0.5,{x:"768"});
				TweenLite.to(MainWindow1.container2,0.5,{x:"768",onComplete:saveHandler});
			}
			else if(event.currentTarget == _buttons[4])
			{
				_Im = [];
				_first = false;
				_sheetofPaper.graphics.clear();
				_sheetofPaper.graphics.beginFill(0x000000,0);
				_sheetofPaper.graphics.drawRect(0,0,768,496);
				_sheetofPaper.graphics.endFill();
				_sheetofPaper.graphics.lineStyle(10,0x000000);	
				
			}
			else if(event.currentTarget == _buttons[5])
			{
				if(_del)
				{
					_del = false;
					img.visible = false;
					_buttons[5].upState = _buttons[5].hitTestState;
				}
				else
				{
					_del = true;
					img.visible = true;
					_buttons[5].upState = _buttons[5].downState;
				}
			}
		}
		
		
		
		
		
		private function helper(k:int,x:int,y:int):void
		{	
				var bitmapdata:BitmapData = MyPictures._pictures[MainWindow1._curTarget2*6+k].bitmapData.clone();
				img.bitmapData = bitmapdata;
				img.smoothing = true;
				img.x = x;
				img.y = y+500;
				img.scaleX = 0.4;
				img.scaleY = 0.4;
				img.alpha = 0.5;
				_sprite.addChild(img);
			
			
				MyPictures._pictures[MainWindow1._curTarget2*6+k].x = x;
				MyPictures._pictures[MainWindow1._curTarget2*6+k].y = y;
				MyPictures._pictures[MainWindow1._curTarget2*6+k].scaleX = 0.4;
				MyPictures._pictures[MainWindow1._curTarget2*6+k].scaleY = 0.4;
				MyPictures._pictures[MainWindow1._curTarget2*6+k].alpha = 1;
				//TweenLite.from(MyPictures._pictures[MainWindow1._curTarget2*6+k],2,{alpha:0});
				_sprite.addChild(MyPictures._pictures[MainWindow1._curTarget2*6+k]);
		}
		
		public function saveHandler():void
		{
		
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

			(Sprite)((SimpleButton)(MainWindow1._pictures2[_index]).upState).removeChildAt(3);
			(Sprite)((SimpleButton)(MainWindow1._pictures2[_index]).upState).addChildAt(bitmap1,3);
			(Sprite)((SimpleButton)(MainWindow1._pictures2[_index]).downState).removeChildAt(3);
			(Sprite)((SimpleButton)(MainWindow1._pictures2[_index]).downState).addChildAt(bitmap2,3);
			
			Source._pictures[_index] = bitmap;
			//bd.setPixels(_rect,_brr);
			
			var _brr:ByteArray = bd.getPixels(_rect);
			_brr = PNGEncoder.encode(bd);
			
			var file:File = File.applicationStorageDirectory.resolvePath("Image_"+_index+".png");
			var f:FileStream = new FileStream();
			f.openAsync(file,FileMode.WRITE);
			f.writeBytes(_brr);
			f.close();
			
			_sheetofPaper.graphics.clear();
			_sheetofPaper.graphics.beginFill(0x000000,0);
			_sheetofPaper.graphics.drawRect(0,0,768,496);
			_sheetofPaper.graphics.endFill();
			_sheetofPaper.graphics.lineStyle(10,0x000000);	
			
		}
	}
}