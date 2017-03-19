package level 
{
	import flash.display.Bitmap;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Tyler Batchelor
	 */
	public class Particle extends Bitmap
	{
		private var _xVelocity:Number;
		private var _yVelocity:Number;
		private var _deceleration:Number;
		private var _boundarySize:Rectangle;
		private var _initialSpeed:Number;
		
		
		public function Particle(startPosition:Point, boundarySize:Rectangle, particleColor:uint) 
		{
			// Initialize vars-----------------------------------------//
			_initialSpeed = 8;
			_xVelocity = ((_initialSpeed)*-1) +(Math.random() * (_initialSpeed*2));
			_yVelocity = ((_initialSpeed)*-1) +(Math.random() * (_initialSpeed*2));
			_deceleration = 0.97;
			_boundarySize = boundarySize;
			
			//Initialize base properties-----------------------//
			this.x = startPosition.x;
			this.y = startPosition.y;
			this.bitmapData = new ParticleImage();
			this.filters = [new GlowFilter(particleColor)];
			setColor(particleColor);
		}
		
		public function update():void {
			//Update functions---------------------------------//
			checkBounds();
			
			//Update base properties------------------------//
			this.x += _xVelocity;
			this.y += _yVelocity;
			this._xVelocity *= _deceleration;
			this._yVelocity *= _deceleration;
		}
		
		private function checkBounds():void 
		{
			//Left Side
			if (this.x < _boundarySize.x) {
					_xVelocity = Math.abs(_xVelocity);
			}
			//Right Side
			if (this.x > _boundarySize.width) {
					_xVelocity = Math.abs(_xVelocity)*-1;
			}
			//Top
			if (this.y < _boundarySize.y) {
					_yVelocity = Math.abs(_yVelocity);
			}
			//Bottom
			if (this.y > _boundarySize.height) {
					_yVelocity = Math.abs(_yVelocity)*-1;
			}
		}
		
		private function setColor(color:uint):void {
			this.bitmapData.lock();
			for (var i:int = 0; i < this.width; i++) {
					for (var j:int = 0; j < this.height; j++) {
						this.bitmapData.setPixel(i, j, color);
					}
			}
			this.bitmapData.unlock();
		}
		
		 //returns true if the particle does not have a lot of 'energy' left, false otherwise
		public function remove():Boolean {
			 if(Math.abs(_xVelocity) + Math.abs(_yVelocity) < 0.4){
				return true;
			}else{
				return false;
			}
		}
		
	}

}