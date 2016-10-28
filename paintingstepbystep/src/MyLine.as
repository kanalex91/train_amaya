package
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.html.script.Package;
	import flash.net.FileReference;
	import flash.system.JPEGLoaderContext;
	import flash.ui.Mouse;
	import flash.utils.*;
	import flash.utils.ByteArray;
	
	public class MyLine
	{
		public var _LineStyle:Number;
		public var _X:Number;
		public var _Y:Number;
		public var _MoveX:Number;
		public var _MoveY:Number;
		public var _draw:String;
		public var _color:uint;
		
		public function MyLine(l:Number,x:Number,y:Number,X:Number,Y:Number,dr:String,col:uint = 0x000000)
		{
			_LineStyle = l;
			_X = x;
			_Y = y;
			_MoveX = X;
			_MoveY = Y;
			_draw = dr;
			_color = col;
		}
	}
}