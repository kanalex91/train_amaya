package{
	import flash.display.*;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.dns.ARecord;
	import flash.security.RevocationCheckSettings;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.trace.Trace;
	import flash.ui.ContextMenu;
	import flash.ui.Keyboard;
	import flash.utils.Endian;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import org.osmf.elements.ImageLoader;
	import org.osmf.elements.SWFLoader;
	import org.osmf.events.TimeEvent;
	
	public class TetrisBySSD extends Sprite
	{
		private var _Back:Boolean = false;
		private var _FinalSc:int = 0;
		private var _Index:int = 0;
		private var _GameField:Sprite;
		private var _Bottom:Sprite;
		private var _EndFieldR:Sprite;
		private var _EndFieldL:Sprite;
		private var _Timer:Timer;
		private var _Pause:Boolean=false;
		private var _Blox:Array = new Array();
		private var _F:Number = Math.random();
		private var _CurF:Number = _F;
		private var _DrawF:Boolean = true;
		private var _F1:int = 0;
		private var _F2:int = 0;
		private var _F3:int = 0;
		private var _F4:int = 0;
		private var _F5:int = 0;
		private var _F6:int = 0;
		private var _Arr:Array = new Array();
		private var _Lvl:Array = new Array();
		private var _Top:Sprite;
		private var _Msg:TextField = new TextField();
		public static var _Score:TextField = new TextField();
		private var _Sc:int =0;
		private var _NextF:Array = new Array();
		private var _First:Boolean = true;
		private var _B5:Sprite;
		private var _B6:Sprite;
		private var _B7:Sprite;
		private var _B8:Sprite;
		private var _sp:int = 1;
		private var _Points:int = 0;
		public static var _format_01:TextFormat = new TextFormat;
		_format_01.size = 20;
		_format_01.font = "Segoe Print";
		_format_01.color = 0x00ffff;
		_format_01.align = "center";
		_Score.defaultTextFormat = _format_01;
		
		
		public function TetrisBySSD()
		{	
		stage.focus = this;
		addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
		
		for(var r:int = 0;r<20;r++)
		{
				_Arr[r]= 0;;
		}
		
		_Bottom = new Sprite();
		_Bottom.graphics.beginFill(0xffffff);
		_Bottom.graphics.drawRect(200,960,400,40);
		_Bottom.graphics.endFill();
		addChild(_Bottom);
		
		_EndFieldL = new Sprite();
		_EndFieldL.graphics.beginFill(0xffffff);
		_EndFieldL.graphics.drawRect(0,0,200,1000);
		_EndFieldL.graphics.endFill();
		addChild(_EndFieldL);
		
		_EndFieldR = new Sprite();
		_EndFieldR.graphics.beginFill(0xffffff);
		_EndFieldR.graphics.drawRect(600,0,200,1000);
		_EndFieldR.graphics.endFill();
		addChild(_EndFieldR);
		
		_GameField = new Sprite();
		_GameField.graphics.beginFill(0xdddddd);
		_GameField.graphics.drawRect(200,160,400,800)
		_GameField.graphics.endFill();	
		
		_GameField.graphics.lineStyle(1,0,1);
		_GameField.graphics.lineTo(200,960);
		_GameField.graphics.lineTo(600,960);
		_GameField.graphics.lineTo(600,160);
		_GameField.graphics.lineTo(200,160);
		
		addChild(_GameField);
		
		for(r = 0;r < 20;r++)
		{
			_Lvl[r] = new Sprite();
			(Sprite)(_Lvl[r]).graphics.beginFill(0xdddddd);
			(Sprite)(_Lvl[r]).graphics.drawRect(220,180 + r*40,360,1);
			(Sprite)(_Lvl[r]).graphics.endFill();
			_GameField.addChild((Sprite)(_Lvl[r]));
		}
		
		_Top = new Sprite();
		_Top.graphics.beginFill(0xffffff);
		_Top.graphics.drawRect(200,0,400,160);
		_Top.graphics.endFill();
		addChild(_Top);
		

		_Score.text = "Score: \n"+ 0;
		_Score.border = true;
		_Score.x = 50;
		_Score.y = 200;
		addChild(_Score);
		
		_Timer = new Timer(500,0);
		_Timer.addEventListener(TimerEvent.TIMER, onTimer);
		_Timer.start();
		
		stage.focus = this;
		addEventListener(KeyboardEvent.KEY_DOWN, pause)
		
		}
	
		private function onTimer(e:TimerEvent):void
		{	
			stage.focus =this;
			if(_DrawF)
			{
				_F1 = 0;
				_F2 = 0;
				_F3 = 0;
				_F4 = 0;
				_F5 = 0;
				_F6 = 0;
				_DrawF = false;
				_CurF = _F;
				
				var _B1:Sprite = new Sprite();
				var _B2:Sprite = new Sprite();
				var _B3:Sprite = new Sprite();
				var _B4:Sprite = new Sprite();
				/*_Blox[_Index++] = new Sprite();
				_Blox[_Index++] = new Sprite();
				_Blox[_Index++] = new Sprite();
				_Blox[_Index++] = new Sprite();*/
				
				if(_F < 0.2){
					_B1.graphics.beginFill(0x999999);
					_B1.graphics.drawRect(402,2,36,36);
					_B1.graphics.endFill();
					_GameField.addChild(_B1);
					
					_B2.graphics.beginFill(0x999999);
					_B2.graphics.drawRect(402,42,36,36);
					_B2.graphics.endFill();
					_GameField.addChild(_B2);
					
					_B3.graphics.beginFill(0x999999);
					_B3.graphics.drawRect(402,82,36,36);
					_B3.graphics.endFill();
					_GameField.addChild(_B3);
					
					_B4.graphics.beginFill(0x999999);
					_B4.graphics.drawRect(402,122,36,36);
					_B4.graphics.endFill();
					_GameField.addChild(_B4);
				}
				else if(_F < 0.4){
					_B1.graphics.beginFill(0x999999);
					_B1.graphics.drawRect(362,82,36,36);
					_B1.graphics.endFill();
					_GameField.addChild(_B1);
					
					_B2.graphics.beginFill(0x999999);
					_B2.graphics.drawRect(402,82,36,36);
					_B2.graphics.endFill();
					_GameField.addChild(_B2);
					
					_B3.graphics.beginFill(0x999999);
					_B3.graphics.drawRect(362,122,36,36);
					_B3.graphics.endFill();
					_GameField.addChild(_B3);
					
					_B4.graphics.beginFill(0x999999);
					_B4.graphics.drawRect(402,122,36,36);
					_B4.graphics.endFill();
					_GameField.addChild(_B4);
				}
				else if(_F < 0.6){
					_B1.graphics.beginFill(0x999999);
					_B1.graphics.drawRect(362,42,36,36);
					_B1.graphics.endFill();
					_GameField.addChild(_B1);
					
					_B2.graphics.beginFill(0x999999);
					_B2.graphics.drawRect(362,82,36,36);
					_B2.graphics.endFill();
					_GameField.addChild(_B2);
					
					_B3.graphics.beginFill(0x999999);
					_B3.graphics.drawRect(362,122,36,36);
					_B3.graphics.endFill();
					_GameField.addChild(_B3);
					
					_B4.graphics.beginFill(0x999999);
					_B4.graphics.drawRect(402,82,36,36);
					_B4.graphics.endFill();
					_GameField.addChild(_B4);	
				}
				else if(_F < 0.7){
					_B1.graphics.beginFill(0x999999);
					_B1.graphics.drawRect(362,42,36,36);
					_B1.graphics.endFill();
					_GameField.addChild(_B1);
					
					_B2.graphics.beginFill(0x999999);
					_B2.graphics.drawRect(402,42,36,36);
					_B2.graphics.endFill();
					_GameField.addChild(_B2);
					
					_B3.graphics.beginFill(0x999999);
					_B3.graphics.drawRect(402,82,36,36);
					_B3.graphics.endFill();
					_GameField.addChild(_B3);
					
					_B4.graphics.beginFill(0x999999);
					_B4.graphics.drawRect(402,122,36,36);
					_B4.graphics.endFill();
					_GameField.addChild(_B4);
				}
				else if(_F < 0.8){
					_B1.graphics.beginFill(0x999999);
					_B1.graphics.drawRect(402,42,36,36);
					_B1.graphics.endFill();
					_GameField.addChild(_B1);
					
					_B2.graphics.beginFill(0x999999);
					_B2.graphics.drawRect(362,42,36,36);
					_B2.graphics.endFill();
					_GameField.addChild(_B2);
					
					_B3.graphics.beginFill(0x999999);
					_B3.graphics.drawRect(362,82,36,36);
					_B3.graphics.endFill();
					_GameField.addChild(_B3);
					
					_B4.graphics.beginFill(0x999999);
					_B4.graphics.drawRect(362,122,36,36);
					_B4.graphics.endFill();
					_GameField.addChild(_B4);
				}
				else if(_F < 0.9){
					_B1.graphics.beginFill(0x999999);
					_B1.graphics.drawRect(362,82,36,36);
					_B1.graphics.endFill();
					_GameField.addChild(_B1);
					
					_B2.graphics.beginFill(0x999999);
					_B2.graphics.drawRect(362,122,36,36);
					_B2.graphics.endFill();
					_GameField.addChild(_B2);
					
					_B3.graphics.beginFill(0x999999);
					_B3.graphics.drawRect(402,42,36,36);
					_B3.graphics.endFill();
					_GameField.addChild(_B3);
					
					_B4.graphics.beginFill(0x999999);
					_B4.graphics.drawRect(402,82,36,36);
					_B4.graphics.endFill();
					_GameField.addChild(_B4);
				}
				else{
					_B1.graphics.beginFill(0x999999);
					_B1.graphics.drawRect(402,82,36,36);
					_B1.graphics.endFill();
					_GameField.addChild(_B1);
					
					_B2.graphics.beginFill(0x999999);
					_B2.graphics.drawRect(402,122,36,36);
					_B2.graphics.endFill();
					_GameField.addChild(_B2);
					
					_B3.graphics.beginFill(0x999999);
					_B3.graphics.drawRect(362,42,36,36);
					_B3.graphics.endFill();
					_GameField.addChild(_B3);
					
					_B4.graphics.beginFill(0x999999);
					_B4.graphics.drawRect(362,82,36,36);
					_B4.graphics.endFill();
					_GameField.addChild(_B4);
				}
				_Blox.push(_B1);
				_Blox.push(_B2);
				_Blox.push(_B3);
				_Blox.push(_B4);
				
				_Index+=4;
				addEventListener(KeyboardEvent.KEY_DOWN,onKeyPress);
				_F = Math.random();
				
				if(_First)_First = false;
				else
				{
					_B5.visible = false;
					_B6.visible = false;
					_B7.visible = false;
					_B8.visible = false;
				}
				_B5 = new Sprite();
				_B6 = new Sprite();
				_B7 = new Sprite();
				_B8 = new Sprite();
				
				if(_F < 0.2){
					_B5.graphics.beginFill(0x999999);
					_B5.graphics.drawRect(102,2,36,36);
					_B5.graphics.endFill();
					_GameField.addChild(_B5);
					
					_B6.graphics.beginFill(0x999999);
					_B6.graphics.drawRect(102,42,36,36);
					_B6.graphics.endFill();
					_GameField.addChild(_B6);
					
					_B7.graphics.beginFill(0x999999);
					_B7.graphics.drawRect(102,82,36,36);
					_B7.graphics.endFill();
					_GameField.addChild(_B7);
					
					_B8.graphics.beginFill(0x999999);
					_B8.graphics.drawRect(102,122,36,36);
					_B8.graphics.endFill();
					_GameField.addChild(_B8);
				}
				else if(_F < 0.4){
					_B5.graphics.beginFill(0x999999);
					_B5.graphics.drawRect(62,82,36,36);
					_B5.graphics.endFill();
					_GameField.addChild(_B5);
					
					_B6.graphics.beginFill(0x999999);
					_B6.graphics.drawRect(102,82,36,36);
					_B6.graphics.endFill();
					_GameField.addChild(_B6);
					
					_B7.graphics.beginFill(0x999999);
					_B7.graphics.drawRect(62,122,36,36);
					_B7.graphics.endFill();
					_GameField.addChild(_B7);
					
					_B8.graphics.beginFill(0x999999);
					_B8.graphics.drawRect(102,122,36,36);
					_B8.graphics.endFill();
					_GameField.addChild(_B8);
				}
				else if(_F < 0.6){
					_B5.graphics.beginFill(0x999999);
					_B5.graphics.drawRect(62,42,36,36);
					_B5.graphics.endFill();
					_GameField.addChild(_B5);
					
					_B6.graphics.beginFill(0x999999);
					_B6.graphics.drawRect(62,82,36,36);
					_B6.graphics.endFill();
					_GameField.addChild(_B6);
					
					_B7.graphics.beginFill(0x999999);
					_B7.graphics.drawRect(62,122,36,36);
					_B7.graphics.endFill();
					_GameField.addChild(_B7);
					
					_B8.graphics.beginFill(0x999999);
					_B8.graphics.drawRect(102,82,36,36);
					_B8.graphics.endFill();
					_GameField.addChild(_B8);	
				}
				else if(_F < 0.7){
					_B5.graphics.beginFill(0x999999);
					_B5.graphics.drawRect(62,42,36,36);
					_B5.graphics.endFill();
					_GameField.addChild(_B5);
					
					_B6.graphics.beginFill(0x999999);
					_B6.graphics.drawRect(102,42,36,36);
					_B6.graphics.endFill();
					_GameField.addChild(_B6);
					
					_B7.graphics.beginFill(0x999999);
					_B7.graphics.drawRect(102,82,36,36);
					_B7.graphics.endFill();
					_GameField.addChild(_B7);
					
					_B8.graphics.beginFill(0x999999);
					_B8.graphics.drawRect(102,122,36,36);
					_B8.graphics.endFill();
					_GameField.addChild(_B8);
				}
				else if(_F < 0.8){
					_B5.graphics.beginFill(0x999999);
					_B5.graphics.drawRect(102,42,36,36);
					_B5.graphics.endFill();
					_GameField.addChild(_B5);
					
					_B6.graphics.beginFill(0x999999);
					_B6.graphics.drawRect(62,42,36,36);
					_B6.graphics.endFill();
					_GameField.addChild(_B6);
					
					_B7.graphics.beginFill(0x999999);
					_B7.graphics.drawRect(62,82,36,36);
					_B7.graphics.endFill();
					_GameField.addChild(_B7);
					
					_B8.graphics.beginFill(0x999999);
					_B8.graphics.drawRect(62,122,36,36);
					_B8.graphics.endFill();
					_GameField.addChild(_B8);
				}
				else if(_F < 0.9){
					_B5.graphics.beginFill(0x999999);
					_B5.graphics.drawRect(62,82,36,36);
					_B5.graphics.endFill();
					_GameField.addChild(_B5);
					
					_B6.graphics.beginFill(0x999999);
					_B6.graphics.drawRect(62,122,36,36);
					_B6.graphics.endFill();
					_GameField.addChild(_B6);
					
					_B7.graphics.beginFill(0x999999);
					_B7.graphics.drawRect(102,42,36,36);
					_B7.graphics.endFill();
					_GameField.addChild(_B7);
					
					_B8.graphics.beginFill(0x999999);
					_B8.graphics.drawRect(102,82,36,36);
					_B8.graphics.endFill();
					_GameField.addChild(_B8);
				}
				else{
					_B5.graphics.beginFill(0x999999);
					_B5.graphics.drawRect(102,82,36,36);
					_B5.graphics.endFill();
					_GameField.addChild(_B5);
					
					_B6.graphics.beginFill(0x999999);
					_B6.graphics.drawRect(102,122,36,36);
					_B6.graphics.endFill();
					_GameField.addChild(_B6);
					
					_B7.graphics.beginFill(0x999999);
					_B7.graphics.drawRect(62,42,36,36);
					_B7.graphics.endFill();
					_GameField.addChild(_B7);
					
					_B8.graphics.beginFill(0x999999);
					_B8.graphics.drawRect(62,82,36,36);
					_B8.graphics.endFill();
					_GameField.addChild(_B8);
				}
				
			}
			else 
			{
				(Sprite)(_Blox[_Index-4]).y += 40;
				(Sprite)(_Blox[_Index-3]).y += 40;
				(Sprite)(_Blox[_Index-2]).y += 40;
				(Sprite)(_Blox[_Index-1]).y += 40;
				
				for(var i:int = 0;i<4;i++)
				{
					if((Sprite)(_Blox[_Index-1-i]).hitTestObject(_Bottom))
					{
					 	_DrawF = true;
						(Sprite)(_Blox[_Index-4]).y -= 40;
						(Sprite)(_Blox[_Index-3]).y -= 40;
						(Sprite)(_Blox[_Index-2]).y -= 40;
						(Sprite)(_Blox[_Index-1]).y -= 40;
						break;
					}
				}
				
				for(var j:int =0;j<4;j++)
				{
					if(_Index != 4){
						for(var k:int =0;k < _Index - 4;k++)
						{
							if((Sprite)(_Blox[_Index-1-j]).hitTestObject((Sprite)(_Blox[k])))
							{
								_DrawF = true;
								(Sprite)(_Blox[_Index-4]).y -= 40;
								(Sprite)(_Blox[_Index-3]).y -= 40;
								(Sprite)(_Blox[_Index-2]).y -= 40;
								(Sprite)(_Blox[_Index-1]).y -= 40;
								j=4;
								break;
							}	
						}
					}
				}
				if(_DrawF)
				{
					for(i = 0;i<4;i++)
					{
						if((Sprite)(_Blox[_Index-1-i]).hitTestObject(_Top))
						{
							_Timer.stop();
							_Msg.textColor = 0x000000;
							
							
							_Msg.text = "You lose "
							_Msg.x = 300;
							_Msg.y = 500;
							_GameField.addChild(_Msg);
						}
					}
					for(i = 0;i<4;i++)
					{
						for(j = 0;j<20;j++)
						{
							if((Sprite)(_Blox[_Index - 1 - i]).hitTestObject((Sprite)(_Lvl[j])))
							{
								_Arr[j]++;
								(Sprite)(_Lvl[j]).addChild(_Blox[_Index - 1 - i]); 
							}
						}
					}
					
					for(j=0;j<20;j++)
					{
						if(_Arr[j] == 10)
						{
							_Sc++;
							_Points++;
							for(k=0;k<_Blox.length;k++)
							{
								if((Sprite)(_Lvl[j]).contains((Sprite)(_Blox[k])))
								{
									(Sprite)(_Blox[k]).visible = false;
									_Blox.splice(k,1);
									k--;
								}
							}
							for(k=j;k>0;k--)
							{
								_Arr[k] = _Arr[k-1];
								for(i = 0;i<_Blox.length;i++)
								{
									if((Sprite)(_Lvl[k-1]).contains((Sprite)(_Blox[i])))
									{
										(Sprite)(_Blox[i]).y += 40;
										(Sprite)(_Lvl[k-1]).removeChild((Sprite)(_Blox[i]));
										(Sprite)(_Lvl[k]).addChild((Sprite)(_Blox[i]));
									}	
								}
							}
							_Index = _Blox.length;
						}
					}
					_FinalSc +=(_Points * _sp)
					_Score.text = "Score: \n"+ _FinalSc;
					_Score.border = true;
					_Score.x = 50;
					_Score.y = 200;
					addChild(_Score);
					_Points = 0;
					if(_Sc % 10 == 0)
					{
						_sp*=10;
						_Timer.delay = 500/(1+Math.floor(_Sc/10));
					}
					removeEventListener(KeyboardEvent.KEY_DOWN,onKeyPress);
				}
			}
			
		}
	
		private function pause(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.ENTER)
			{
				if(!_Pause){_Timer.stop();_Pause = true;}
				else {_Timer.start();_Pause = false;}
			}
		}
		
		private function onKeyPress(e:KeyboardEvent):void
		{
			removeEventListener(KeyboardEvent.KEY_DOWN,onKeyPress);
			if(e.keyCode == Keyboard.LEFT)
			{
				removeEventListener(KeyboardEvent.KEY_DOWN,onKeyPress);
				(Sprite)(_Blox[_Index-4]).x -= 40;
				(Sprite)(_Blox[_Index-3]).x -= 40;
				(Sprite)(_Blox[_Index-2]).x -= 40;
				(Sprite)(_Blox[_Index-1]).x -= 40;
				
				for(var i:int = 0;i<4;i++)
				{
					if((Sprite)(_Blox[_Index-1-i]).hitTestObject(_EndFieldL))
					{
						(Sprite)(_Blox[_Index-4]).x += 40;
						(Sprite)(_Blox[_Index-3]).x += 40;
						(Sprite)(_Blox[_Index-2]).x += 40;
						(Sprite)(_Blox[_Index-1]).x += 40;
						break;
					}
				}
				
				for(var j:int =0;j<4;j++)
				{
					if(_Index != 4){
						for(var k:int =0;k < _Index - 4;k++)
						{
							if((Sprite)(_Blox[_Index-1-j]).hitTestObject((Sprite)(_Blox[k])))
							{
								(Sprite)(_Blox[_Index-4]).x += 40;
								(Sprite)(_Blox[_Index-3]).x += 40;
								(Sprite)(_Blox[_Index-2]).x += 40;
								(Sprite)(_Blox[_Index-1]).x += 40;
								j=4;
								break;
							}	
						}
					}
				}
				addEventListener(KeyboardEvent.KEY_DOWN,onKeyPress);
			}
			if(e.keyCode == Keyboard.RIGHT)
			{
				removeEventListener(KeyboardEvent.KEY_DOWN,onKeyPress);
				(Sprite)(_Blox[_Index-4]).x += 40;
				(Sprite)(_Blox[_Index-3]).x += 40;
				(Sprite)(_Blox[_Index-2]).x += 40;
				(Sprite)(_Blox[_Index-1]).x += 40;
				
				for(i = 0;i<4;i++)
				{
					if((Sprite)(_Blox[_Index-1-i]).hitTestObject(_EndFieldR))
					{
						(Sprite)(_Blox[_Index-4]).x -= 40;
						(Sprite)(_Blox[_Index-3]).x -= 40;
						(Sprite)(_Blox[_Index-2]).x -= 40;
						(Sprite)(_Blox[_Index-1]).x -= 40;
						break;
					}
				}
				
				for(j = 0;j<4;j++)
				{
					if(_Index != 4){
						for(k = 0;k < _Index - 4;k++)
						{
							if((Sprite)(_Blox[_Index-1-j]).hitTestObject((Sprite)(_Blox[k])))
							{
								(Sprite)(_Blox[_Index-4]).x -= 40;
								(Sprite)(_Blox[_Index-3]).x -= 40;
								(Sprite)(_Blox[_Index-2]).x -= 40;
								(Sprite)(_Blox[_Index-1]).x -= 40;
								j=4;
								break;
							}	
						}
					}
				}
				addEventListener(KeyboardEvent.KEY_DOWN,onKeyPress);
			}
			
			if(e.keyCode == Keyboard.UP)
			{
				if(_CurF < 0.2)
				{
					removeEventListener(KeyboardEvent.KEY_DOWN,onKeyPress);
					if(_F1 == 0)
					{
						(Sprite)(_Blox[_Index-4]).x -= 80;
						(Sprite)(_Blox[_Index-4]).y += 80;
						(Sprite)(_Blox[_Index-3]).x -= 40;
						(Sprite)(_Blox[_Index-3]).y += 40;
						(Sprite)(_Blox[_Index-1]).x += 40;
						(Sprite)(_Blox[_Index-1]).y -= 40;
						_F1 = 1;
					}
					else 
					{
						(Sprite)(_Blox[_Index-4]).x += 80;
						(Sprite)(_Blox[_Index-4]).y -= 80;
						(Sprite)(_Blox[_Index-3]).x += 40;
						(Sprite)(_Blox[_Index-3]).y -= 40;
						(Sprite)(_Blox[_Index-1]).x -= 40;
						(Sprite)(_Blox[_Index-1]).y += 40;
						_F1 = 0;						
					}
				}
				else if(_CurF >= 0.4 && _CurF < 0.6)
				{
					if(_F2 == 0)
					{
						(Sprite)(_Blox[_Index-4]).x += 80;
						(Sprite)(_Blox[_Index-4]).y += 0;
						(Sprite)(_Blox[_Index-3]).x += 40;
						(Sprite)(_Blox[_Index-3]).y -= 40;
						(Sprite)(_Blox[_Index-2]).x += 0;
						(Sprite)(_Blox[_Index-2]).y -= 80;
						_F2 = 1;
					}
					else if(_F2 == 1)
					{
						(Sprite)(_Blox[_Index-4]).x += 0;
						(Sprite)(_Blox[_Index-4]).y += 80;
						(Sprite)(_Blox[_Index-3]).x += 40;
						(Sprite)(_Blox[_Index-3]).y += 40;
						(Sprite)(_Blox[_Index-2]).x += 80;
						(Sprite)(_Blox[_Index-2]).y += 0;
						_F2 = 2;
					}
					else if(_F2 == 2)
					{
						
						(Sprite)(_Blox[_Index-4]).x -= 80;
						(Sprite)(_Blox[_Index-4]).y += 0;
						(Sprite)(_Blox[_Index-3]).x -= 40;
						(Sprite)(_Blox[_Index-3]).y += 40;
						(Sprite)(_Blox[_Index-2]).x += 0;
						(Sprite)(_Blox[_Index-2]).y += 80;
						_F2 = 3;
					}
					else
					{
						(Sprite)(_Blox[_Index-4]).x += 0;
						(Sprite)(_Blox[_Index-4]).y -= 80;
						(Sprite)(_Blox[_Index-3]).x -= 40;
						(Sprite)(_Blox[_Index-3]).y -= 40;
						(Sprite)(_Blox[_Index-2]).x -= 80;
						(Sprite)(_Blox[_Index-2]).y += 0;
						_F2 = 0;
					}
				}
				else if(_CurF >= 0.6 && _CurF < 0.7)
				{
					if(_F3 == 0)
					{
						(Sprite)(_Blox[_Index-4]).x += 80;
						(Sprite)(_Blox[_Index-4]).y += 0;
						(Sprite)(_Blox[_Index-3]).x += 40;
						(Sprite)(_Blox[_Index-3]).y += 40;
						(Sprite)(_Blox[_Index-1]).x -= 40;
						(Sprite)(_Blox[_Index-1]).y -= 40;
						_F3 = 1;
					}
					else if(_F3 == 1)
					{
						(Sprite)(_Blox[_Index-4]).x += 0;
						(Sprite)(_Blox[_Index-4]).y += 80;
						(Sprite)(_Blox[_Index-3]).x -= 40;
						(Sprite)(_Blox[_Index-3]).y += 40;
						(Sprite)(_Blox[_Index-1]).x += 40;
						(Sprite)(_Blox[_Index-1]).y -= 40;
						_F3 = 2;
					}
					else if(_F3 == 2)
					{
						
						(Sprite)(_Blox[_Index-4]).x -= 80;
						(Sprite)(_Blox[_Index-4]).y += 0;
						(Sprite)(_Blox[_Index-3]).x -= 40;
						(Sprite)(_Blox[_Index-3]).y -= 40;
						(Sprite)(_Blox[_Index-1]).x += 40;
						(Sprite)(_Blox[_Index-1]).y += 40;
						_F3 = 3;
					}
					else
					{
						(Sprite)(_Blox[_Index-4]).x += 0;
						(Sprite)(_Blox[_Index-4]).y -= 80;
						(Sprite)(_Blox[_Index-3]).x += 40;
						(Sprite)(_Blox[_Index-3]).y -= 40;
						(Sprite)(_Blox[_Index-1]).x -= 40;
						(Sprite)(_Blox[_Index-1]).y += 40;
						_F3 = 0;
					}
				}
				else if(_CurF >= 0.7 && _CurF < 0.8)
				{
					if(_F4 == 0)
					{
						(Sprite)(_Blox[_Index-4]).x += 0;
						(Sprite)(_Blox[_Index-4]).y += 80;
						(Sprite)(_Blox[_Index-3]).x += 40;
						(Sprite)(_Blox[_Index-3]).y += 40;
						(Sprite)(_Blox[_Index-1]).x -= 40;
						(Sprite)(_Blox[_Index-1]).y -= 40;
						_F4 = 1;
					}
					else if(_F4 == 1)
					{
						(Sprite)(_Blox[_Index-4]).x -= 80;
						(Sprite)(_Blox[_Index-4]).y += 0;
						(Sprite)(_Blox[_Index-3]).x -= 40;
						(Sprite)(_Blox[_Index-3]).y += 40;
						(Sprite)(_Blox[_Index-1]).x += 40;
						(Sprite)(_Blox[_Index-1]).y -= 40;
						_F4 = 2;
					}
					else if(_F4 == 2)
					{
						
						(Sprite)(_Blox[_Index-4]).x += 0;
						(Sprite)(_Blox[_Index-4]).y -= 80;
						(Sprite)(_Blox[_Index-3]).x -= 40;
						(Sprite)(_Blox[_Index-3]).y -= 40;
						(Sprite)(_Blox[_Index-1]).x += 40;
						(Sprite)(_Blox[_Index-1]).y += 40;
						_F4 = 3;
					}
					else
					{
						(Sprite)(_Blox[_Index-4]).x += 80;
						(Sprite)(_Blox[_Index-4]).y += 0;
						(Sprite)(_Blox[_Index-3]).x += 40;
						(Sprite)(_Blox[_Index-3]).y -= 40;
						(Sprite)(_Blox[_Index-1]).x -= 40;
						(Sprite)(_Blox[_Index-1]).y += 40;
						_F4 = 0;
					}
				}
				else if(_CurF >= 0.8 && _CurF < 0.9)
				{
					if(_F5 == 0)
					{
						(Sprite)(_Blox[_Index-3]).x -= 40;
						(Sprite)(_Blox[_Index-3]).y -= 40;
						(Sprite)(_Blox[_Index-2]).x += 0;
						(Sprite)(_Blox[_Index-2]).y += 80;
						(Sprite)(_Blox[_Index-1]).x -= 40;
						(Sprite)(_Blox[_Index-1]).y += 40;
						_F5 = 1;
					}
					else
					{
						(Sprite)(_Blox[_Index-3]).x += 40;
						(Sprite)(_Blox[_Index-3]).y += 40;
						(Sprite)(_Blox[_Index-2]).x += 0;
						(Sprite)(_Blox[_Index-2]).y -= 80;
						(Sprite)(_Blox[_Index-1]).x += 40;
						(Sprite)(_Blox[_Index-1]).y -= 40;
						_F5 = 0;
					}
				}
				else if(_CurF >= 0.9 && _CurF < 1)
				{
					if(_F6 == 0)
					{
						(Sprite)(_Blox[_Index-4]).x -= 40;
						(Sprite)(_Blox[_Index-4]).y += 40;
						(Sprite)(_Blox[_Index-3]).x -= 80;
						(Sprite)(_Blox[_Index-3]).y += 0;
						(Sprite)(_Blox[_Index-2]).x += 40;
						(Sprite)(_Blox[_Index-2]).y += 40;
						_F6 = 1;
					}
					else
					{
						(Sprite)(_Blox[_Index-4]).x += 40;
						(Sprite)(_Blox[_Index-4]).y -= 40;
						(Sprite)(_Blox[_Index-3]).x += 80;
						(Sprite)(_Blox[_Index-3]).y += 0;
						(Sprite)(_Blox[_Index-2]).x -= 40;
						(Sprite)(_Blox[_Index-2]).y -= 40;
						_F6 = 0;
					}
				}
				
				for(i = 0;i<4;i++)
				{
					if((Sprite)(_Blox[_Index-1-i]).hitTestObject(_Bottom))
					{
						_Back = true;
						break;
					}
				}
				for(i = 0;i<4;i++)
				{
					if((Sprite)(_Blox[_Index-1-i]).hitTestObject(_EndFieldR))
					{
						_Back = true;
						break;
					}
				}
				for(i = 0;i<4;i++)
				{
					if((Sprite)(_Blox[_Index-1-i]).hitTestObject(_EndFieldL))
					{
						_Back = true;
						break;
					}
				}
				
				for(j = 0;j<4;j++)
				{
					if(_Index != 4){
						for(k = 0;k < _Index - 4;k++)
						{
							if((Sprite)(_Blox[_Index-1-j]).hitTestObject((Sprite)(_Blox[k])))
							{
								_Back =true;
								j=4;
								break;
							}	
						}
					}
				}
				
				if(_Back)
				{
					_Back = false;
					if(_CurF < 0.2)
					{
						if(_F1 == 0)
						{
							(Sprite)(_Blox[_Index-4]).x -= 80;
							(Sprite)(_Blox[_Index-4]).y += 80;
							(Sprite)(_Blox[_Index-3]).x -= 40;
							(Sprite)(_Blox[_Index-3]).y += 40;
							(Sprite)(_Blox[_Index-1]).x += 40;
							(Sprite)(_Blox[_Index-1]).y -= 40;
							_F1 = 1;
						}
						else 
						{
							(Sprite)(_Blox[_Index-4]).x += 80;
							(Sprite)(_Blox[_Index-4]).y -= 80;
							(Sprite)(_Blox[_Index-3]).x += 40;
							(Sprite)(_Blox[_Index-3]).y -= 40;
							(Sprite)(_Blox[_Index-1]).x -= 40;
							(Sprite)(_Blox[_Index-1]).y += 40;
							_F1 = 0;						
						}
					}
					else if(_CurF >= 0.4 && _CurF < 0.6)
					{
						if(_F2 == 3)
						{
							(Sprite)(_Blox[_Index-4]).x += 80;
							(Sprite)(_Blox[_Index-4]).y += 0;
							(Sprite)(_Blox[_Index-3]).x += 40;
							(Sprite)(_Blox[_Index-3]).y -= 40;
							(Sprite)(_Blox[_Index-2]).x += 0;
							(Sprite)(_Blox[_Index-2]).y -= 80;
							_F2 = 2;
						}
						else if(_F2 == 0)
						{
							(Sprite)(_Blox[_Index-4]).x += 0;
							(Sprite)(_Blox[_Index-4]).y += 80;
							(Sprite)(_Blox[_Index-3]).x += 40;
							(Sprite)(_Blox[_Index-3]).y += 40;
							(Sprite)(_Blox[_Index-2]).x += 80;
							(Sprite)(_Blox[_Index-2]).y += 0;
							_F2 = 3;
						}
						else if(_F2 == 1)
						{
							
							(Sprite)(_Blox[_Index-4]).x -= 80;
							(Sprite)(_Blox[_Index-4]).y += 0;
							(Sprite)(_Blox[_Index-3]).x -= 40;
							(Sprite)(_Blox[_Index-3]).y += 40;
							(Sprite)(_Blox[_Index-2]).x += 0;
							(Sprite)(_Blox[_Index-2]).y += 80;
							_F2 = 0;
						}
						else
						{
							(Sprite)(_Blox[_Index-4]).x += 0;
							(Sprite)(_Blox[_Index-4]).y -= 80;
							(Sprite)(_Blox[_Index-3]).x -= 40;
							(Sprite)(_Blox[_Index-3]).y -= 40;
							(Sprite)(_Blox[_Index-2]).x -= 80;
							(Sprite)(_Blox[_Index-2]).y += 0;
							_F2 = 1;
						}
					}
					else if(_CurF >= 0.6 && _CurF < 0.7)
					{
						if(_F3 == 3)
						{
							(Sprite)(_Blox[_Index-4]).x += 80;
							(Sprite)(_Blox[_Index-4]).y += 0;
							(Sprite)(_Blox[_Index-3]).x += 40;
							(Sprite)(_Blox[_Index-3]).y += 40;
							(Sprite)(_Blox[_Index-1]).x -= 40;
							(Sprite)(_Blox[_Index-1]).y -= 40;
							_F3 = 2;
						}
						else if(_F3 == 0)
						{
							(Sprite)(_Blox[_Index-4]).x += 0;
							(Sprite)(_Blox[_Index-4]).y += 80;
							(Sprite)(_Blox[_Index-3]).x -= 40;
							(Sprite)(_Blox[_Index-3]).y += 40;
							(Sprite)(_Blox[_Index-1]).x += 40;
							(Sprite)(_Blox[_Index-1]).y -= 40;
							_F3 = 3;
						}
						else if(_F3 == 1)
						{
							
							(Sprite)(_Blox[_Index-4]).x -= 80;
							(Sprite)(_Blox[_Index-4]).y += 0;
							(Sprite)(_Blox[_Index-3]).x -= 40;
							(Sprite)(_Blox[_Index-3]).y -= 40;
							(Sprite)(_Blox[_Index-1]).x += 40;
							(Sprite)(_Blox[_Index-1]).y += 40;
							_F3 = 0;
						}
						else
						{
							(Sprite)(_Blox[_Index-4]).x += 0;
							(Sprite)(_Blox[_Index-4]).y -= 80;
							(Sprite)(_Blox[_Index-3]).x += 40;
							(Sprite)(_Blox[_Index-3]).y -= 40;
							(Sprite)(_Blox[_Index-1]).x -= 40;
							(Sprite)(_Blox[_Index-1]).y += 40;
							_F3 = 1;
						}
					}
					else if(_CurF >= 0.7 && _CurF < 0.8)
					{
						if(_F4 == 3)
						{
							(Sprite)(_Blox[_Index-4]).x += 0;
							(Sprite)(_Blox[_Index-4]).y += 80;
							(Sprite)(_Blox[_Index-3]).x += 40;
							(Sprite)(_Blox[_Index-3]).y += 40;
							(Sprite)(_Blox[_Index-1]).x -= 40;
							(Sprite)(_Blox[_Index-1]).y -= 40;
							_F4 = 2;
						}
						else if(_F4 == 0)
						{
							(Sprite)(_Blox[_Index-4]).x -= 80;
							(Sprite)(_Blox[_Index-4]).y += 0;
							(Sprite)(_Blox[_Index-3]).x -= 40;
							(Sprite)(_Blox[_Index-3]).y += 40;
							(Sprite)(_Blox[_Index-1]).x += 40;
							(Sprite)(_Blox[_Index-1]).y -= 40;
							_F4 = 3;
						}
						else if(_F4 == 1)
						{
							
							(Sprite)(_Blox[_Index-4]).x += 0;
							(Sprite)(_Blox[_Index-4]).y -= 80;
							(Sprite)(_Blox[_Index-3]).x -= 40;
							(Sprite)(_Blox[_Index-3]).y -= 40;
							(Sprite)(_Blox[_Index-1]).x += 40;
							(Sprite)(_Blox[_Index-1]).y += 40;
							_F4 = 0;
						}
						else
						{
							(Sprite)(_Blox[_Index-4]).x += 80;
							(Sprite)(_Blox[_Index-4]).y += 0;
							(Sprite)(_Blox[_Index-3]).x += 40;
							(Sprite)(_Blox[_Index-3]).y -= 40;
							(Sprite)(_Blox[_Index-1]).x -= 40;
							(Sprite)(_Blox[_Index-1]).y += 40;
							_F4 = 1;
						}
					}
					else if(_CurF >= 0.8 && _CurF < 0.9)
					{
						if(_F5 == 0)
						{
							(Sprite)(_Blox[_Index-3]).x -= 40;
							(Sprite)(_Blox[_Index-3]).y -= 40;
							(Sprite)(_Blox[_Index-2]).x += 0;
							(Sprite)(_Blox[_Index-2]).y += 80;
							(Sprite)(_Blox[_Index-1]).x -= 40;
							(Sprite)(_Blox[_Index-1]).y += 40;
							_F5 = 1;
						}
						else
						{
							(Sprite)(_Blox[_Index-3]).x += 40;
							(Sprite)(_Blox[_Index-3]).y += 40;
							(Sprite)(_Blox[_Index-2]).x += 0;
							(Sprite)(_Blox[_Index-2]).y -= 80;
							(Sprite)(_Blox[_Index-1]).x += 40;
							(Sprite)(_Blox[_Index-1]).y -= 40;
							_F5 = 0;
						}
					}
					else if(_CurF >= 0.9 && _CurF < 1)
					{
						if(_F6 == 0)
						{
							(Sprite)(_Blox[_Index-4]).x -= 40;
							(Sprite)(_Blox[_Index-4]).y += 40;
							(Sprite)(_Blox[_Index-3]).x -= 80;
							(Sprite)(_Blox[_Index-3]).y += 0;
							(Sprite)(_Blox[_Index-2]).x += 40;
							(Sprite)(_Blox[_Index-2]).y += 40;
							_F6 = 1;
						}
						else
						{
							(Sprite)(_Blox[_Index-4]).x += 40;
							(Sprite)(_Blox[_Index-4]).y -= 40;
							(Sprite)(_Blox[_Index-3]).x += 80;
							(Sprite)(_Blox[_Index-3]).y += 0;
							(Sprite)(_Blox[_Index-2]).x -= 40;
							(Sprite)(_Blox[_Index-2]).y -= 40;
							_F6 = 0;
						}
					}
				}
				addEventListener(KeyboardEvent.KEY_DOWN,onKeyPress);				
			}
			
			if(e.keyCode == Keyboard.SPACE)
			{
				for(var t:int = 0;t<20;t++)
				{
					(Sprite)(_Blox[_Index-4]).y += 40;
					(Sprite)(_Blox[_Index-3]).y += 40;
					(Sprite)(_Blox[_Index-2]).y += 40;
					(Sprite)(_Blox[_Index-1]).y += 40;
					for(i = 0;i<4;i++)
					{
						if((Sprite)(_Blox[_Index-1-i]).hitTestObject(_Bottom))
						{
							t = 20;
							(Sprite)(_Blox[_Index-4]).y -= 40;
							(Sprite)(_Blox[_Index-3]).y -= 40;
							(Sprite)(_Blox[_Index-2]).y -= 40;
							(Sprite)(_Blox[_Index-1]).y -= 40;
							break;
						}
					}
					
					for(j = 0;j<4;j++)
					{
						if(_Index != 4){
							for(k = 0;k < _Index - 4;k++)
							{
								if((Sprite)(_Blox[_Index-1-j]).hitTestObject((Sprite)(_Blox[k])))
								{
									(Sprite)(_Blox[_Index-4]).y -= 40;
									(Sprite)(_Blox[_Index-3]).y -= 40;
									(Sprite)(_Blox[_Index-2]).y -= 40;
									(Sprite)(_Blox[_Index-1]).y -= 40;
									t=20;
									j=4;
									break;
								}	
							}
						}
					}
				}
			}
			addEventListener(KeyboardEvent.KEY_DOWN,onKeyPress);
		}

	}
}