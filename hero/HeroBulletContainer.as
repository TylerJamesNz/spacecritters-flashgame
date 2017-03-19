package hero
{
	import flash.geom.Point;
	import flash.media.Sound;
	import level.LevelBoundary;
	import level.ParticleContainer;
	import maths.Collisions;
	
	public class HeroBulletContainer extends HeroBulletContainerSWC
	{
		public var xVelocity:Number;
		public var yVelocity:Number;
		public var _containerSpeed:Number;
		public var reloadSpeed:Number;
		private var _reloadCounter:uint;
		private var _levelBoundary:LevelBoundary;
		private var _particleContainer:ParticleContainer;
		private var _laserSound:Sound;
		
		public function HeroBulletContainer(levelBoundaryReference:LevelBoundary, particleContainerReference:ParticleContainer)
		{
			//Initialize vars--------------------//
			xVelocity = 0;
			yVelocity = 0;
			_containerSpeed = 1.5;
			reloadSpeed = 13;
			_reloadCounter = 0;
			_levelBoundary = levelBoundaryReference;
			_particleContainer = particleContainerReference;
			_laserSound = new LaserSound();
		}
		
		public function update():void{
			interpretController();
			updateBullets();
		}
		
		public function spawnBullet(heroXPosition:Number, heroYPosition:Number, heroRotation:Number):void {
			_reloadCounter ++;	
			if(_reloadCounter >= reloadSpeed){
				var heroBullet:HeroBullet = new HeroBullet(heroRotation - 90, heroXPosition - this.x, heroYPosition - this.y);
				heroBullet.rotation = heroRotation;
				addChild(heroBullet);
				_reloadCounter = 0;
				_laserSound.play();
			}
		}
		
		public function interpretController():void{
			this.x+=(_containerSpeed * xVelocity)*-1;
			this.y+=(_containerSpeed * yVelocity)*-1;
		}
		
		private function updateBullets():void 
		{
			for (var i:int = 0; i < this.numChildren; i++) {
					var currentBullet:HeroBullet = this.getChildAt(i) as HeroBullet;
					currentBullet.update();
					//Collisions--------------------------------------------------------//
					Collisions.bulletBoundaryCollision(currentBullet, this.localToGlobal(new Point(currentBullet.x, currentBullet.y)), this, _particleContainer, _levelBoundary);
			}
		}
	}
}