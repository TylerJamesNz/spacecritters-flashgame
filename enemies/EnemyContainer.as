package enemies 
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import hero.Hero;
	import hero.HeroBulletContainer;
	import level.ParticleContainer;
	import maths.Collisions;
	import screens.GameScreen;
	/**
	 * ...
	 * @author Tyler Batchelor
	 */
	public class EnemyContainer extends EnemyContainerSWC 
	{
		public var xVelocity:Number;
		public var yVelocity:Number;
		public var waveCounter:uint;
		public var score:uint;
		public var levelingUp:Boolean;
		private var _currentWave:uint;
		private var _currentLevel:uint;
		private var _timeBetweenWaves:uint;
		private var _level1Waves:Array;
		private var _boundary:Rectangle;
		private var _heroBulletContainer:HeroBulletContainer;
		private var _particleContainer:ParticleContainer;
		private var _hero:Hero;
		private var _gameScreen:GameScreen;
		
		public function EnemyContainer(startPosition:Point, boundary:Rectangle, heroBulletContainerReference:HeroBulletContainer, particleContainerReference:ParticleContainer, heroReference:Hero, gameScreenReference:GameScreen) 
		{
			//Initialize vars---------------------------------------------------------------------------//
			xVelocity = 0;
			yVelocity = 0;
			score = 0;
			waveCounter = 0;
			levelingUp = false;
			_hero = heroReference;
			_gameScreen = gameScreenReference;
			_currentWave = 0;
			_currentLevel = 1;
			_timeBetweenWaves = 500;
			_boundary = boundary;
			_heroBulletContainer = heroBulletContainerReference;
			_particleContainer = particleContainerReference;
			
			//Initialize base properties ---------------------------------------------------------//
			this.x = startPosition.x;
			this.y = startPosition.y;
			
			//Initialize waves of enemies--------------------------------------------------------//
			_level1Waves = [
							[1,	1,	1,	0,	0,	0,	0,	0,	0,	0,	0],
							[1,	1,	1,	1,	1,	0,	0,	0,	0,	0,	0],
							[1,	1,	1,	2,	1,	1,	0,	0,	0,	0,	0],
							[1,	1,	1,	1,	2,	1,	0,	0,	0,	0,	0],
							[1,	1,	1,	1,	2,	2,	0,	0,	0,	0,	0],
							[1,	1,	1,	3,	1,	2,	2,	0,	0,	0,	0],
							[1,	1,	1,	1,	1,	1,	1,	1,	0,	0,	0],
							[1,	1,	1,	1,	2,	2,	2,	0,	0,	0,	0],
							[1,	1,	1,	1,	1,	1,	1,	1,	1,	0,	0],
							[1,	1,	1,	1,	1,	2,	2,	3,	3,	0,	0],
							[2,	2,	2,	2,	2,	2,	2,	2,	2,	1,	1],
							[2,	2,	3,	3,	2,	3,	2,	3,	2,	1,	1],
							[2,	1,	3,	3,	3,	3,	2,	3,	2,	3,	1],
							[1,	1,	1,	1,	1,	1,	3,	3,	3,	3,	3],
							[2,	2,	2,	2,	2,	2,	2,	2,	2,	2,	2],
							[1,	2,	3,	1,	2,	3,	1,	2,	3,	1,	2],
							[0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0] // Final wave marks level up do not fill with enemies
						];	
		}
		
		public function update(heroPosition:Point):void {
		//Update functions --------------------------------------------------------------------------//
		updateEnemies(this.globalToLocal(heroPosition));
		
		if (waveCounter % _timeBetweenWaves == 0) {
			//if time between waves has elapsed spawn next wave
			if(_currentWave < _level1Waves.length){
				spawnEnemies();
				trace(_currentWave);
				_currentWave++;
				_timeBetweenWaves -= 5;
			}
			if (_currentWave == _level1Waves.length) {
				levelingUp = true;
			}
		}
		
		//Update variables ---------------------------------------------------------------------------//
		waveCounter++;
		
		//Update base properties------------------------------------------------------------------//
		 this.x += xVelocity * -1;
		 this.y += yVelocity * -1;
		}
		
		private function updateEnemies(heroPosition:Point):void {
			for (var j:int = 0; j < this.numChildren; j++) {
				var currentEnemy:MovieClip = this.getChildAt(j) as MovieClip;
				currentEnemy.update(heroPosition);
				
				Collisions.heroEnemyCollision(_hero, currentEnemy, _gameScreen, this, _particleContainer);
					
				for (var k:int = 0; k < _heroBulletContainer.numChildren; k++) {
					var currentBullet:MovieClip = _heroBulletContainer.getChildAt(k) as MovieClip;
					score += (Collisions.bulletEnemyCollision(currentBullet, currentEnemy, _heroBulletContainer, this, _particleContainer));
				}
			}
		}
		
		private function spawnEnemies():void 
		{
			switch(_currentLevel) {
				case 1:
					level1Spawns();
					break;
				case 2:
					level2Spawns();
					break;
				case 3:
					level3Spawns();
					break;
			}
		}
		
		private function level1Spawns():void 
		{	
			for (var i:int = 0; i < _level1Waves[_currentWave].length; i++) {
				switch(_level1Waves[_currentWave][i]) {
					case 1:
						addChild(new Enemy1(_boundary));
						break;
					case 2:
						addChild(new Enemy2(_boundary));
						break;
					case 3:
						addChild(new Enemy3(_boundary));
						break;
				}
			}
		}
		
		private function level2Spawns():void 
		{
			
		}
		
		private function level3Spawns():void 
		{
			
		}	
	}

}