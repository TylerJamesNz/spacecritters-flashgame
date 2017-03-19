package enemies 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import maths.GameMaths;
	/**
	 * ...
	 * @author Tyler Batchelor
	 */
	public class Enemy1 extends Enemy1SWC 
	{
		public var xVelocity:Number;
		public var yVelocity:Number;
		public var hitPoints:uint;
		public var color:uint;
		public var mass:uint;
		private var _boundarySize:Rectangle;
		private var _startPosition:uint;
		private var _initialSpeed:Number;
		private var _decelerationRate:Number;
		private var _acceleration:Number;
		private var _terminalVelocity:Number;
		
		public function Enemy1(boundarySize:Rectangle) 
		{
			//Initialize vars -----------------------------------------------------//
			_initialSpeed = 1.5;
			_terminalVelocity = 2;
			_decelerationRate = 0.95;
			_boundarySize = boundarySize;
			_startPosition = Math.round((Math.random() * 3) + 1);
			_acceleration = 0.01+ (Math.random()*0.01);
			xVelocity = (_initialSpeed * -1) + (Math.random() * (_initialSpeed * 2));
			yVelocity = (_initialSpeed * -1) + (Math.random() * (_initialSpeed * 2));
			hitPoints = 1;
			mass = 10;
			color = 0x00CC33;
			
			//Initialize base vars --------------------------------------------//
			placeStartPosition();
			this.cacheAsBitmap = true;
		}
		
		public function update(heroPosition:Point):void {
			//Update functions
			checkBounds();
			movement(heroPosition);
		
			//Update base vars-------------------------------------------------//
			this.x += xVelocity;
			this.y += yVelocity;
		}
		
		private function movement(heroPosition:Point):void 
		{
			followHero(heroPosition);
			rotateToHero(heroPosition);
		}
		
		private function rotateToHero(heroPosition:Point):void 
		{
			this.rotation=GameMaths.radiansToDegrees(Math.atan2(heroPosition.y - this.y, heroPosition.x - this.x))+90;
		}
		
		private function followHero(heroPosition:Point):void 
		{
			//Follow hero
			if (heroPosition.x > this.x + (this.width / 2)) {
					if(xVelocity < _terminalVelocity){
						xVelocity += _acceleration;
					}
			}
			if (heroPosition.x < this.x - (this.width / 2)) {
				if(xVelocity > (_terminalVelocity*-1)){
					xVelocity -= _acceleration;
				}
			}
			if (heroPosition.y > this.y + (this.height / 2)) {
				if(yVelocity < _terminalVelocity){
					yVelocity += _acceleration;
				}
			}
			if (heroPosition.y < this.y - (this.height / 2)) {
				if(yVelocity > (_terminalVelocity*-1)){
					yVelocity -= _acceleration;
				}
			}
		}
		
		private function checkBounds():void 
		{
			//Left Side
			if (this.x-(this.width/2)< _boundarySize.x) {
					xVelocity = Math.abs(xVelocity);
			}
			//Right Side
			if (this.x+(this.width/2) > _boundarySize.width) {
					xVelocity = Math.abs(xVelocity)*-1;
			}
			//Top
			if (this.y-(this.height/2) < _boundarySize.y) {
					yVelocity = Math.abs(yVelocity);
			}
			//Bottom
			if (this.y + (this.height/2) > _boundarySize.height) {
					yVelocity = Math.abs(yVelocity)*-1;
			}
		}
		
		private function placeStartPosition():void 
		{
			switch(_startPosition) {
				case 1:
					this.x = _boundarySize.x + 100;
					this.y = _boundarySize.y + 100;
					break;
				case 2:
					this.x = _boundarySize.x + 100;
					this.y = _boundarySize.height - 100;
					break;
				case 3:
					this.x = _boundarySize.width - 100;
					this.y = _boundarySize.y + 100;
					break;
				case 4:
					this.x = _boundarySize.width - 100;
					this.y = _boundarySize.height - 100;
					break;
			}
		}
		
	}
}