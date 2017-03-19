package screens 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Tyler Batchelor
	 */
	public class MenuParticleContainer extends MenuParticleContainerSWC 
	{
		private var _width:int;
		private var _height:int;
		private var _bitmap:Bitmap;
		private var _bitmapData:BitmapData;
		private var _clearRectangle:Rectangle;
		private var _currentTime:int = 0;
		private var _particleVector:Vector.<MenuParticle>
		private var _numParticles:uint;
		private var _blurFade:BlurFilter;
		private var _colorFade:ColorTransform;
		private var _stageReference:Rectangle;
		private var _gameStarted:Boolean;
		
		public function MenuParticleContainer(stageRectange:Rectangle) 
		{
			//Initialize vars------------------------------------------------//
			_gameStarted = false;
			_stageReference = stageRectange;
			_width = _stageReference.width;
			_height = _stageReference.height;
			_numParticles = 300;
			_bitmapData = new BitmapData(_width, _height, false, 0);
			_bitmap = new Bitmap(_bitmapData);
			_particleVector = new Vector.<MenuParticle>
			addChild(_bitmap);
			//Blank bitmap to overwrite bitmap data;
			_clearRectangle = new Rectangle(0, 0, _width, _height);
			//define the blur and color transformers
			_blurFade = new BlurFilter(2, 2, 1);
			_colorFade = new ColorTransform(1, 1, 1, 3);
			
			//Add event listeners ----------------------------------------------//
			addEventListener(Event.ENTER_FRAME, programUpdate);
			addEventListener("gameStarted", gameStarted);
			
			respawnParticles();
		}
		
		private function gameStarted(e:Event):void 
		{
			_gameStarted = true;
		}
		
		private function programUpdate(e:Event):void 
		{
			
			//Push particles in every frame
			
			//A temporary variable was used here because otherwise the object would need to be read 3 times from the Vector - much slower;
			var particle:MenuParticle;
			
			//Lock the bitmap and clear the pixels before drawing next frame;
			_bitmapData.lock();
			//_bitmapData.fillRect(_clearRectangle, 0);
			
			//apply the BlurFilter which blurs the colors together and fades the particles out
			_bitmapData.applyFilter(_bitmapData, _bitmapData.rect, new Point(0, 0), _blurFade);
			//apply the color transformation to give the particle trails a blue tint
			_bitmapData.colorTransform(_bitmapData.rect, _colorFade);
			
			//Loop through every particle;
			for (var i:int = 0; i < _particleVector.length; i++ ) {
				particle = _particleVector[i];
				if (particle.remove()) {
						_particleVector.splice(i,1);
						i--;
						particle = null;
					}else{
						_bitmapData.setPixel(particle.x, particle.y, particle.color);
						_bitmapData.setPixel(particle.x, particle.y + 1, particle.color);
						_bitmapData.setPixel(particle.x, particle.y - 1, particle.color);
						_bitmapData.setPixel(particle.x + 1, particle.y, particle.color);
						_bitmapData.setPixel(particle.x, particle.y, particle.color);
						particle.update();
				}
				if (_gameStarted) {
					_particleVector.splice(i,1);
					i--;
					particle = null;
				}
			}
			//update the bitmap
			_bitmapData.unlock();
		}
		
		public function respawnParticles():void
		{
			_gameStarted = false;
			for (var i:int = 0; i < _numParticles; i++ ){
				_particleVector.push(new MenuParticle(new Rectangle(_stageReference.x,_stageReference.y,_stageReference.width,_stageReference.height)));
			}
		}
		
	}

}