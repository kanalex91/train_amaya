package
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.b2AABB;
	import Box2D.Collision.b2Manifold;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2ContactImpulse;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import flash.display.DisplayObjectContainer;
	import flash.text.*;			

	
	public class ContactListener extends b2ContactListener
	{
			public static var aDestroy:Array = [];
			
			override public function BeginContact(contact:b2Contact):void {		
				
			}
			
			override public function EndContact(contact:b2Contact):void {
				
			}
			
			override public function PreSolve(contact:b2Contact, oldManifold:b2Manifold):void {
				
			}
			
			override public function PostSolve(contact:b2Contact, impulse:b2ContactImpulse):void {
				var bodyA:b2Body = contact.GetFixtureA().GetBody();
				var bodyB:b2Body = contact.GetFixtureB().GetBody();
				
				var skinA:DisplayObjectContainer = bodyA.GetUserData();
				var skinB:DisplayObjectContainer = bodyB.GetUserData();
				
				if(bodyA.GetFixtureList().GetDensity() != 10)
				{
					aDestroy.push(bodyA);
					AngryBirds.sp += (AngryBirds.sp/50);
					AngryBirds.count++;
					if(AngryBirds.count == 100)
					{
						AngryBirds.text.visible = true;
					}
				}
			} 	
	}
}