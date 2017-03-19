package level
{
	import flash.display.Bitmap;
	import flash.display.Stage;
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author Tyler Batchelor
	 */
	public class StarField extends StarFieldSWC 
	{
		public var xVelocity:Number ;
		public var yVelocity:Number ;
		public var _starSpeed:Number;
		private var _starDensity:uint;
		private var _starSize:Number;
		private var _stage:Stage
		private var _starArray:Array;
		
		public function StarField(stageReference:Stage) 
		{
			//Initialize vars-------------------------------//
			//World
			_stage = stageReference;
			
			//Stars
			_starDensity = 200;
			_starSize = 0.5 
			_starSpeed = 1.5;
			xVelocity = 0;
			yVelocity = 0;
			_starArray = [];
			generateStarField();
			
		}
		public function update() :void{
			interpretController();
		}
		
		private function generateStarField():void {
			for (var i:int = 0; i < _starDensity; i++ ) {
				var star:Bitmap = new Bitmap(new StarImage());
				var starSize:Number = 0.7 + (Math.random()*_starSize)
				addChild(star);
				star.x =  Math.random() * _stage.stageWidth;
				star.y = Math.random() * _stage.stageHeight;
				star.scaleX = starSize;
				star.scaleY = starSize;
				star.alpha = starSize / (_starSize + 0.7);
				star.filters = [new GlowFilter(0xFFFFFF)];
				_starArray.push(star);
			}
		}
		private function interpretController():void 
		{
			for (var i:int = 0; i < _starArray.length; i++ ) {
				var currentStar:Bitmap = _starArray[i];
				currentStar.x += (currentStar.scaleX * (_starSpeed * xVelocity))*-1;
				currentStar.y += (currentStar.scaleX * (_starSpeed * yVelocity))*-1;
				if (currentStar.x > _stage.stageWidth) {
						currentStar.x = 0;
				}
				if (currentStar.x < 0) {
						currentStar.x = stage.stageWidth;
				}
				if (currentStar.y > _stage.stageHeight) {
						currentStar.y = 0;
				}
				if (currentStar.y < 0) {
						currentStar.y = stage.stageHeight;
				}
			}
		}	
	}

}