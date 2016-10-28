package
{
	
	import com.greensock.*;
	import com.greensock.TweenAlign;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.IGraphicsData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
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
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.engine.SpaceJustifier;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.utils.ByteArray;
	import flash.xml.*;


	public class About_game
	{
		[Embed(source = "about/about_bg.png")]public static const About:Class;
		[Embed(source = "about/close_1.png")]public static const Cl1:Class;
		[Embed(source = "about/close_2.png")]public static const Cl2:Class;
		[Embed(source = "about/menu/menu11.png")]public static const Menu11:Class;
		[Embed(source = "about/menu/menu12.png")]public static const Menu12:Class;
		[Embed(source = "about/menu/menu21.png")]public static const Menu21:Class;
		[Embed(source = "about/menu/menu22.png")]public static const Menu22:Class;
		[Embed(source = "about/menu/menu31.png")]public static const Menu31:Class;
		[Embed(source = "about/menu/menu32.png")]public static const Menu32:Class;
		[Embed(source = "about/menu/menu41.png")]public static const Menu41:Class;
		[Embed(source = "about/menu/menu42.png")]public static const Menu42:Class;
		[Embed(source = "about/menu/menu51.png")]public static const Menu51:Class;
		[Embed(source = "about/menu/menu52.png")]public static const Menu52:Class;
		[Embed(source = "about/menu/menu61.png")]public static const Menu61:Class;
		[Embed(source = "about/menu/menu62.png")]public static const Menu62:Class;
		
		private var _menuL:SimpleButton = new SimpleButton();
		private var _language:Array = [];
		public static var _sprite:Sprite = new Sprite();
		public static var _spriteL:Sprite = new Sprite();
		private var _bit_bg:Bitmap = new About();
		private var _aboutbuttons:Array = [];
		public static var _about:TextField = new TextField();
		public static var curT:int = 1;
		public static var _format_02:TextFormat = new TextFormat;
		public static var _Active:Boolean = true;
		public static var timeL:TimelineLite = new TimelineLite();
		public static var timeL2:TimelineLite = new TimelineLite();
		private var _text:Array = [["1","1","1","1","1","1"],["2","2","2","2","2","2"],["3","3","3","3","3","3"],["4","4","4","4","4","4"],["5","5","5","5","5","5"]];
		private var _curText:Array = [];
		private var _curText2:Array = [];
		
		public function About_game()
		{
			_sprite.graphics.beginBitmapFill(_bit_bg.bitmapData);
			_sprite.graphics.drawRect(0,0,_bit_bg.width,_bit_bg.height);
			_sprite.graphics.endFill();
			_sprite.x = 20;
			_sprite.y = 1024;
			_sprite.addChild(_spriteL);
			textFields();
			createBut(600,90);
			for(var i:int = 0;i<6;i++){
				createMenu(i+1);
			}
			for(i = 0;i<5;i++){
				createLanguageMenu(i+1);
			}
			_sprite.addEventListener(Event.ENTER_FRAME,onActive);
			onStart();
			
		}
		private function createBut(X:int, Y:int):void
		{
			var sp1:Sprite = new Sprite();
			var sp2:Sprite = new Sprite();
			var sp3:Sprite = new Sprite();
			var sp4:Sprite = new Sprite();
			var _but:SimpleButton = new SimpleButton();
			var but:Bitmap = new Cl1;
			var butact:Bitmap = new Cl2;
						
			but.x = X;
			but.y = Y;
			butact.x = X;
			butact.y = Y;
						
			_but.upState = but;
			_but.downState = but;
			_but.hitTestState = but;
			_but.overState = butact;
						
			_sprite.addChild(_but);
			_but.addEventListener(MouseEvent.CLICK,onClick);
			_aboutbuttons.push(_but);
			//_spriteL.visible = false;
		}
		private function onClick(event:MouseEvent):void
		{
			if(event.currentTarget == _aboutbuttons[0])
			{
				TweenPlugin.activate([VisiblePlugin]);
				TweenPlugin.activate([AutoAlphaPlugin]);
				MainWindow1.timelineMenu.reverse();
				TweenLite.to(MainWindow1.window,1,{visible:false,alpha:0});

			}
			if(event.currentTarget == _aboutbuttons[1])
			{
				_spriteL.visible = true;
				timeL2.restart();
			}
			if(_Active)
			{
				for(var i:int = 0;i<5;i++)
				{
					if(event.currentTarget == _aboutbuttons[i+7] && i != curT)
					{
						if(_Active)
						{
							timeL.clear();
							timeL.append(TweenLite.to(MainWindow1.titles[curT],0.3,{y:"-200"}));
							timeL.append(TweenLite.to(MainWindow1.titles[i],0.3,{y:"200"}));
							timeL.restart();
							_Active = false;
							curT = i;
							for(var j:int = 0;j<6;j++)
							{
								_curText[j].text = _text[i][j];
								_curText2[j].text = _text[i][j];
							}
							break;
						}
					}
				}
			}
		}
		private function onStart():void
		{
			(SimpleButton)(_aboutbuttons[1]).upState = (SimpleButton)(_aboutbuttons[1]).overState;
			(SimpleButton)(_aboutbuttons[8]).upState = (SimpleButton)(_aboutbuttons[8]).overState;
		}
		private function onActive(e:Event):void
		{
			if(!timeL.active)_Active = true;
		}
		private function createMenu(i:int):void
		{
			var text1:TextField = new TextField();
			var text2:TextField = new TextField();
			var format:TextFormat = new TextFormat();
			format.font = "Bookman Old Style";
			format.color = 0x0080ff;
			format.size = 20;
			format.align = "left";
			var menu1:Bitmap = new Menu11;
			var menu2:Bitmap = new Menu12;
			
			if(i == 1){
				menu1 = new Menu11;
				menu2 = new Menu12;
				text1.width = 130;
				text1.height = 50;
				text1.defaultTextFormat = format;
				text1.text = "Языки";
				text2.width = 130;
				text2.height = 50;
				text2.defaultTextFormat = format;
				text2.textColor = 0x666666;
				text2.text = "Языки";
			}
			else if(i == 2){
				menu1 = new Menu21;
				menu2 = new Menu22;
				text1.width = 130;
				text1.height = 50;
				text1.defaultTextFormat = format;
				text1.text = "AppStore";
				text2.width = 130;
				text2.height = 50;
				text2.defaultTextFormat = format;
				text2.textColor = 0x666666;
				text2.text = "AppStore";
			}
			else if(i == 3){
				menu1 = new Menu31;
				menu2 = new Menu32;
				text1.width = 130;
				text1.height = 50;
				text1.defaultTextFormat = format;
				text1.text = "О продукте";
				text2.width = 130;
				text2.height = 50;
				text2.defaultTextFormat = format;
				text2.textColor = 0x666666;
				text2.text = "О продукте";
			}
			else if(i == 4){
				menu1 = new Menu41;
				menu2 = new Menu42;
				text1.width = 130;
				text1.height = 50;
				text1.defaultTextFormat = format;
				text1.text = "Отправить\nдругу";
				text1.y -= 10;
				text2.width = 130;
				text2.height = 50;
				text2.defaultTextFormat = format;
				text2.textColor = 0x666666;
				text2.text = "Отправить\nдругу";
				text2.y -= 10;
			}
			else if(i == 5){
				menu1 = new Menu51;
				menu2 = new Menu52;
				text1.width = 130;
				text1.height = 50;
				text1.defaultTextFormat = format;
				text1.text = "Отправить\nотзыв";
				text1.y -= 10;
				text2.width = 130;
				text2.height = 50;
				text2.defaultTextFormat = format;
				text2.textColor = 0x666666;
				text2.text = "Отправить\nотзыв";
				text2.y -= 10;
			}
			else if(i == 6){
				menu1 = new Menu61;
				menu2 = new Menu62;
				text1.width = 130;
				text1.height = 50;
				text1.defaultTextFormat = format;
				text1.text = "Оценить на\niTunes";
				text1.y -= 10;
				text2.width = 130;
				text2.height = 50;
				text2.defaultTextFormat = format;
				text2.textColor = 0x666666;
				text2.text = "Оценить на\niTunes";
				text2.y -= 10;
			}
			var _but:SimpleButton = new SimpleButton();
			var sp1:Sprite = new Sprite();
			var sp2:Sprite = new Sprite();
			menu1.y -= 10;
			menu1.x -= 45;
			menu2.y -= 10;
			menu2.x -= 45;
			
			sp1.addChild(menu2);
			sp1.addChild(text2);
			sp2.addChild(menu1);
			sp2.addChild(text1);
			_curText.push(text2);
			_curText2.push(text1);
			_but.hitTestState = sp1;
			_but.upState = sp1;
			_but.overState = sp2;
			_but.downState = sp2;
			_but.x = 75;
			_but.y = 215 + ((i-1)*59);
			_sprite.addChild(_but);
			_but.addEventListener(MouseEvent.CLICK,onClick);
			_aboutbuttons.push(_but);
			
		}
		private function createLanguageMenu(i:int):void
		{
			var text1:TextField = new TextField();
			var text2:TextField = new TextField();
			var format:TextFormat = new TextFormat();
			format.font = "Bookman Old Style";
			format.color = 0x0080ff;
			format.size = 23;
			format.align = "left";
			var menu1:Bitmap = new Menu61;
			var menu2:Bitmap = new Menu62;
			
			if(i == 1){
				text1.width = 90;
				text1.height = 40;
				text1.defaultTextFormat = format;
				text1.text = "English";
				text2.width = 90;
				text2.height = 40;
				text2.defaultTextFormat = format;
				text2.textColor = 0x666666;
				text2.text = "English";
			}
			else if(i == 2){
				text1.width = 90;
				text1.height = 40;
				text1.defaultTextFormat = format;
				text1.text = "Русский";
				text2.width = 90;
				text2.height = 40;
				text2.defaultTextFormat = format;
				text2.textColor = 0x666666;
				text2.text = "Русский";
			}
			else if(i == 3){
				text1.width = 90;
				text1.height = 40;
				text1.defaultTextFormat = format;
				text1.text = "Francais";
				text2.width = 90;
				text2.height = 40;
				text2.defaultTextFormat = format;
				text2.textColor = 0x666666;
				text2.text = "Francais";
			}
			else if(i == 4){
				text1.width = 90;
				text1.height = 40;
				text1.defaultTextFormat = format;
				text1.text = "Deutsch";
				text2.width = 90;
				text2.height = 40;
				text2.defaultTextFormat = format;
				text2.textColor = 0x666666;
				text2.text = "Deutsch";
			}
			else if(i == 5){
				text1.width = 90;
				text1.height = 40;
				text1.defaultTextFormat = format;
				text1.text = "Espanol";
				text2.width = 90;
				text2.height = 40;
				text2.defaultTextFormat = format;
				text2.textColor = 0x666666;
				text2.text = "Espanol";
			}
			
			var _but:SimpleButton = new SimpleButton();
			var sp1:Sprite = new Sprite();
			var sp2:Sprite = new Sprite();
			menu1.y -= 10;
			menu1.x -= 45;
			menu2.y -= 10;
			menu2.x -= 45;
			
			sp1.addChild(menu2);
			sp1.addChild(text2);
			sp2.addChild(menu1);
			sp2.addChild(text1);
			_but.hitTestState = sp1;
			_but.upState = sp1;
			_but.overState = sp2;
			_but.downState = sp2;
			_but.x = 400;
			_but.y = 215 + ((i-1)*50);
			_spriteL.addChild(_but);
			_but.addEventListener(MouseEvent.CLICK,onClick);
			_aboutbuttons.push(_but);
			if(i != 1)
			timeL2.append(TweenLite.from(_but,0.2,{y:"-59",alpha:0}),-0.1);
			
		}
		private function textFields():void
		{
			_format_02.size = 35;
			_format_02.font = "Segoe Script";
			_format_02.color = 0xeeeeee;
			_format_02.bold = true;
			_format_02.align = "left";
			
			_about.defaultTextFormat = _format_02;
			
			_about.x = 200;
			_about.y = 110;
			
			_about.text = "ABOUT";
			_about.width = 500;
			_sprite.addChild(_about);
		}	
	}
}