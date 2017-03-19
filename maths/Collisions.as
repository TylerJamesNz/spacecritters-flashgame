package maths 
{
	import enemies.EnemyContainer;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.media.SoundTransform;
	import hero.Hero;
	import hero.HeroBullet;
	import hero.HeroBulletContainer;
	import level.LevelBoundary;
	import level.ParticleContainer;
	import mvc.UIController;
	import screens.GameScreen;
	/**
	 * ...
	 * @author Tyler Batchelor
	 */
	public class Collisions 
	{
		private var _hero:Hero;
		private var _levelBoundary:LevelBoundary;
		private var _uiController:UIController;
		
		
		public function Collisions(stageReference:Stage, uiControllerReference:UIController, heroReference:Hero, levelBoundaryReference:LevelBoundary) 
		{
			_hero = heroReference;
			_levelBoundary = levelBoundaryReference;
			_uiController = uiControllerReference
		}
		
		public function update():void {
			heroLevelCollision();
		}
		
		private function heroLevelCollision():void 
		{
			if (_levelBoundary.x >_hero.x - (_hero.width / 2)) {
				_hero.xVelocity = Math.abs(_hero.xVelocity);
			}
			if (_levelBoundary.x + _levelBoundary.width < _hero.x + (_hero.width / 2)) {
				_hero.xVelocity = Math.abs(_hero.xVelocity)*-1
			}
			if (_levelBoundary.y >_hero.y - (_hero.height / 2)) {
				_hero.yVelocity = Math.abs(_hero.yVelocity);
			}
			if ( _levelBoundary.y + _levelBoundary.height < _hero.y + (_hero.height / 2)) {
				_hero.yVelocity = Math.abs(_hero.yVelocity)*-1;
			}
		}
		
		/////////////////////////////////////////////////Static Collisions Below//////////////////////////////////////////////////////
		
		public static function bulletBoundaryCollision(currentBullet:HeroBullet, globalBulletPosition:Point, heroBulletContainerReference:HeroBulletContainer, particleContainerReference:ParticleContainer, levelBoundaryReference:LevelBoundary):void {
			var bulletRemoved:Boolean = false;
		//top of the level
			if (globalBulletPosition.y < levelBoundaryReference.y && bulletRemoved == false) {
				particleContainerReference.generateExplosion(new Point(currentBullet.x, currentBullet.y), 10, Math.random() * 0xFFFFFF);
				heroBulletContainerReference.removeChild(currentBullet);
				currentBullet = null;
				bulletRemoved = true;
			}
		//Bottom of the level
			if (globalBulletPosition.y > levelBoundaryReference.y + levelBoundaryReference.height && bulletRemoved == false) {
				particleContainerReference.generateExplosion(new Point(currentBullet.x, currentBullet.y), 10, Math.random() * 0xFFFFFF);
				heroBulletContainerReference.removeChild(currentBullet);
				currentBullet = null;
				bulletRemoved = true;
			}
		//Left side level
			if (globalBulletPosition.x < levelBoundaryReference.x && bulletRemoved == false) {
				particleContainerReference.generateExplosion(new Point(currentBullet.x, currentBullet.y), 10, Math.random() * 0xFFFFFF);
				heroBulletContainerReference.removeChild(currentBullet);
				currentBullet = null;
				bulletRemoved = true;
			}
		//Right side
			if (globalBulletPosition.x > levelBoundaryReference.x + levelBoundaryReference.width && bulletRemoved == false) {
				particleContainerReference.generateExplosion(new Point(currentBullet.x, currentBullet.y), 10, Math.random() * 0xFFFFFF);
				heroBulletContainerReference.removeChild(currentBullet);
				currentBullet = null;
				bulletRemoved = true;
			}
		}
		
		public static function bulletEnemyCollision(projectileReference:MovieClip, enemyReference:MovieClip, projectileContainerReference:HeroBulletContainer, enemyContainerReference:EnemyContainer, particleContainerReference:ParticleContainer):uint {
			var scoreToReturn:uint = 0;
			if (projectileReference.hitTestObject(enemyReference.hitBox)) {
				if (enemyReference.hitPoints < 2) {	
					particleContainerReference.generateExplosion(new Point(enemyReference.x, enemyReference.y), enemyReference.mass, enemyReference.color, "enemy1");
					projectileContainerReference.removeChild(projectileReference);
					projectileReference = null;
					enemyContainerReference.removeChild(enemyReference);
					enemyReference = null;
					scoreToReturn += 120;
				}else{
					particleContainerReference.generateExplosion(new Point(enemyReference.x, enemyReference.y), 5, enemyReference.color);
					projectileContainerReference.removeChild(projectileReference);
					projectileReference = null;
					enemyReference.hitPoints --;
					scoreToReturn += 50;
				}
			}
			return scoreToReturn;
		}
		
		public static function heroEnemyCollision(heroReference:Hero, enemyReference:MovieClip, gameScreenReference:GameScreen, enemyContainerReference:EnemyContainer, particleContainerReference:ParticleContainer):void {
			if (heroReference.hitBox.hitTestObject(enemyReference.hitBox) && !heroReference.dead) {
					particleContainerReference.generateExplosion(new Point(enemyReference.x, enemyReference.y), enemyReference.mass*2, enemyReference.color, "enemy1");
					particleContainerReference.generateExplosion(new Point(enemyReference.x, enemyReference.y), enemyReference.mass*2, heroReference.color, "none");
					enemyContainerReference.removeChild(enemyReference);
					enemyReference = null;
					heroReference.active = false;
					heroReference.dead = true;
					gameScreenReference.soundChannel.soundTransform = new SoundTransform(0.3);
			}
		}
	}
}