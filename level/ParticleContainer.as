package level 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	/**
	 * ...
	 * @author Tyler Batchelor
	 */
	public class ParticleContainer extends ParticleContainerSWC 
	{
		public var xVelocity:Number;
		public var yVelocity:Number;
		private var _particleVector:Vector.<Particle>
		private var _boundarySize:Rectangle;
		private var _ricochetSound:Sound;
		private var _enemy1Sound:Sound;
		private var _enemy2Sound:Sound;
		 
		
		public function ParticleContainer(startPosition:Point, boundarySize:Rectangle) 
		{
			//Initialize vars-------------------------------------------------//
			xVelocity = 0;
			yVelocity = 0;
			_particleVector = new Vector.<Particle>
			_boundarySize = boundarySize;
			_ricochetSound = new RicochetSound();
			_enemy1Sound = new Enemy1Sound();
			_enemy2Sound = new Enemy2Sound();
			
			//Initialize base properties ------------------------------//
			this.x = startPosition.x;
			this.y = startPosition.y
		}
		
		public function update():void {
			//Update functions------------------------------------------//
			updateParticles();
			
			//Update base properties---------------------------------//
			this.x += xVelocity * -1;
			this.y += yVelocity * -1;
		}
		
		public function generateExplosion(startPosition:Point, numParticles:uint, explosionColor:uint = 0xFFFFFF, particleSound:String = "ricochet"):void {
			for (var i:int = 0; i < numParticles; i++) {
				var particle:Particle = new Particle(startPosition, _boundarySize, explosionColor);
				_particleVector.push(particle);
				addChild(particle);
			}
			switch(particleSound) {
				case "ricochet": 
					_ricochetSound.play();
					break;
				case "enemy1":
					_enemy1Sound.play();
					break;
				case "enemy2":
					_enemy2Sound.play();
					break;
				case "none":
					//none
					break;
			}
		}
		
		private function updateParticles():void {
			for (var j:int; j < _particleVector.length; j++) {
				var particle:Particle = _particleVector[j];
				
				if (particle.remove()) {
					removeChild(particle);
					_particleVector.splice(j,1);
					j--;
					particle = null;
				}else{
					particle.update();
				}
			}
		}
		
	}

}