package screens 
{
	import enemies.EnemyContainer;
	
	import hero.Hero;
	/**
	 * ...
	 * @author Tyler Batchelor
	 */
	public class HUD extends HUDSWC 
	{
		private var _enemyContainer:EnemyContainer;
		private var _scoreReference:uint;
		private var _scoreIncreased:Boolean;
		private var _scoreAnimationTimer:Number;
		private var _hero:Hero;
	
		
		public function HUD(enemyContainerReference:EnemyContainer, heroReference:Hero) 
		{
			//Initialize vars---------------------------------------------------------------------//
				_enemyContainer = enemyContainerReference;
				_scoreReference = 0;
				_scoreIncreased = false;
				_scoreAnimationTimer = 0;
				_hero = heroReference;
				
				
			//Initialize base vars ------------------------------------------------------------//
				this.waveTimer.text = String(_enemyContainer.waveCounter);
		}
		
		public function update():void {
			//Update funtions----------------------------------------------------------------//
			updateScoreCounter();
			checkScoreIncrease();
			updateLifeDisplay();
			scoreAnimation();
			if (_scoreIncreased == true) {
				_scoreAnimationTimer = 0;
			}
			
			//Update vars--------------------------------------------------------------------//
			_scoreReference = _enemyContainer.score;
			_scoreAnimationTimer++;
		}
		
		private function updateLifeDisplay():void 
		{
			this.lifeDisplay.gotoAndStop(_hero.hitPoints + 1);
		}
		
		private function scoreAnimation():void 
		{
			if (_scoreAnimationTimer < 5) {
				this.waveTimer.alpha = 1;
				this.waveTimer.rotation = -2 + (Math.random()*4);
			}else {
				this.waveTimer.alpha = 0.5;	
				this.waveTimer.rotation = 0;
			}
		}
	
		private function checkScoreIncrease():void 
		{
			if (_scoreReference < _enemyContainer.score) {
				_scoreIncreased = true;
			}else {
				_scoreIncreased = false;
			}
		}
		
		private function updateScoreCounter():void 
		{
			if (_enemyContainer.score == 0) {
				this.waveTimer.text = "000"
			}else {
				this.waveTimer.text = String(_enemyContainer.score);
			}
		}
		
	}

}