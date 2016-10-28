package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.trace.Trace;
	import flash.utils.Endian;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import org.osmf.elements.ImageLoader;
	import org.osmf.elements.SWFLoader;
	import org.osmf.events.TimeEvent;

	
	public class Snake extends Sprite
	{
		private var _TUp:TextField;
		private var _TDown:TextField;
		private var _TRight:TextField;
		private var _TLeft:TextField;
		private var _Score:TextField;
		private var _GameField:Sprite;
		private var _timer:Timer;
		private var _x:Number = 20;
		private var _y:Number = 0;
		private var _Head:Sprite;
		private var _Body:Array = new Array();
		private var _Food:Sprite;
		private var _Up:Sprite;
		private var _Down:Sprite;
		private var _Right:Sprite;
		private var _Left:Sprite;
		private var _index:Number = 1;
		private var _fl:Number = 1;
		private var _fend:Boolean = false;
		private var _speed:Number = 1;
		public function Snake()
		{	
			
			_GameField = new Sprite();
			_GameField.graphics.beginFill(0xdddddd);
			_GameField.graphics.drawRect(100,0,600,400);
			_GameField.graphics.endFill();
			_GameField.graphics.lineStyle(1,0,1);
			_GameField.graphics.lineTo(100,400);
			_GameField.graphics.lineTo(700,400);
			_GameField.graphics.lineTo(700,0);
			_GameField.graphics.lineTo(100,0);
			addChild(_GameField);
			
			stage.focus = this;
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			for(var k:int = 0 ;k < 30;k++)
			{
				_GameField.graphics.lineTo(100 + k * 20,400);
				_GameField.graphics.lineTo(100 + (k+1) * 20,400);
				_GameField.graphics.lineTo(100 + (k+1) * 20,0);
			}
			
			for(var t:int = 0 ;t < 20;t++)
			{
				_GameField.graphics.lineTo(100,0 + t*20);
				_GameField.graphics.lineTo(100,0 + (t+1) * 20);
				_GameField.graphics.lineTo(700,0 + (t+1) * 20);
			}
			
			_Food = new Sprite();
			_Food.graphics.beginFill(0x999999);
			_Food.graphics.drawRect(202,202,16,16);
			_Food.graphics.endFill();
			_GameField.addChild(_Food);
			
			_Head = new Sprite();
			_Head.graphics.beginFill(0x555555);
			_Head.graphics.drawRect(302,302,16,16);
			_Head.graphics.endFill();
			_GameField.addChild(_Head);
			
			_Body[0] = new Sprite();
			_Body[0] = _Head;
			
			_Body[_index] = new Sprite();
			(Sprite)(_Body[_index]).graphics.beginFill(0x000000);
			(Sprite)(_Body[_index]).graphics.drawRect(302,302,16,16);
			(Sprite)(_Body[_index]).graphics.endFill();
			_GameField.addChild((Sprite)(_Body[_index++]));
			
			_Body[_index] = new Sprite();
			(Sprite)(_Body[_index]).graphics.beginFill(0x000000);
			(Sprite)(_Body[_index]).graphics.drawRect(302,302,16,16);
			(Sprite)(_Body[_index]).graphics.endFill();
			_GameField.addChild((Sprite)(_Body[_index++]));
			
			_Score = new TextField();
			_Score.text = "Score: " + (_index-3).toString();
			_Score.x = 20;
			_Score.y = 100;
			_GameField.addChild(_Score);
			
			_timer = new Timer(500,0);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.start();
			
			_Up = new Sprite();
			//_TUp = new TextField();
			_Up.graphics.beginFill(0xff0000);
			_Up.graphics.drawRoundRect(200,450,50,50,20,20);
			_Up.graphics.endFill();
			addChild(_Up);
			//_TUp.textColor = 0x000000;
			//_TUp.text = "Up";
			//_TUp.x = 215;
			//_TUp.y = 465;
			//_Up.addChild(_TUp);
			_Up.addEventListener(MouseEvent.CLICK, _UpMove);
			
			_Down = new Sprite();
			//_TDown = new TextField();
			_Down.graphics.beginFill(0xff0000);
			_Down.graphics.drawRoundRect(200,520,50,50,20,20);
			_Down.graphics.endFill();
			addChild(_Down);
			//_TDown.textColor = 0x000000;
			//_TDown.text = "Down";
			//_TDown.x = 215;
			//_TDown.y = 535;
			//_Down.addChild(_TDown);
			_Down.addEventListener(MouseEvent.CLICK, _DownMove);
			
			_Right = new Sprite();
			//_TRight = new TextField();
			_Right.graphics.beginFill(0xff0000);
			_Right.graphics.drawRoundRect(270,520,50,50,20,20);
			_Right.graphics.endFill();
			addChild(_Right);
			//_TRight.textColor = 0x000000;
			//_TRight.text = "Right";
			//_TRight.x = 285;
			//_TRight.y = 535;
			//_Right.addChild(_TRight);
			_Right.addEventListener(MouseEvent.CLICK, _RightMove);
			
			_Left = new Sprite();
			//_TLeft = new TextField();
			_Left.graphics.beginFill(0xff0000);
			_Left.graphics.drawRoundRect(130,520,50,50,20,20);
			_Left.graphics.endFill();
			addChild(_Left);
			//_TLeft.textColor = 0x000000;
			//_TLeft.text = "Left";
			//_TLeft.x = 145;
			//_TLeft.y = 535;
			//_Left.addChild(_TLeft);
			_Left.addEventListener(MouseEvent.CLICK, _LeftMove);
			
			
		}
		
		private function _UpMove(events:MouseEvent):void
		{
			if(_fl != 4){
			_y = -20;
			_x = 0;
			_fl = 3;
			}
		}
		private function _DownMove(events:MouseEvent):void
		{
			if(_fl != 3){
			_y = 20;
			_x = 0;
			_fl = 4
			}
		}
		private function _RightMove(events:MouseEvent):void
		{
			if(_fl != 2){
			_y = 0;
		  	_x = 20;
			_fl = 1
			}
		}
		private function _LeftMove(events:MouseEvent):void
		{
			if(_fl != 1){
			_y = 0;
			_x = -20;
			_fl = 2
			}
		}
		
		private function onTimer(events:TimerEvent):void
		{
			if(!_fend)
			{
				stage.focus = this;
				if(_Food.hitTestObject(_Head))
				{
					if(_index > 10*_speed){
						_timer.delay = Math.floor(500/++_speed);
						
					}
					_Score.text = "Score: " + (_index-2).toString();
					_Food.x = Math.floor((Math.random() * 560));
					_Food.y = Math.floor((Math.random() * 360));
					_Food.x /= 20;
					_Food.y /= 20;
					_Food.x = Math.floor(_Food.x);
					_Food.y = Math.floor(_Food.y);
					_Food.x = (_Food.x * 20) - 80;
					_Food.y = (_Food.y * 20) - 160;
				    
					_Body[_index] = new Sprite();
					(Sprite)(_Body[_index]).graphics.beginFill(0x000000);
					(Sprite)(_Body[_index]).graphics.drawRect(302,302,16,16);
					(Sprite)(_Body[_index]).graphics.endFill();
					_GameField.addChild((Sprite)(_Body[_index]));
					
					(Sprite)(_Body[_index]).x = _Head.x ;
					(Sprite)(_Body[_index]).y = _Head.y ;
					_index++;
				}
				
				if(_Food.alpha == 0.5)_Food.alpha = 1;
				else _Food.alpha = 0.5;
				
				for(var i:int = _index-2 ; i >= 0 ;i--)
				{
					(Sprite)(_Body[i+1]).x = (Sprite)(_Body[i]).x;
					(Sprite)(_Body[i+1]).y = (Sprite)(_Body[i]).y ;
				}
				
				_Head.x += _x;
				_Head.y += _y;
				if(_Head.x == 400 && _x > 0)_Head.x = -200;
				else if(_Head.x == -220 && _x < 0)_Head.x = 380;
				if(_Head.y == 100 && _y > 0)_Head.y = -300;
				else if(_Head.y == -320 && _y < 0)_Head.y = 80;			
				
				for(var j:int = 1; j < _index;j++)
				{
					if(_Head.hitTestObject(_Body[j])){
						//_timer.stop();
						_fend = true;
					}
				}
			}
			else 
			{
				for(var l:int = 0;l < _index;l++)
				{
					if((Sprite)(_Body[l]).visible)(Sprite)(_Body[l]).visible = false;
					else (Sprite)(_Body[l]).visible = true;
				}
			}
			
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode == 37)
			{
				if(_fl != 1){
					_y = 0;
					_x = -20;
					_fl = 2
				}
			}
			else if(event.keyCode == 38)
			{
				if(_fl != 4){
					_y = -20;
					_x = 0;
					_fl = 3;
				}	
			}
			else if(event.keyCode == 39)
			{
				if(_fl != 2){
					_y = 0;
					_x = 20;
					_fl = 1
				}
			}
			else if(event.keyCode == 40)
			{
			
				if(_fl != 3){
					_y = 20;
					_x = 0;
					_fl = 4
				}
			}
		}
		
		/*public function Snake()
		{
			trace("Hello world!");
			stage.focus = this;
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		private function onKeyDown(event:KeyboardEvent):void
		{
			trace("Key down: " + event.charCode);
		}*/
		
		
		/*private var _sprite: Sprite;
		public function Snake()
		{
			_sprite = new Sprite();
			addChild(_sprite);
			
			_sprite.graphics.beginFill(0xffffff);
			_sprite.graphics.drawRect(0,0,1000,1000);
			_sprite.graphics.endFill();
			_sprite.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_sprite.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
		}
		private function onMouseDown(event:MouseEvent):void
		{
			_sprite.graphics.lineStyle(1,0,1);
			_sprite.graphics.moveTo(mouseX,mouseY);
			_sprite.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		private function onMouseUp(event:MouseEvent):void
		{
			_sprite.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseMove(event:MouseEvent):void
		{
			_sprite.graphics.lineTo(mouseX,mouseY);
		}*/
		
		 
		/*private var _square:Sprite;
		private var _circle:Sprite;
		
		public function Snake()
		{
			_square = new Sprite();
			_square.graphics.beginFill(0xff0000);
			_square.graphics.drawRect(0,0,100,100);
			_square.graphics.endFill();
			addChild(_square);
			_square.x = 100;
			_square.y = 50;
			
			_circle = new Sprite();
			_circle.graphics.beginFill(0x00ffff);
			_circle.graphics.drawCircle(50,50,50);
			_circle.graphics.endFill();
			addChild(_circle);
			_circle.x = 200;
			_circle.y = 100;
			
			var _st:Timer = new Timer(50,0);
			_st.addEventListener(TimerEvent.TIMER, onST);
			_st.start();
			
			var _ct:Timer = new Timer(50,0);
			_ct.addEventListener(TimerEvent.TIMER, onCT);
			_ct.start();
		}
		
		private function onST(events:TimerEvent):void
		{
			_square.x++;
		}	
		private function onCT(events:TimerEvent):void
		{
			_circle.x++;
		}*/
	}
}