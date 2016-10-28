package
{
	import flash.text.*;
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	
	import flashx.textLayout.formats.BlockProgression;
	
	public class AngryBirds extends Sprite
	{
		[Embed(source = "Block.jpg")]public static const Block:Class;
		[Embed(source = "222.png")]public static const Block1:Class;
		[Embed(source = "Ball2.png")]public static const Ball:Class;
		
		private var x1:Number;
		private var y1:Number;
		private var p:Number;
		private var _world:b2World;
		private const METR:int = 30;
		private var _ImLoader:Loader = new Loader();
		private var spriteToDraw:Sprite = new Sprite();
		private var _arc:b2Body;
		private var _Move:Number = 0;
		private var _hit:b2ContactListener = new b2ContactListener();
		private var ball:b2Body;
		public static var sp:Number = 98;
		public static var count:Number = 0;
		public static var text:TextField = new TextField();
		public static var _format_01:TextFormat = new TextFormat;
		_format_01.size = 40;
		_format_01.font = "Verdana";
		_format_01.color = 0xffffff;
		_format_01.align = "center";
		text.defaultTextFormat = _format_01;
		text.text = "You Win! Congratulation!";
		 
		
		public function AngryBirds():void
		{			
			_ImLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			_ImLoader.load(new URLRequest("Space.jpg"));
			
			_world = new b2World(new b2Vec2(0,0), true);
			
			_world.SetContactListener(new ContactListener());
			
			shapeCreator(-10,400,0,20,800,1,0,10,0,false, false);
			shapeCreator(1010,400,0,20,800,1,0,10,0,false, false);
			shapeCreator(500,-10,0,1000,20,1,0,10,0,false, false);
			arcCreator(500,760,150,1);
			
			for(var i:int = 0;i<10;i++)
			{
				for(var j:int = 0; j<10;j++)
				{
					shapeCreator(140 + i*80, 60 + j*40, 0, 40, 20, 0, 0, 0, 0, false);
				}
			}
			shapeCreator(500, 740, 20, 0, 0, 1, 0.4, 10, 0, true, true, 1);
			
			stage.focus = this;
			
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			debugDraw();
			addEventListener(Event.ENTER_FRAME, update);
			
			text.x = 250;
			text.y = 200;
			text.width = 600;
			text.border = true;
			
		}
		
		private function onMouseMove(e:MouseEvent):void
		{
			
		}
		
		private function onComplete(event:Event):void
		{
			var _Image:Bitmap = Bitmap(_ImLoader.content);
			var _BitMap:BitmapData = _Image.bitmapData;
			addChild(_Image);
			addChild(spriteToDraw);
			addChild(text);
			text.visible = false;
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.LEFT)_Move = -15;
			if(e.keyCode == Keyboard.RIGHT)_Move = 15;
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.LEFT)_Move = 0;
			if(e.keyCode == Keyboard.RIGHT)_Move = 0;
		}
		
		private function update(e:Event):void 
		{
			stage.focus = this;
			
			if(ball.GetPosition().y > 769/METR)_arc.GetFixtureList().SetSensor(true);
			if(_arc.GetPosition().x <= 75/METR)_arc.SetPosition(new b2Vec2(75/METR,1060/METR));
			if(_arc.GetPosition().x >= 925/METR)_arc.SetPosition(new b2Vec2(925/METR,1060/METR));
			
			_world.Step(1/30,20,20);
			_world.ClearForces();
			_world.DrawDebugData();
			
			x1 = ball.GetLinearVelocity().x;
			y1 = ball.GetLinearVelocity().y;
			
			p = Math.pow(x1*x1 + y1*y1,0.5);
			p = p/Math.pow(sp,0.5);
			
			ball.SetLinearVelocity(new b2Vec2(x1/p,y1/p));
			
			if (!_world.IsLocked()) {
				
				for (var i:int = 0; i < ContactListener.aDestroy.length; i++) {
					_world.DestroyBody(ContactListener.aDestroy[i]);
					var sprite:* = (b2Body)(ContactListener.aDestroy[i]).GetUserData();
					ContactListener.aDestroy[i] = null;
					(Sprite)(sprite).visible = 0;	
				}
				ContactListener.aDestroy.splice(0);
				
			}
			
			for(var bodiesList:b2Body = _world.GetBodyList(); bodiesList; bodiesList = bodiesList.GetNext())
			{
				var sprite:* = bodiesList.GetUserData();
				var position:b2Vec2 = bodiesList.GetPosition();
				if(sprite != null)
				{
					sprite.x = position.x * METR;
					sprite.y = position.y * METR;
					sprite.rotation = bodiesList.GetAngle() * 180 / Math.PI;
				}
			}
				_arc.SetAwake(true);
				_arc.GetLinearVelocity().x = _Move;
		
		}
		
		public function shapeCreator(xp:Number, yp:Number, r:Number, h:Number, w:Number, res:Number, fric:Number ,dens:Number, rot:Number, dinamicshape:Boolean,  pic:Boolean = true, type:int = 0):void 
		{
			var shape:b2Body;
			var shapeDef:b2BodyDef;
			var shapeFixture:b2FixtureDef;
			var sprite:Sprite = new Sprite();
			if(pic)
			{
				var bitmap:Bitmap = new Block();
				var bitmap2:Bitmap = new Ball();
				if(type == 0)
				{
					bitmap.width /= 2;
					bitmap.height /= 2;
					bitmap.x = -bitmap.width / 2;
					bitmap.y = -bitmap.height / 2;
					sprite.x = xp;
					sprite.y = yp;
					sprite.addChild(bitmap);
					spriteToDraw.addChild(sprite);
				}
				else
				{
					bitmap2.width*=2;
					bitmap2.height*=2;
					bitmap2.x = -bitmap.width/4;
					bitmap2.y = -bitmap.height/2;
					sprite.x = xp;
					sprite.y = yp;
					sprite.addChild(bitmap2);
					spriteToDraw.addChild(sprite);
				}
			}
			shapeDef = new b2BodyDef();
			shapeDef.position.Set(xp / METR, yp / METR);
			shapeDef.angle = rot;
	
			shapeDef.userData = sprite;
			
			if (dinamicshape) {
				shapeDef.type = b2Body.b2_dynamicBody;
			} else {
				shapeDef.type = b2Body.b2_staticBody;
			}
			
			shapeFixture = new b2FixtureDef();
			
			switch(type)
			{
				case 0:var shapeBox:b2PolygonShape = new b2PolygonShape();shapeFixture.shape = shapeBox;
					shapeBox.SetAsBox((h / 2) / METR, (w / 2) / METR);break;
				case 1:var shapeCircle:b2CircleShape = new b2CircleShape();shapeFixture.shape = shapeCircle;
					shapeCircle.SetRadius((r / 2) / METR);break;
			}
			
			shapeFixture.restitution = res;
			shapeFixture.friction = fric;
			shapeFixture.density = dens;
			
			if(type == 0)
			{
				shape = _world.CreateBody(shapeDef);
				shape.CreateFixture(shapeFixture);	
			}
			else if(type == 1)
			{
				ball = _world.CreateBody(shapeDef);
				ball.CreateFixture(shapeFixture);
				ball.ApplyImpulse(new b2Vec2(7,-7), new b2Vec2(xp / METR, yp / METR));
			}
			
		}
		
		public function arcCreator(xp:Number, yp:Number, h:Number, w:Number):void 
		{
			var shapeDef:b2BodyDef;
			var shapeFixture:b2FixtureDef;
			var sprite:Sprite = new Sprite();
			
			var bitmap:Bitmap = new Block1();
				
			bitmap.width *= 2;
			bitmap.height *= 1;
			bitmap.x = -bitmap.width / 2 + 8;
			bitmap.y = -bitmap.height / 2.5 - 270;
			sprite.x = xp;
			sprite.y = yp;
			sprite.addChild(bitmap);
			spriteToDraw.addChild(sprite);

			shapeDef = new b2BodyDef();
			shapeDef.position.Set(xp / METR, (yp + 300)/ METR);
			
			shapeDef.userData = sprite;
			shapeDef.type = b2Body.b2_kinematicBody;
			
			
			shapeFixture = new b2FixtureDef();
		
//			var shapeBox:b2PolygonShape = new b2PolygonShape();
//			shapeFixture.shape = shapeBox;
//			shapeBox.SetAsBox((h / 2) / METR, (w / 2) / METR);
			var shapeBox:b2CircleShape = new b2CircleShape();
			shapeFixture.shape = shapeBox;
			shapeBox.SetRadius((h * 2) / METR);
			
			
			shapeFixture.restitution = 0;
			shapeFixture.friction = 0.4;
			shapeFixture.density = 10;
			
			
			_arc = _world.CreateBody(shapeDef);
			_arc.CreateFixture(shapeFixture);
			
		}
		
		private function debugDraw():void 
		{
			var drawThis:b2DebugDraw = new b2DebugDraw();
			drawThis.SetSprite(spriteToDraw);
			drawThis.SetDrawScale(30);
			drawThis.SetFlags(b2DebugDraw.e_shapeBit);
			drawThis.SetDrawScale(METR);
			drawThis.SetAlpha(1);
			drawThis.SetFillAlpha(0);
			drawThis.SetLineThickness(1);
			_world.SetDebugDraw(drawThis);
		}
	}
}
