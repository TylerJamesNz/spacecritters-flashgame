package screens
{
	import enemies.EnemyContainer;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import hero.Hero;
	import hero.HeroBulletContainer;
	
	import level.LevelBoundary;
	import level.ParticleContainer;
	import level.StarField;
	
	import maths.Collisions;
	
	import mvc.UIController;
	import mvc.UIView;
	
	/**
	 * ...
	 * @author Tyler Batchelor
	 */
	public class GameScreen extends GameScreenSWC
	{
		public var secondChanceSound:Sound;
		public var soundChannel:SoundChannel;
		public var score:uint;
		private var _starField:StarField;
		private var _hero:Hero;
		private var _uiView:UIView;
		private var _uiController:UIController;
		private var _colorOverlay:ColorOverlay;
		private var _heroBulletContainer:HeroBulletContainer;
		private var _levelBoundary:LevelBoundary;
		private var _collisions:Collisions;
		private var _particleContainer:ParticleContainer;
		private var _enemyContainer:EnemyContainer;
		private var _hud:HUD;
		private var _main:Main;
		private var _menuParticleContainer:MenuParticleContainer;
		
		public function GameScreen()
		{
			//Initialize game function deals with initialization
		}
		
		public function initializeGame(uiViewReference:UIView, mainReference:Main, menuParticleContainerReference:MenuParticleContainer):void
		{
			//Initialize vars ----------------------------------------------------------------------------------//
			//World
			_levelBoundary = new LevelBoundary(stage.stageWidth, stage.stageHeight);
			score = 0;
			addChild(_levelBoundary);
			stage.stageFocusRect = false;
			_main = mainReference;
			
			//Star Field
			_starField = new StarField(stage);
			addChild(_starField);
			_colorOverlay = new(ColorOverlay);
			addChild(_colorOverlay);
			
			//Particles
			_particleContainer = new ParticleContainer(new Point(_levelBoundary.x, _levelBoundary.y), new Rectangle(0,0,_levelBoundary.width,_levelBoundary.height));
			_menuParticleContainer = menuParticleContainerReference;
			addChild(_particleContainer);
			
			//Bullets
			_heroBulletContainer = new HeroBulletContainer(_levelBoundary, _particleContainer);
			addChild(_heroBulletContainer);
			
			//Hero
			_hero = new Hero(stage, this);
			addChild(_hero);
			
			//Enemies
			_enemyContainer = new EnemyContainer(new Point(_levelBoundary.x, _levelBoundary.y), new Rectangle(0,0,_levelBoundary.width,_levelBoundary.height), _heroBulletContainer, _particleContainer, _hero, this);
			addChild(_enemyContainer);
			
			//HUD
			_hud = new HUD(_enemyContainer, _hero);
			addChild(_hud);
			
			//mvc
			_uiView = uiViewReference;
			_uiController = new UIController(_uiView, this, _hero, _starField, _heroBulletContainer, _levelBoundary, _particleContainer, _enemyContainer, _hud, _menuParticleContainer);
			
			//Collisions
			_collisions = new Collisions(stage, _uiController, _hero, _levelBoundary);
			
			//Sound
			secondChanceSound = new SecondChanceSound();
			soundChannel = new SoundChannel();
			soundChannel = secondChanceSound.play(0,100);
			
			
			//Add Event Listeners ------------------------------------------------------------------------//
			addEventListener(Event.ENTER_FRAME, gameUpdate);
			addEventListener("gameOver", gameOver);
			
		}
		
		private function gameUpdate(e:Event):void
		{
			_uiController.run(_hero.xVelocity, _hero.yVelocity);
			if(_uiController._gameRunning){
				_hero.update();
				_heroBulletContainer.update();
				_starField.update();
				_levelBoundary.update();
				_collisions.update();
				_particleContainer.update();
				_enemyContainer.update(new Point(_hero.x, _hero.y));
				_hud.update();
			}
		}
		
		private function gameOver(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, gameUpdate);
			_main.dispatchEvent(new Event("gameOver"));
		}
	}

}