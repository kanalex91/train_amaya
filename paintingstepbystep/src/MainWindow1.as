package
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.net.SharedObject;
	import flash.net.URLRequest;
	import flash.net.drm.AddToDeviceGroupSetting;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	

	public class MainWindow1
	{
		[Embed(source = "menu/about_1.png")]public static const About1:Class;
		[Embed(source = "menu/about_2.png")]public static const About2:Class;
		[Embed(source = "menu/paper_1.png")]public static const Paper1:Class;
		[Embed(source = "menu/paper_2.png")]public static const Paper2:Class;
		[Embed(source = "menu/menu_bg.png")]public static const Menu:Class;
		[Embed(source = "Tittle/step-by-step_ru.png")]public static const Sbs:Class;
		[Embed(source = "Tittle/step-by-step_ba.png")]public static const Sbs_ba:Class;
		[Embed(source = "Tittle/step-by-step_ch.png")]public static const Sbs_ch:Class;
		[Embed(source = "Tittle/step-by-step_fr.png")]public static const Sbs_fr:Class;
		[Embed(source = "Tittle/step-by-step_en.png")]public static const Sbs_en:Class;
		[Embed(source = "Tittle/tittle_bg.png")]public static const Tbg:Class;
		
		[Embed(source = "menu/draw_1.png")]public static const Dr1:Class;
		[Embed(source = "menu/draw_2.png")]public static const Dr2:Class;
		[Embed(source = "menu/paint_1.png")]public static const Paint1:Class;
		[Embed(source = "menu/paint_2.png")]public static const Paint2:Class;
		
		[Embed(source = "menu/pins/pin_1.png")]public static const Pin1:Class;
		[Embed(source = "menu/pins/pin_2.png")]public static const Pin2:Class;
		[Embed(source = "menu/pins/pin_3.png")]public static const Pin3:Class;
		[Embed(source = "menu/pins/pin_4.png")]public static const Pin4:Class;
		[Embed(source = "menu/pins/pin_5.png")]public static const Pin5:Class;
		[Embed(source = "menu/pins/pin_6.png")]public static const Pin6:Class;
		[Embed(source = "menu/pins/pin_7.png")]public static const Pin7:Class;
		[Embed(source = "menu/pins/pin_8.png")]public static const Pin8:Class;
	
	
		public static var _curTarget:int = -1;
		
		private var k:int = 0;
		
		private var X2:int = -125;
		private var Y2:int = 165;
		private var i2:int = 1;
		
		private var X3:int = -125;
		private var Y3:int = 165;
		private var i:int = 0;
		private var i0:int = 0;
		public static var _curTarget2:int = -1;
		
		private var _ImLoader:Loader = new Loader();
		private var _ImLoader2:Loader = new Loader();
		private var _buttons:Array = [];
		public static var _pictures2:Array = [];
		public static var _pictures:Array = [];
		
		private var _pin1:Bitmap = new Pin1();
		private var _pin2:Bitmap = new Pin2();
		private var _pin3:Bitmap = new Pin3();
		private var _pin4:Bitmap = new Pin4();
		private var _pin5:Bitmap = new Pin5();
		private var _pin6:Bitmap = new Pin6();
		private var _pin7:Bitmap = new Pin7();
		private var _pin8:Bitmap = new Pin8();
		private var _back:Boolean = false;
		
		private var _pins:Array = [_pin1,_pin2,_pin3,_pin4,_pin5,_pin6,_pin7,_pin8];
		public static var container:Sprite = new Sprite();
		public static var container2:Sprite = new Sprite();
		
		private var bitmap:Bitmap = new Menu();
		private var bg:BitmapData = bitmap.bitmapData;
		
		private var bitmap2:Bitmap = new MyPen.BackG2();
		private var bitmap3:Bitmap = new Sbs();
		private var bitmap31:Bitmap = new Tbg();
		private var bitmap32:Bitmap = new Tbg();
		private var bitmap33:Bitmap = new Tbg();
		private var bitmap34:Bitmap = new Tbg();
		private var bitmap4:Bitmap = new Tbg();
		
		private var bitmap12:Bitmap = new MyPen.BackG2();

		private var bitmap_ba:Bitmap = new Sbs_ba();
		private var bitmap_ch:Bitmap = new Sbs_ch();
		private var bitmap_fr:Bitmap = new Sbs_fr();
		private var bitmap_en:Bitmap = new Sbs_en();
		
		private var timeline:TimelineMax = new TimelineMax();
		
		public static var timelineMenu:TimelineMax = new TimelineMax();
		public static var window:Sprite = new Sprite();
		public static var _title_ru:Sprite = new Sprite();
		public static var _title_en:Sprite = new Sprite();
		public static var _title_fr:Sprite = new Sprite();
		public static var _title_ba:Sprite = new Sprite();
		public static var _title_ch:Sprite = new Sprite();
		public static var titles:Array = [_title_en,_title_ru,_title_fr,_title_ch,_title_ba];

		public function MainWindow1()
		{
			window.visible = false;
			window.graphics.beginFill(0x000000,1);
			window.graphics.drawRect(0,0,bitmap.width,bitmap.height);
			window.graphics.endFill();
			
			timelineMenu.stop();
			timelineMenu.append(TweenLite.to(About_game._sprite,1,{y:"-934"}));
			
			timeline.active = false;
			
			bitmap3.x = 135;
			bitmap3.y = 25;
			bitmap31.x = 60;
			bitmap31.y = 20;
			bitmap32.x = 60;
			bitmap32.y = 20;
			bitmap33.x = 60;
			bitmap33.y = 20;
			bitmap34.x = 60;
			bitmap34.y = 20;
			
			bitmap4.x = 60;
			bitmap4.y = 20;
			bitmap_ba.x = 135;
			bitmap_ba.y = 25;
			bitmap_ch.x = 135;
			bitmap_ch.y = 25;
			bitmap_fr.x = 135;
			bitmap_fr.y = 25;
			bitmap_en.x = 135;
			bitmap_en.y = 25;
			
			_title_ru.addChild(bitmap4);
			_title_ru.addChild(bitmap3);
			_title_en.addChild(bitmap31);
			_title_en.addChild(bitmap_en);
			_title_ch.addChild(bitmap32);
			_title_ch.addChild(bitmap_ch);
			_title_ba.addChild(bitmap33);
			_title_ba.addChild(bitmap_ba);
			_title_fr.addChild(bitmap34);
			_title_fr.addChild(bitmap_fr);
			
			_title_en.y -= 200;
			_title_ch.y -= 200;
			_title_ba.y -= 200;
			_title_fr.y -= 200;
			
			container2.graphics.beginBitmapFill(bg);
			
			container2.addChild(_title_ru);
			container2.addChild(_title_ch);
			container2.addChild(_title_fr);
			container2.addChild(_title_en);
			container2.addChild(_title_ba);
			container2.graphics.drawRect(0,0,bitmap.width,bitmap.height);
			container2.graphics.endFill();
			
			bitmap2.y = 995;
			container2.addChild(bitmap2);
			
			container.graphics.beginBitmapFill(bg);
			container.graphics.drawRect(0,0,bitmap.width,bitmap.height);
			container.graphics.endFill();
			
			bitmap12.y = 995;
			container.addChild(bitmap12);
			
			TweenLite.from(_title_ru,1,{y:"-200"});

			var path:String = new String(File.applicationStorageDirectory.resolvePath("RGBImage_0.png").url);
			_ImLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			_ImLoader.load(new URLRequest(path));
				
			container.visible = false;
			
		}
		
		private function onClick(event:MouseEvent):void
		{
			for(var k:int = 0; k < 30; k++)
			{
				if(event.currentTarget == _pictures2[k])
				{
					_curTarget = k;
					MyPen._index = _curTarget;
				}
			}
			
			for(k = 0; k < 30; k++)
			{
				if(event.currentTarget == _pictures[k])
				{
					_curTarget2 = k;
					Paint._index = _curTarget2;
				}
			}
			
			if(event.currentTarget == _buttons[0])
			{
				if(!container.visible)
				{
					paintingstepbystep.timeline2.restart();
					
					container.addChildAt(_title_ru,0);
					container.addChildAt(_title_en,0);
					container.addChildAt(_title_ba,0);
					container.addChildAt(_title_ch,0);
					container.addChildAt(_title_fr,0);
					
					container.visible = true;
					(SimpleButton)(_buttons[1]).upState = (SimpleButton)(_buttons[1]).hitTestState;
					(SimpleButton)(_buttons[0]).upState = (SimpleButton)(_buttons[0]).downState;
					(SimpleButton)(_buttons[0]).overState = (SimpleButton)(_buttons[0]).upState;
					(SimpleButton)(_buttons[1]).overState = (SimpleButton)(_buttons[1]).upState;
					
					container2.visible = false;
					
					if(container2.contains(_buttons[0]) && container2.contains(_buttons[1]) && container.contains(_buttons[2]))
					{
						container2.removeChild(_buttons[0]);
						container2.removeChild(_buttons[1]);
						container2.removeChild(_buttons[2]);
					}
					container.addChild(_buttons[0]);
					container.addChild(_buttons[1]);
					container.addChild(_buttons[2]);
				}
			}
			else if(event.currentTarget == _buttons[1])
			{
				if(!container2.visible)
				{
				paintingstepbystep.timeline.restart();
				
				container2.addChildAt(_title_ru,0);
				container2.addChildAt(_title_en,0);
				container2.addChildAt(_title_ba,0);
				container2.addChildAt(_title_ch,0);
				container2.addChildAt(_title_fr,0);
				
				container2.visible = true;
				(SimpleButton)(_buttons[0]).upState = (SimpleButton)(_buttons[0]).hitTestState;
				(SimpleButton)(_buttons[1]).upState = (SimpleButton)(_buttons[1]).downState;
				(SimpleButton)(_buttons[1]).overState = (SimpleButton)(_buttons[1]).upState;
				(SimpleButton)(_buttons[0]).overState = (SimpleButton)(_buttons[0]).upState;
				container.visible = false;
				
				if(container.contains(_buttons[0]) && container.contains(_buttons[1]) && container.contains(_buttons[2]))
				{
					container.removeChild(_buttons[0]);
					container.removeChild(_buttons[1]);
					container.removeChild(_buttons[2]);
				}
				container2.addChild(_buttons[0]);
				container2.addChild(_buttons[1]);
				container2.addChild(_buttons[2]);
				}
			}
			else if(event.currentTarget == _buttons[2])
			{
				timelineMenu.resume();
//				container.alpha = 0.5;
//				container2.alpha = 0.5;
				window.alpha = 0.4;
				window.visible = true;
				showMenu();
			}
			else 
			{	
				for(k = 0;k < 30;k++)
				{
					if(event.currentTarget == _pictures[k])
					{
						
						//container.visible = false;
						//container2.visible =  false;
						Paint._first = true;
						TweenLite.to(container2,0.5,{x:"-768"});
						Paint._sprite.visible = true;
						TweenLite.to(Paint._sprite,0.5,{x:"-768"});
						MyPictures._pictures[k*6].smoothing = true;
						MyPictures._pictures[k*6].x = 150;
						MyPictures._pictures[k*6].y = 100;
						MyPictures._pictures[k*6].scaleX = 0.4;
						MyPictures._pictures[k*6].scaleY = 0.4;
						Paint._sprite.addChild(MyPictures._pictures[k*6]);
						var bitmapdata:BitmapData = MyPictures._pictures[k*6].bitmapData.clone();
						Paint.img.bitmapData = bitmapdata;
						Paint.img.visible = false;
						Paint.img.smoothing = true;
						Paint.img.x = 150;
						Paint.img.y = 600;
						Paint.img.scaleX = 0.4;
						Paint.img.scaleY = 0.4;
						Paint.img.alpha = 0.5;
						Paint._sprite.addChild(Paint.img);
						Paint._sheetofPaper.graphics.lineStyle(0,0,0);
						Paint._sheetofPaper.graphics.beginBitmapFill(Source._pictures[k].bitmapData);
						Paint._sheetofPaper.graphics.drawRect(0,0,768,496);
						Paint._sheetofPaper.graphics.endFill();
						
						return;
					}
				}
				for(k = 0;k < 30;k++)
				{
					if(event.currentTarget == _pictures2[k])
					{
						MyPen._sheetofPaper.graphics.lineStyle(0,0,0);
						MyPen._sheetofPaper.graphics.beginBitmapFill(Source._pictures2[k].bitmapData);
						MyPen._sheetofPaper.graphics.drawRect(0,0,768,496);
						MyPen._sheetofPaper.graphics.endFill();
						
						MyPen._sheetofPaper.addChild(Source._pictures[k]);
						TweenLite.to(container,0.5,{x:"-768"});
						TweenLite.to(MyPen._sprite,0.5,{x:"-768"});
						MyPen._sprite.visible = true;
						return;
					}
				}
				//Paint._sprite.graphics.lineStyle(5,0x000000);
				
				
				
			}
		}
		private function onComplete(event:Event):void
		{
			var _Image:Bitmap = Bitmap(_ImLoader.content);
			_Image.smoothing = true;
			Source._pictures2.push(_Image);
			if(++i0 == 30)
			{
				_ImLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
				_ImLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete1);
				var path:String = new String(File.applicationStorageDirectory.resolvePath("Image_0.png").url);
				_ImLoader.load(new URLRequest(path/*"C:/Users/Aleksandr.Kan/AppData/Roaming/paintingstepbystep.debug/Local Store/Image_0.png"*/));
				
			}
			else
			{
				var path1:String = new String(File.applicationStorageDirectory.resolvePath("RGBImage_"+i0+".png").url);
				_ImLoader.load(new URLRequest(path1/*"C:/Users/Aleksandr.Kan/AppData/Roaming/paintingstepbystep.debug/Local Store/RGBImage_"+i0+".png"*/));
			}
		}
		
		private function onComplete1(event:Event):void
		{
			var _Image:Bitmap = Bitmap(_ImLoader.content);
			_Image.smoothing = true;
			Source._pictures.push(_Image);
			var _Image1:Bitmap = new Bitmap(_Image.bitmapData.clone());
			var _Image2:Bitmap = new Bitmap(_Image.bitmapData.clone());
			var _Image3:Bitmap = new Bitmap(Source._pictures2[i].bitmapData.clone());
			var _Image4:Bitmap = new Bitmap(Source._pictures2[i].bitmapData.clone());
			
			var sp1:Sprite = new Sprite();
			var sp2:Sprite = new Sprite();
			var sp3:Sprite = new Sprite();
			var sp4:Sprite = new Sprite();
			var _but:SimpleButton = new SimpleButton();
			var _paper1:Bitmap = new Paper1;
			var _paper2:Bitmap = new Paper2;
			_paper1.smoothing = true;
			_paper2.smoothing = true;
			_Image1.smoothing = true;
			_Image2.smoothing = true;
			_Image3.smoothing = true;
			_Image4.smoothing = true;
			
			
			if(X3 == 600)
			{
				X3 = -125;
				Y3 += 105;
			}
			X3 += 145;
			
			_paper1.x -= 60;
			_paper1.y -= 45;
			_paper1.scaleX = 0.7;
			_paper1.scaleY = 0.7;
			_paper2.x -= 60;
			_paper2.y -= 45;
			_paper2.scaleX = 0.7;
			_paper2.scaleY = 0.7;
			_Image1.x -= 35;
			_Image1.y -= 25;
			_Image1.width = 100;
			_Image1.height = 70;
			_Image2.x -= 35;
			_Image2.y -= 25;
			_Image2.width = 100;
			_Image2.height = 70;
			_Image3.x -= 35;
			_Image3.y -= 25;
			_Image3.width = 100;
			_Image3.height = 70;
			_Image4.x -= 35;
			_Image4.y -= 25;
			_Image4.width = 100;
			_Image4.height = 70;
			
			var _pin:Bitmap = new Bitmap;
			var _bitmapd:BitmapData;
			_bitmapd = _pins[i%8].bitmapData.clone();
			_pin.bitmapData = _bitmapd;
			_pin.smoothing = true;
			_pin.scaleX = 0.7;
			_pin.scaleX = 0.7;
			_pin.y -= 40;
			_pin.x -= 48;
			
			var _pin1:Bitmap = new Bitmap;
			var _bitmapd1:BitmapData;
			_bitmapd1 = _pins[i%8].bitmapData.clone();
			_pin1.bitmapData = _bitmapd1;
			_pin1.smoothing = true;
			_pin1.scaleX = 0.7;
			_pin1.scaleX = 0.7;
			_pin1.y -= 40;
			_pin1.x -= 48;
			
			sp2.addChild(_paper2);
			sp2.addChild(_pin1);
			sp2.addChild(_Image4);
			sp2.addChild(_Image2);
			
			
			sp1.addChild(_paper1);
			sp1.addChild(_pin);
			sp1.addChild(_Image3);
			sp1.addChild(_Image1);
			
			_but.x = X3+63;
			_but.y = Y3+43;
			_but.upState = sp1;
			_but.downState = sp2;
			_but.hitTestState = _paper1;
			_but.overState = sp1;
			
			_but.addEventListener(MouseEvent.CLICK,onClick);
			_pictures2.push(_but);
			
			TweenPlugin.activate([AutoAlphaPlugin]);
			TweenPlugin.activate([VisiblePlugin]);
			paintingstepbystep.timeline2.append(TweenLite.from(_but, 0.4, {scaleX:"3",scaleY:"3",x:380, alpha:0, ease:Bounce.easeOut}),-0.35);
			
			container.addChild(_pictures2[i]);
			if(++i == 30)
			{
				_ImLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete1);
				createButton(380,810,2);
				createButton(150,810,1);
				createButton(650,900,3);
				_ImLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete2);
				_ImLoader.load(new URLRequest("Pictures/1_51.png"));
				
			}
			else
			{
				var path:String = new String(File.applicationStorageDirectory.resolvePath("Image_"+i+".png").url);
				_ImLoader.load(new URLRequest(path/*"C:/Users/Aleksandr.Kan/AppData/Roaming/paintingstepbystep.debug/Local Store/Image_"+i+".png"*/));
			}
			
		}

		
		private function onComplete2(event:Event):void
		{
			var sp1:Sprite = new Sprite();
			var sp2:Sprite = new Sprite();
			var sp3:Sprite = new Sprite();
			var sp4:Sprite = new Sprite();
			var _Image:Bitmap = Bitmap(_ImLoader.content);
			var _Image2:Bitmap = new Bitmap(_Image.bitmapData.clone());
			var _but:SimpleButton = new SimpleButton();
			var _paper1:Bitmap = new Paper1;
			var _paper2:Bitmap = new Paper2;
			_paper1.smoothing = true;
			_paper2.smoothing = true;
			_Image.smoothing = true;
			_Image2.smoothing = true;
			
			
			if(X2 == 600)
			{
				X2 = -125;
				Y2 += 105;
			}
			X2 += 145;
			_paper1.x -= 60;
			_paper1.y -= 45;
			_paper1.scaleX = 0.7;
			_paper1.scaleY = 0.7;
			_paper2.x -= 60;
			_paper2.y -= 45;
			_paper2.scaleX = 0.7;
			_paper2.scaleY = 0.7;
			_Image.x -= _Image.width/2;
			_Image.y -= _Image.height/2;
			//_Image.width = 100;
			//_Image.height = 70;
			_Image.scaleX = 1.25;
			_Image.scaleY = 1.25;
			
			_Image2.x -= _Image2.width/2;
			_Image2.y -= _Image2.height/2;
			//_Image2.width = 100;
			//_Image2.height = 70;
			_Image2.scaleX = 1.25;
			_Image2.scaleY = 1.25;
			
			var _pin:Bitmap = new Bitmap;
			var _bitmapd:BitmapData;
			_bitmapd = _pins[i2%8].bitmapData.clone();
			_pin.bitmapData = _bitmapd;
			_pin.smoothing = true;
			_pin.scaleX = 0.7;
			_pin.scaleX = 0.7;
			_pin.y -= 40;
			_pin.x -= 48;
			
			var _pin1:Bitmap = new Bitmap;
			var _bitmapd1:BitmapData;
			_bitmapd1 = _pins[i2%8].bitmapData.clone();
			_pin1.bitmapData = _bitmapd1;
			_pin1.smoothing = true;
			_pin1.scaleX = 0.7;
			_pin1.scaleX = 0.7;
			_pin1.y -= 40;
			_pin1.x -= 48;
			
			sp2.addChild(_paper2);
			sp2.addChild(_Image2);
			sp2.addChild(_pin1);
			
			sp1.addChild(_paper1);
			sp1.addChild(_Image);
			sp1.addChild(_pin);
			
			_but.x = X2+_Image.width/2;
			_but.y = Y2+_Image.height/2;
			_but.upState = sp1;
			_but.downState = sp2;
			_but.hitTestState = _paper1;
			_but.overState = sp1;
			
			_but.addEventListener(MouseEvent.CLICK,onClick);
			
			_pictures.push(_but);
			TweenPlugin.activate([AutoAlphaPlugin]);
			TweenPlugin.activate([VisiblePlugin]);
			paintingstepbystep.timeline.append(TweenLite.from(_but, 0.4, {scaleX:"3",scaleY:"3",x:380, alpha:0, ease:Bounce.easeOut}),-0.35);
			
			container2.addChild(_pictures[i2-1]);
			
			if(i2++ == 30)
			{
				_ImLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete2);
			}
			else 
			{
				_ImLoader.load(new URLRequest("Pictures/"+i2+"_51.png"));
			}
		}

		private function createButton(X:int, Y:int, type:int):void
		{
			var _but:SimpleButton = new SimpleButton();
			var _Image:Bitmap;
			var _Image2:Bitmap;
			
			if(type == 1)
			{
				_Image = new Dr1();
				_Image2 = new Dr2();
			}
			else if(type == 2)
			{
				_Image = new Paint1;
				_Image2 = new Paint2;
			}
			else 
			{
				_Image = new About1;
				_Image2 = new About2;
			}
			
			//_Image.width = 200;
			//_Image.height = 200;
			//_Image2.width = 200;
			//_Image2.height = 200;
//			_Image.scaleX /= 2;
//			_Image.scaleY /= 2;
//			_Image2.scaleX /= 2;
//			_Image2.scaleY /= 2;
			
			_but.x = X;
			_but.y = Y;
			if(type == 1)_but.upState = _Image2;
			else _but.upState = _Image;
			_but.downState = _Image2;
			_but.hitTestState = _Image;
			_but.overState = _Image;
			if(type == 1)_but.overState = _Image2;
			if(type == 3)_but.downState = _Image2;
			_but.addEventListener(MouseEvent.CLICK,onClick);
			_buttons.push(_but);
			if(type == 1)
			TweenLite.from(_but,1,{x:"-300"});
			else if(type == 2)
			TweenLite.from(_but,1,{x:"300"});
			//container.addChild(_buttons[(i++)-1]);
			container2.addChild(_buttons[(k++)]);
		}
		private function showMenu():void
		{
			//if(back)timelineMenu.reverse();
			timelineMenu.restart();
		}
	}
}