package
{
	
	//import PNGEncoder.*;
	
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
	import flash.filesystem.*;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.html.script.Package;
	import flash.net.FileReference;
	import flash.system.JPEGLoaderContext;
	import flash.ui.Mouse;
	import flash.utils.*;
	import flash.utils.ByteArray;
	
	public class paintingstepbystep extends Sprite
	{
		public static var start:Boolean = false;
		private var _main:Sprite = new Sprite();
		private var ss1:MyPictures = new MyPictures;
		private var ss2:MyPen = new MyPen;
		private var ss3:MainWindow1 = new MainWindow1;
		private var ss4:ColorPicker = new ColorPicker;
		private var ss5:Paint = new Paint;
		private var ss6:About_game = new About_game();
		private var ss7:Source = new Source();
		public static var timeline:TimelineMax = new TimelineMax({repeat:0});
		public static var timeline2:TimelineMax = new TimelineMax({repeat:0});
		
		public function paintingstepbystep()
		{
			
			super();
			
			graphics.beginFill(0x000000);
			graphics.drawRect(0,0,2000,2000);
			graphics.endFill();
		
			timeline.active = false;
			timeline2.active = false;
			
			//TweenPlugin.activate([AutoAlphaPlugin]);
			TweenPlugin.activate([VisiblePlugin]);
			
			addChild(MyPen._sprite);
			addChild(Paint._sprite);
			
				
			
			addChild(MainWindow1.container);
			addChild(MainWindow1.container2);
			addChild(MainWindow1.window);
			addChild(About_game._sprite);
			MyPen._sprite.visible = false;
			Paint._sprite.visible = false;
			MyPen._sprite.x += 768;
			Paint._sprite.x += 768;
			
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.autoOrients = false;

		}
	}
}