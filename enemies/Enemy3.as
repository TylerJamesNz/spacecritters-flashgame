package enemies 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import maths.GameMaths;
	/**
	 * ...
	 * @author Tyler Batchelor
	 */
	public class Enemy3 extends Enemy3SWC 
	{
		public var xVelocity:Number;
		public var yVelocity:Number;
		public var hitPoints:uint;
		public var mass:uint;
		public var color:uint;
		private var _boundarySize:Rectangle;
		private var _startPosition:uint;
		private var _initialSpeed:Number;
		private var _decelerationRate:Number;
		private var _acceleration:Number;
		private var _terminalVelocity:Number;
		
		public function Enemy3(boundarySize:Rectangle) 
		{
			//Initialize vars -----------------------------------------------------//
			_initialSpeed = 3;
			_terminalVelocity = 1;
			_decelerationRate = 0.95;
			_boundarySize = boundarySize;
			_startPosition = Math.round((Math.random() * 3) + 1);
			_acceleration = 0.01+ (Math.random()*0.02);
			calculateDirection(); 
			hitPoints = 2;
			mass = 15;
			color = 0xFEFF99;
			
			//Initialize base vars --------------------------------------------//
			placeStartPosition();
			this.cacheAsBitmap = true;
		}
		
		private function calculateDirection():void 
		{
			if(Math.random() * 2 > 1){
				xVelocity = _initialSpeed + (Math.random() * 0.5);
			}else {
				xVelocity = (_initialSpeed + (Math.random() * 0.5)) * -1;
			}
			if(Math.random() * 2 > 1){
				yVelocity = _initialSpeed + (Math.random() * 0.5);
			}else {
				yVelocity = (_initialSpeed + (Math.random() * 0.5)) * -1;
			}
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
			rotateToHero(heroPosition);
		}
		
		private function rotateToHero(heroPosition:Point):void 
		{
			this.rotation++;
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