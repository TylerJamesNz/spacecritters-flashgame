package maths 
{
	/**
	 * ...
	 * @author Tyler Batchelor
	 */
	public class GameMaths 
	{
		
		public function GameMaths() 
		{
			
		}
		
		public static function radiansToDegrees(radianNumber:Number):Number
		{
			return (radianNumber * 180) / Math.PI;
		}
		
		public static function degreesToRadians(degreesNumber:Number):Number
		{
			return (degreesNumber * Math.PI) / 180;
		}
		
	}

}