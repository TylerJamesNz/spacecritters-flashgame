package mvc
{
	import enemies.EnemyContainer;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	
	import hero.Hero;
	import hero.HeroBulletContainer;
	
	import level.LevelBoundary;
	import level.ParticleContainer;
	import level.StarField;
	
	import screens.GameScreen;
	import screens.HUD;
	import screens.MenuParticleContainer;
	
	/**
	 * ...
	 * @author Tyler Batchelor
	 */
	public class UIController
	{
		//World velocity is updated by the hero and applied to  all moving world objects.
		public var worldXVelocity:Number;
		public var worldYVelocity:Number;
		public var score:uint;
		//World speed is the top speed applied to all objects in the world
		public var worldSpeed:Number;
		public var _gameRunning:Boolean;
		private var _uiView:UIView;
		private var _gameScreen:GameScreen;
		private var _hero:Hero;
		private var _starField:StarField;
		private var _heroBulletContainer:HeroBulletContainer;
		private var _levelBoundary:LevelBoundary;
		private var _particleContainer:ParticleContainer;
		private var _pauseBuffer:uint;
		private var _pauseTimer:uint;
		private var _lastSoundPosition:Number;
		private var _pauseSound:Sound;
		private var _resumeSound:Sound;
		private var _enemyContainer:EnemyContainer;
		private var _levelingUp:Boolean;
		private var _hud:HUD;
		private var _menuParticleContainer:MenuParticleContainer;
		
		public function UIController(uiViewReference:UIView, gameScreenReference:GameScreen, heroReference:Hero, starFieldReference:StarField, heroBulletContainerReference:HeroBulletContainer, levelBoundaryReference:LevelBoundary, particleContainerReference:ParticleContainer, enemyContainerReference:EnemyContainer, hudReference:HUD, menuParticleContainerReference:MenuParticleContainer)
		{
			//Initialize vars -------------------------------------------------------------//
			//MVC
			_uiView = uiViewReference;
			
			//World
			worldXVelocity = 0;
			worldYVelocity = 0;
			_levelBoundary = levelBoundaryReference;
			worldSpeed = 0.5;
			_gameScreen = gameScreenReference;
			score = 0;
			_hud = hudReference;
			
			//Hero
			_hero = heroReference;
			_levelingUp = false;
			
			//Enemies
			_enemyContainer = enemyContainerReference;
			
			//Bullets
			_heroBulletContainer = heroBulletContainerReference;
			
			//Particles
			_particleContainer = particleContainerReference;
			_menuParticleContainer = menuParticleContainerReference;
			
			//Star Field
			_starField = starFieldReference;
			
			//Pause function
			_gameRunning = true;
			_pauseBuffer = 20;
			_pauseTimer = 0;
			_lastSoundPosition = 0;
			_pauseSound = new PauseSound();
			_resumeSound = new ResumeSound();
		}
		
		public function run(heroXVelocityReference:Number, heroYVelocityReference:Number):void
		{
			//Pause
			_pauseTimer++;
			if(_pauseTimer > _pauseBuffer){
				if (_uiView.keyPressed("p")) {
					if (_gameRunning) {
						_gameRunning = false;
						_lastSoundPosition = _gameScreen.soundChannel.position;
						_gameScreen.soundChannel.stop();
						_pauseSound.play();
					}else {
						_gameRunning = true;
						_gameScreen.soundChannel = _gameScreen.secondChanceSound.play(_lastSoundPosition, 100);
						_resumeSound.play();
					}
					_pauseTimer = 0;
				}
			}
			//Leveling
			_levelingUp = _enemyContainer.levelingUp;
			if (_levelingUp == true && _enemyContainer.numChildren < 1 || _hero.hitPoints < 1) {
				if (_gameRunning){ 
					_resumeSound.play();
					_menuParticleContainer.respawnParticles();
				}
				_gameScreen.soundChannel.soundTransform = new SoundTransform(0.5);
				_hud.gotoAndStop(3);
				_hud.backMenuButton.addEventListener(MouseEvent.MOUSE_DOWN,restartGame)
				_hud.waveTimer.text = String(_enemyContainer.score);
				_gameRunning = false;
				_hud.waveTimer.alpha = 1;
				
			}
			
			if (_gameRunning)
			{
				//Update Variables------------------------------------------------------------------//
				//World
				worldXVelocity = heroXVelocityReference;
				worldYVelocity = heroYVelocityReference;
				score = _enemyContainer.score;
				
				//Hero
				_hero.wKeyPressed = _uiView.keyPressed("w");
				_hero.aKeyPressed = _uiView.keyPressed("a");
				_hero.sKeyPressed = _uiView.keyPressed("s");
				_hero.dKeyPressed = _uiView.keyPressed("d");
				
				//Star Field
				_starField.xVelocity = worldXVelocity;
				_starField.yVelocity = worldYVelocity;
				_starField._starSpeed = worldSpeed;
				
				//Level
				_levelBoundary.xVelocity = worldXVelocity;
				_levelBoundary.yVelocity = worldYVelocity;
				
				//Enemies
				_enemyContainer.xVelocity = worldXVelocity;
				_enemyContainer.yVelocity = worldYVelocity;4
				_enemyContainer.x = _levelBoundary.x;
				_enemyContainer.y = _levelBoundary.y;
				
				//Bullets
				_heroBulletContainer.xVelocity = worldXVelocity
				_heroBulletContainer.yVelocity = worldYVelocity; 
				_heroBulletContainer._containerSpeed = worldSpeed;
				_heroBulletContainer.x = _levelBoundary.x;
				_heroBulletContainer.y = _levelBoundary.y;
				
				//Particles
				_particleContainer.xVelocity = worldXVelocity;
				_particleContainer.yVelocity = worldYVelocity;
				_particleContainer.x = _levelBoundary.x;
				_particleContainer.y = _levelBoundary.y;
				
				//Functions-------------------------------------------------------------------------//
				//Mouse input
				if (_uiView.mousePressed()) {
					_heroBulletContainer.spawnBullet(_hero.x,_hero.y, _hero.rotation);
				}
			}
		}
		
		private function restartGame(event:MouseEvent):void
		{
			_gameScreen.dispatchEvent(new Event("gameOver"));
			_gameScreen.soundChannel.stop();
		}
		
	}

}