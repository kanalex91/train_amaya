package
{
	import flash.display.*;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.engine.DigitCase;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	
	import flashx.textLayout.operations.MoveChildrenOperation;
	
	public class Bezier extends Sprite
	{
		private var main:Sprite = new Sprite();
		[Embed(source = "dot_1.png")]public static const dot:Class;
		public static var _Dots:Array = [];
		public static var _W:Array = [];
		private var _cur_i:int = -1;
		private var _cur_j:int = -1;
		private var tr:Boolean = true;
		private var tr1:Boolean = false;
		private var _contM:ContextMenu = new ContextMenu();
		private var _item:ContextMenuItem = new ContextMenuItem("Change weight");
		private var _item1:ContextMenuItem = new ContextMenuItem("Separate");
		private var _item2:ContextMenuItem = new ContextMenuItem("Add point");
		private var _curP_i:int = 0;
		private var _curP_j:int = 0;
		private var _t:Number = 0;
		private var _num:TextField = new TextField();
		private var _speed:Number = 0.1;
		private var _sptxt:TextField = new TextField();
		private var _sptxt1:TextField = new TextField();
		private var _indB:int;
		
		public function Bezier()
		{
			addChild(main);
			main.graphics.beginFill(0xffffff);
			main.graphics.drawRect(0,0,2000,2000);
			main.graphics.endFill(); 
			
			createButton(800,800,0);
			createButton(50,800,1);
			
			_contM.customItems.push(_item);
			_contM.customItems.push(_item1);
			_contM.customItems.push(_item2);
			main.addChild(_num);
			_num.restrict = "0-9.";
			_num.visible =  false;
			_num.width = 100;
			_num.height = 20;
			
			
			main.addChild(_sptxt1);
			_sptxt1.x = 650;
			_sptxt1.y = 30;
			_sptxt1.width = 150;
			_sptxt1.height = 20;
			_sptxt1.text = "WeightChangeRate:";
			
			main.addChild(_sptxt);
			_sptxt.type = TextFieldType.INPUT;
			_sptxt.text = "0.1";
			_sptxt.border = true;
			_sptxt.restrict = "0-9.";
			_sptxt.width = 100;
			_sptxt.height = 20;
			_sptxt.x = 750;
			_sptxt.y = 30;
			_sptxt.addEventListener(Event.CHANGE,setWeight);
			main.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			var tmp:Array =[];
			var tmp1:Array =[];
			_Dots.push(tmp);
			_W.push(tmp1);
			_item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,ChangeW);
			_item1.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,SeparateMenu);
			_item2.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,AddPoint);
		
		}
		private function setWeight(e:Event):void
		{
			_speed = (Number)(_sptxt.text);
		}
		private function AddPoint(e:ContextMenuEvent):void
		{
			var pointsx:Array =[];
			var pointsy:Array =[];
			var weights:Array =[];
			var n:Number = _Dots[_cur_i].length;
			createPoint(0,0,_cur_i);
			for(var i:int = 0;i<n+1;i++)
			{
				pointsx.push(0);
				pointsy.push(0);
				weights.push(0);
			}
			
			for(i = 0;i<n+1;i++)
			{
				pointsx[i] = _Dots[_cur_i][i].x;
				pointsy[i] = _Dots[_cur_i][i].y;
				weights[i] = _W[_cur_i][i];
			}
			
			for(i = 1;i<n;i++)
			{
				_Dots[_cur_i][i].x = (i*weights[i-1]*pointsx[i-1] + (n - i)*weights[i]*pointsx[i])/(i*weights[i-1] + (n - i)*weights[i]);
				_Dots[_cur_i][i].y = (i*weights[i-1]*pointsy[i-1] + (n - i)*weights[i]*pointsy[i])/(i*weights[i-1] + (n - i)*weights[i]);
				_W[_cur_i][i] = (i*weights[i-1] + (n-i)*weights[i])/n;
			}
			_Dots[_cur_i][0].x = pointsx[0];
			_Dots[_cur_i][0].y = pointsy[0];
			_W[_cur_i][0] = weights[0];
			_Dots[_cur_i][n].x = pointsx[n-1];
			_Dots[_cur_i][n].y = pointsy[n-1];
			_W[_cur_i][n] = weights[n-1];
			
			drawCurve();
		}
		private function SeparateMenu(e:ContextMenuEvent):void
		{
			_num.text = "";
			_num.visible = true;
			_num.border = true;
			_num.x = mouseX+20;
			_num.y = mouseY+20;
			_num.type = TextFieldType.INPUT;
			_num.addEventListener(KeyboardEvent.KEY_DOWN,Separate);
		}
		private function Separate(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.ENTER)
			{
				_num.removeEventListener(KeyboardEvent.KEY_DOWN,Separate);
				var tmp:Array =[];
				var tmp1:Array =[];
				var n:Number = _Dots[_cur_i].length;
				var C:Number = 1;
				var pointsx:Array =[];
				var pointsy:Array =[];
				var weights:Array =[];
				_Dots.push(tmp);
				_W.push(tmp1);
				for(var i:int = 0;i<n;i++)
				{
					createPoint(0,0,_Dots.length-1);
					pointsx.push(0);
					pointsy.push(0);
					weights.push(0);
				}
				
				for(i = 0;i<n;i++)
				{
					pointsx[i] = _Dots[_cur_i][i].x;
					pointsy[i] = _Dots[_cur_i][i].y;
					weights[i] = _W[_cur_i][i];
				}
				
				_num.visible = false;
				_t = Number(_num.text);
				
				for(var j:int = 0;j<n;j++)
				{
					_W[_cur_i][j] = 0;
					C = 1;
					for(var k:int = 0;k<j+1;k++)
					{
						_W[_cur_i][j] += C*Math.pow(_t,k)*Math.pow(1-_t,j - k)*weights[k];
						C = C*(j-k)/(k+1);
					}
					
					C = 1;
					_Dots[_cur_i][j].x = 0;
					_Dots[_cur_i][j].y = 0;
					for(i = 0;i<j+1;i++)
					{
						_Dots[_cur_i][j].x += C*Math.pow(_t,i)*Math.pow(1-_t,j - i)*weights[i]*pointsx[i]/_W[_cur_i][j];
						_Dots[_cur_i][j].y += C*Math.pow(_t,i)*Math.pow(1-_t,j - i)*weights[i]*pointsy[i]/_W[_cur_i][j];
						C = C*(j-i)/(i+1);
					}
				}
				var last:Number = _Dots.length - 1;
				for(j = 0;j<n;j++)
				{
					_W[last][n-1-j] = 0;
					C = 1;
					for(k = 0;k<j+1;k++)
					{
						_W[last][n-1-j] += C*Math.pow(_t,j-k)*Math.pow(1-_t,k)*weights[n-1-k];
						C = C*(j-k)/(k+1);
					}
					
					C = 1;
					_Dots[last][n-1-j].x = 0;
					_Dots[last][n-1-j].y = 0;
					for(i = 0;i<j+1;i++)
					{
						_Dots[last][n-1-j].x += C*Math.pow(_t,j-i)*Math.pow(1-_t,i)*weights[n-1-i]*pointsx[n-1-i]/_W[last][n-1-j];
						_Dots[last][n-1-j].y += C*Math.pow(_t,j-i)*Math.pow(1-_t,i)*weights[n-1-i]*pointsy[n-1-i]/_W[last][n-1-j];
						C = C*(j-i)/(i+1);
					}
				}
				drawCurve();
					
			}
			
		}
		private function ChangeW(e:ContextMenuEvent):void
		{
			_num.text = "";
			_num.visible = true;
			_num.border = true;
			_num.x = mouseX+20;
			_num.y = mouseY+20;
			_num.type = TextFieldType.INPUT;
			_num.addEventListener(KeyboardEvent.KEY_DOWN,setW);
		}
		private function setW(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.ENTER)
			{

				_num.visible = false;
				_W[_curP_i][_curP_j] = _num.text;
				cWeight();
				drawCurve();
				_num.removeEventListener(KeyboardEvent.KEY_DOWN,setW);
			}
		}
		private function createPoint(X:Number, Y:Number,ind:int):void
		{
			var _Image:Bitmap = new dot();	
			var _but:SimpleButton = new SimpleButton();
			var _txt:TextField = new TextField();
			var _sp:Sprite = new Sprite();
			
			_txt.width = 37;
			_txt.height = 20;
			_txt.text = "1";
			_txt.x -= 15;
			_txt.y -= 15;
			_sp.addChild(_txt);
			_sp.addChild(_Image);
			_but.upState = _sp;
			_but.overState = _sp;
			_but.downState = _sp;
			_but.hitTestState = _Image;
			_but.x = X - 11;
			_but.y = Y - 11;
			_but.addEventListener(MouseEvent.RIGHT_CLICK,onMouseClick);
			_but.addEventListener(MouseEvent.MOUSE_DOWN,onDown);
			_but.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN,onRDown);
			_but.addEventListener(MouseEvent.MOUSE_UP,onUp);
			_but.addEventListener(MouseEvent.MOUSE_OUT,onOut);
			_but.addEventListener(MouseEvent.MOUSE_OVER,onOver);
			main.addChild(_but);
			_Dots[ind].push(_but);
			_W[ind].push(1);
		}
		private function createButton(X:Number, Y:Number, i:int):void
		{	
			var _but:SimpleButton = new SimpleButton();
			var _sp:Sprite = new Sprite();
			var _txt:TextField = new TextField();
			if(i == 0)_txt.text = "Draw curve";
			else _txt.text = "Reset";
			_sp.graphics.beginFill(0xa0a0a0);
			_sp.graphics.drawRect(0,0,80,80);
			_sp.graphics.endFill();

			_sp.addChild(_txt);
			_txt.y += 20;
			_txt.x += 10;
			
			_txt.thickness = 3;
			_but.upState = _sp;
			_but.overState = _sp;
			_but.downState = _sp;
			_but.hitTestState = _sp;
			_but.x = X;
			_but.y = Y;
			
			if(i == 0)
			{
				_but.addEventListener(MouseEvent.CLICK,onClick);
				_but.addEventListener(MouseEvent.MOUSE_OVER,onOver);
				_but.addEventListener(MouseEvent.MOUSE_OUT,onOut);
			}
			else
			{
				_but.addEventListener(MouseEvent.CLICK,onReset);
				_but.addEventListener(MouseEvent.MOUSE_OVER,onOver);
				_but.addEventListener(MouseEvent.MOUSE_OUT,onOut);	
			}
			main.addChild(_but);
		}
		
		private function onReset(e:MouseEvent):void
		{
			main.graphics.clear();
			main.graphics.beginFill(0xffffff);
			main.graphics.drawRect(0,0,2000,2000);
			main.graphics.endFill(); 
			main.getChildAt(0).visible = true;
			var s:int = 0;
			_sptxt.text = "0.1";
			for(var i:int = 0;i<_Dots.length;i++)
			{
				for(var j:int = 0;j<_Dots[i].length;j++)
				{
					main.removeChild(_Dots[i][j]);
					s++;
				}
			}	
			_Dots = [];
			_W = [];
			_cur_i = -1;
			_cur_j = -1;
			tr = true;
			tr1 = false;
			_curP_i = 0;
			_curP_j = 0;
			_t = 0;
			_speed = 0.1
			_num.visible =  false;
			var tmp:Array =[];
			var tmp1:Array =[];
			_Dots.push(tmp);
			_W.push(tmp1);
		}
		private function onClick(e:MouseEvent):void
		{
			if(_Dots[0].length > 0)
			{
				tr = false;
				tr1 = true;
				main.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
				e.currentTarget.visible = false;
				drawCurve();
			}
			
		}
		private function cWeight():void
		{
			(TextField)((Sprite)((SimpleButton)(_Dots[_cur_i][_cur_j]).overState).getChildAt(0)).text = _W[_cur_i][_cur_j].toString();			
		}
		private function drawCurve():void
		{
			main.graphics.clear();
			main.graphics.beginFill(0xffffff);
			main.graphics.drawRect(0,0,2000,2000);
			main.graphics.endFill();
			
			for(var ind:int = 0;ind < _Dots.length;ind++)
			{
				
				
				var X1:Number = _Dots[ind][0].x + 11;
				var Y1:Number = _Dots[ind][0].y + 11;
				var X2:Number = 0;
				var Y2:Number = 0;
				var n:Number = _Dots[ind].length;
				var w0:Number = 0;
				var C:Number = 1;
				
				main.graphics.moveTo(_Dots[ind][0].x+11,_Dots[ind][0].y+11);
				main.graphics.lineStyle(1,0xf00000,1);
				for(i = 0;i<n-1;i++)
				{
					main.graphics.lineTo(_Dots[ind][i+1].x+11,_Dots[ind][i+1].y+11);
				}
				
				main.graphics.lineStyle(1,0,1);
				main.graphics.moveTo(X1,Y1);
				
				
				
				for(var j:int = 0;j<=300;j++)
				{
					C = 1;
					
					for(var k:int = 0;k<n;k++)
					{
						w0 += C*Math.pow(j/300,k)*Math.pow(1-j/300,n - 1 - k)*_W[ind][k];
						C = C*(n-1-k)/(k+1);
					}
					
					C = 1;
					for(var i:int = 0;i<n;i++)
					{
						X2 += C*Math.pow(j/300,i)*Math.pow(1-j/300,n - 1 - i)*(_Dots[ind][i].x + 11)*_W[ind][i]/w0;
						Y2 += C*Math.pow(j/300,i)*Math.pow(1-j/300,n - 1 - i)*(_Dots[ind][i].y + 11)*_W[ind][i]/w0;
						C = C*(n-1-i)/(i+1);
					}
					
					main.graphics.lineTo(X2,Y2);
					X1 = X2;
					Y1 = Y2;
					w0 = 0;
					Y2 = 0;
					X2 = 0;
				}
			}
		}
		private function onOver(e:MouseEvent):void
		{
			
			for(var ind:int = 0;ind<_Dots.length;ind++)
			{
				for(var i:int = 0;i<_Dots[ind].length;i++)
				{
					if(e.currentTarget == _Dots[ind][i])
					{
						_cur_i = ind;
						_cur_j = i;
					}
				}
			}
			main.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			main.addEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheel);
		}
		private function onMouseWheel(e:MouseEvent):void
		{
			if(e.delta > 0)
			{
				_W[_cur_i][_cur_j] += _speed;
				cWeight();
			}
			if(e.delta < 0)
			{
				if(_W[_cur_i][_cur_j] - _speed > 0.00001)_W[_cur_i][_cur_j] -= _speed;
				else _W[_cur_i][_cur_j] = 0.00001;
				cWeight();
			}
			drawCurve();
		}
		private function onOut(e:MouseEvent):void
		{
			main.removeEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheel);
			if(tr == true)
			{
				main.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			}
		}
		private function onDown(e:MouseEvent):void
		{
			for(var ind:int = 0;ind<_Dots.length;ind++)
			{
				for(var i:int = 0;i<_Dots[ind].length;i++)
				{
					if(e.currentTarget == _Dots[ind][i])
					{
						_cur_i = ind;
						_cur_j = i;
						main.addEventListener(MouseEvent.MOUSE_MOVE,onMove);
					}
				}
			}
		}
		private function onRDown(e:MouseEvent):void
		{
			for(var ind:int = 0;ind<_Dots.length;ind++)
			{
				for(var i:int = 0;i<_Dots[ind].length;i++)
				{
					if(e.currentTarget == _Dots[ind][i])
					{
						_cur_i = ind;
						_cur_j = i;
					}
				}
			}
		}
		private function onUp(e:MouseEvent):void
		{
			main.removeEventListener(MouseEvent.MOUSE_MOVE,onMove);
		}
		private function onMove(e:MouseEvent):void
		{
			
			
			if(tr1 == true)
			{
				_Dots[_cur_i][_cur_j].x = mouseX-11;
				_Dots[_cur_i][_cur_j].y = mouseY-11;
				drawCurve();
			}
		}
		private function onMouseDown(e:MouseEvent):void
		{
			createPoint(mouseX,mouseY,0);
			main.graphics.lineStyle(1,0xf00000,1);
				var n:int = _Dots[0].length;
				if(n > 1)
				{
					main.graphics.moveTo(_Dots[0][n-2].x+11,_Dots[0][n-2].y+11);
					main.graphics.lineTo(_Dots[0][n-1].x+11,_Dots[0][n-1].y+11);
				}
		}
		private function onMouseClick(e:MouseEvent):void
		{
			for(var ind:int = 0;ind < _Dots.length; ind++)
			{
			    for(var i:int = 0;i < _Dots[ind].length; i++)
				{
					if(e.currentTarget == _Dots[ind][i])
					{
						_curP_i = ind;
						_curP_j = i;
					}
				}
			}
			if(tr1 == true)_contM.display(main.stage,mouseX,mouseY);
		}
	}
}4