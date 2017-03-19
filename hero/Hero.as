package hero 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	import maths.GameMaths
	import screens.GameScreen;
	/**
	 * ...
	 * @author Tyler Batchelor
	 */
	public class Hero extends HeroSWC 
	{
		public var active:Boolean;
		public var hitPoints:Number;
		public var wKeyPressed:Boolean;
		public var aKeyPressed:Boolean;
		public var sKeyPressed:Boolean;
		public var dKeyPressed:Boolean;
		public var accelerationRate:Number;
		public var decelerationRate:Number;
		public var xVelocity:Number;
		public var yVelocity:Number;
		public var dead:Boolean;
		public var color:uint;
		private var _stage:Stage;
		private  var _flashOn:Boolean;
		private var _respawnTimer:Timer;
		private var _gameScreen:GameScreen;
		private var _respawnEnd:Sound;
		private var _respawnBegin:Sound;
		
		
		public function Hero(stageReference:Stage, gameScreenReference:GameScreen) 
		{
			//Initialize vars ----------------------------------------------------------------------------------//
			//World
			_stage = stageReference;
			_gameScreen = gameScreenReference;
			
			//Key references
			wKeyPressed = false;
			aKeyPressed = false;
			sKeyPressed = false;
			dKeyPressed = false;
			
			//Hero
			this.x = _stage.stageWidth / 2;
			this.y = _stage.stageHeight / 2;
			active = true;
			dead = false;
			hitPoints = 5;
			color = 0x99E6FF;
			accelerationRate = 0.2;
			decelerationRate = 0.95;
			_flashOn = true;
			xVelocity = 0;
			yVelocity = 0;
			_respawnTimer = new Timer(2500, 1);
			_respawnBegin = new RespawnBegin();
			_respawnEnd = new RespawnEnd();
		}
		
		public function update():void {
			trackLives();
			interpretRotation();
			interpretKeys();
			applyForces();
			updateVisualEffects();
		}	
		
		private function trackLives():void 
		{
			if (!active) {
				_respawnTimer.addEventListener(TimerEvent.TIMER, respawn);
				_respawnTimer.start();
				active = true;
				dead = true;
				hitPoints --;
				_respawnBegin.play();
			}
		}
		
		private function respawn(e:TimerEvent):void 
		{
			_respawnTimer.removeEventListener(TimerEvent.TIMER, respawn);
			_gameScreen.soundChannel.soundTransform = new SoundTransform(1);
			_respawnEnd.play();
			dead = false;
		}
		
		private function updateVisualEffects():void 
		{
			if (dead) {
				if (_flashOn) {
					this.alpha = 1;
				}else {
					this.alpha = 0.3;
				}
			}else {
				this.alpha = 1;
			}
			if (_flashOn == true) {
				_flashOn = false;
			}else {
				_flashOn = true;
			}
		}
		
		private function interpretRotation():void 
		{
			var rotationRadians:Number = Math.atan2(_stage.mouseY - this.y, _stage.mouseX  - this.x);
			var rotationDegrees:Number = GameMaths.radiansToDegrees(rotationRadians) + 90;
			this.rotation = rotationDegrees;
		}
		
		private function interpretKeys():void
		{
			if (wKeyPressed)
			{
				yVelocity -= accelerationRate;
			}
			if (aKeyPressed)
			{
				xVelocity -= accelerationRate;
			}
			if (sKeyPressed)
			{
				yVelocity += accelerationRate;
			}
			if (dKeyPressed)
			{
				xVelocity += accelerationRate;
			}
		}
		
		private function applyForces():void 
		{
			xVelocity *= decelerationRate;
			yVelocity *= decelerationRate;
		}
	}

}