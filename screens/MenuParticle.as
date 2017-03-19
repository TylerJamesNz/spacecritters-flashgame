package screens
{
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Tyler Batchelor
	 */
	public class MenuParticle {
		//Define position and velocity of vector 3d objects.
		private var _position:Vector3D;
		private var _velocity:Vector3D;
		private var _boundary:Rectangle;
		private var _color:uint;
		private var _initialVelocity:Number;
		private var _lifeCounter:Number;
		private var _lifeExpectancy:uint;
		
		public function MenuParticle(boundarySize:Rectangle) {
			//Initialize vars------------------------------------------------------------------------------//
			_initialVelocity = 3;
			_boundary = boundarySize;
			_position = new Vector3D(Math.random()*_boundary.width,Math.random()*_boundary.height);
			_velocity = new Vector3D((_initialVelocity * -1) + (Math.random() * (_initialVelocity * 2)), (_initialVelocity * -1) + (Math.random() * (_initialVelocity * 2)));
			_color = Math.random()*0xFFFFFF;
			_lifeCounter = 0;
			_lifeExpectancy = 200;
		}
		
		public function update():void {
			//Update functions-------------------------------------//
			checkBounds();
			//Update variables--------------------------------------//
			_position.x += _velocity.x;
			_position.y += _velocity.y;
			_lifeCounter ++;
		
		}
		
		private function checkBounds():void {
			
			if (_position.x < 0 || _position.x > _boundary.width)
			{
				_velocity.x *= -1;
				
			}
			if (_position.y < 0 || _position.y > _boundary.height)
			{
				_velocity.y *= -1;
			}
		
		}
		
		//Getters and Setters
		public function get color():uint {
			return _color;
		}
		
		public function get x():Number {
			return _position.x;
		}
		
		public function get y():Number {
			return _position.y;
		}
		
		 //returns true if the particle does not have a lot of 'energy' left, false otherwise
		public function remove():Boolean {
           if(_lifeCounter > _lifeExpectancy){
			return false;
		}else{
			return false;
		}
        }
	}

}