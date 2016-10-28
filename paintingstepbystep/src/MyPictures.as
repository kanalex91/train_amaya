package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.drm.AddToDeviceGroupSetting;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	
	public class MyPictures
	{
		private var _ImLoader:Loader = new Loader();
		private var i:int = 0;
		public static var _pictures:Array = [];
		
		public function MyPictures()
		{
			_ImLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			_ImLoader.load(new URLRequest("Pictures/1_0.png"));
		}
		
		private function onComplete(event:Event):void
		{
			var _Image:Bitmap = Bitmap(_ImLoader.content);
			
			if(i++ == 180)
			{
				_ImLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
			}
			else
			{
				var j:int;
				var k:int;
				j = (i+6)%6;
				k = (i+6)/6;
				_Image.smoothing = true;
				_pictures.push(_Image);
				_ImLoader.load(new URLRequest("Pictures/"+k+"_"+j+".png"));
			}
		}
	}
}