package level 
{
	import flash.display.Stage;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Tyler Batchelor
	 */
	public class LevelBoundary extends LevelBoundarySWC 
	{
		public var xVelocity:Number;
		public var yVelocity:Number;
		
		public function LevelBoundary(stageWidthReference:uint, stageHeightReference:uint) 
		{
			this.x = (stageWidthReference / 2) - (this.width/2)
			this.y = (stageHeightReference / 2) - (this.height/2)
			xVelocity = 0
			yVelocity = 0;
		}
		
		public function update():void{
			movement();
		}
		
		private function movement():void 
		{
			this.x += xVelocity*-1;
			this.y += yVelocity*-1;
		}
		
	}

}