package hero
{
	import maths.GameMaths;
	public class HeroBullet extends HeroBulletSWC
	{
		public var _xVelocity:Number;
		public var _yVelocity:Number;
		private var _bulletRotationDegrees:Number;
		private var _bulletRotationRadians:Number;
		private var _speed:Number;
		//Number 1 is max accuracy higher is worse
		private var _accuracy:Number;
		
		public function HeroBullet(heroRotation:Number, heroXPosition:Number, heroYPosition:Number)
		{
			//Initialize vars--------------------------------------//
			this.x = heroXPosition;
			this.y = heroYPosition;
			this.cacheAsBitmap = true;
			_bulletRotationDegrees = heroRotation;
			_bulletRotationRadians = GameMaths.degreesToRadians((_bulletRotationDegrees - 10) + (Math.random() * 20) );
			_xVelocity = Math.cos(_bulletRotationRadians);
			_yVelocity = Math.sin(_bulletRotationRadians);
			_speed = 6;
			_accuracy = 15;
		}
		public function update():void {
			movement();
		}
		
		private function movement():void {
			this.x += _xVelocity*_speed;
			this.y += _yVelocity*_speed;
		}
	}
}