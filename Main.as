package
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import mvc.UIView;
	import screens.GameScreen;
	import screens.InstructionsScreen;
	import screens.MainMenuScreen;
	import screens.MenuParticleContainer;
	import screens.SettingsScreen;
	
	[SWF(width='800',height='500',backgroundColor='#000000',frameRate='60')]
	
	public class Main extends MovieClip
	{
		//Create all vars
		private var _currentScreen:MovieClip;
		private var _mainMenuScreen:MainMenuScreen;
		private var _instructionsScreen:InstructionsScreen;
		private var _settingsScreen:SettingsScreen;
		private var _gameScreen:GameScreen;
		private var _menuParticleContainer:MenuParticleContainer;
		private var _uiView:UIView;
		private var _buttonBeep:Sound;
		
		public function Main()
		{
			//Initialize all objects ----------------------------------------------------------------------------------------//
			//Screens
			_mainMenuScreen = new MainMenuScreen();
			_settingsScreen = new SettingsScreen();
			_instructionsScreen = new InstructionsScreen();
			_gameScreen = new GameScreen();
			_menuParticleContainer = new MenuParticleContainer(new Rectangle(stage.x, stage.y, stage.stageWidth, stage.stageHeight));
			_currentScreen = _mainMenuScreen;
			//add all the listeners for the screen buttons
			addRemoveButtonListeners("add");
			addEventListener("gameOver", gameOver);
			
			//MVC
			_uiView = new UIView(stage);
			
			//Sound
			_buttonBeep = new ButtonBeep();
			
			//Add Relevant Objects ----------------------------------------------------------------------------------------//
			//Screens
			addChild(_menuParticleContainer);
			addChild(_currentScreen);
		}
		private function swapScreens(_newScreen:MovieClip):void
		{
			removeChild(_currentScreen);
			_currentScreen = _newScreen
			addChild(_currentScreen);
			if (_currentScreen == _gameScreen)
			{
				addRemoveButtonListeners("remove");
				_gameScreen.initializeGame(_uiView, this, _menuParticleContainer);
			}
		}
		
		private function gameOver(event:Event):void
		{
			trace("arrived");
			swapScreens(_mainMenuScreen);
			_gameScreen = null;
			addRemoveButtonListeners("add");
			_gameScreen = new GameScreen();
			
		}
		
		private function addRemoveButtonListeners(addOrRemove:String = "add"):void {
			if (addOrRemove == "add") {
				//Main menu listeners
				_mainMenuScreen.gameScreenButton.addEventListener(MouseEvent.CLICK, playGame);
				_mainMenuScreen.gameScreenButton.addEventListener(MouseEvent.MOUSE_OVER, playGameRollOver);
				_mainMenuScreen.gameScreenButton.addEventListener(MouseEvent.MOUSE_OUT, playGameRollOff);
				_mainMenuScreen.settingsScreenButton.addEventListener(MouseEvent.CLICK, playSettings);
				_mainMenuScreen.settingsScreenButton.addEventListener(MouseEvent.MOUSE_OVER, playSettingsRollOver);
				_mainMenuScreen.settingsScreenButton.addEventListener(MouseEvent.MOUSE_OUT, playSettingsRollOff);
				_mainMenuScreen.instructionsScreenButton.addEventListener(MouseEvent.CLICK, playInstructions);
				_mainMenuScreen.instructionsScreenButton.addEventListener(MouseEvent.MOUSE_OVER, playInstructionsRollOver);
				_mainMenuScreen.instructionsScreenButton.addEventListener(MouseEvent.MOUSE_OUT, playInstructionsRollOff);
				//Instructions listeners
				_instructionsScreen.backMenuButton.addEventListener(MouseEvent.CLICK, instructionsBack);
				_instructionsScreen.backMenuButton.addEventListener(MouseEvent.MOUSE_OVER, instructionsBackRollOver);
				_instructionsScreen.backMenuButton.addEventListener(MouseEvent.MOUSE_OUT, instructionsBackRollOff);
				//Settings listeners
				_settingsScreen.backMenuButton.addEventListener(MouseEvent.CLICK, settingsBack);
				_settingsScreen.backMenuButton.addEventListener(MouseEvent.MOUSE_OVER, settingsBackRollOver);
				_settingsScreen.backMenuButton.addEventListener(MouseEvent.MOUSE_OUT, settingsBackRollOff);
			}else if(addOrRemove == "remove") {
				//Main menu listeners
				_mainMenuScreen.gameScreenButton.removeEventListener(MouseEvent.CLICK, playGame);
				_mainMenuScreen.gameScreenButton.removeEventListener(MouseEvent.MOUSE_OVER, playGameRollOver);
				_mainMenuScreen.gameScreenButton.removeEventListener(MouseEvent.MOUSE_OUT, playGameRollOff);
				_mainMenuScreen.settingsScreenButton.removeEventListener(MouseEvent.CLICK, playSettings);
				_mainMenuScreen.settingsScreenButton.removeEventListener(MouseEvent.MOUSE_OVER, playSettingsRollOver);
				_mainMenuScreen.settingsScreenButton.removeEventListener(MouseEvent.MOUSE_OUT, playSettingsRollOff);
				_mainMenuScreen.instructionsScreenButton.removeEventListener(MouseEvent.CLICK, playInstructions);
				_mainMenuScreen.instructionsScreenButton.removeEventListener(MouseEvent.MOUSE_OVER, playInstructionsRollOver);
				_mainMenuScreen.instructionsScreenButton.removeEventListener(MouseEvent.MOUSE_OUT, playInstructionsRollOff);
				//Instructions listeners
				_instructionsScreen.backMenuButton.removeEventListener(MouseEvent.CLICK, instructionsBack);
				_instructionsScreen.backMenuButton.removeEventListener(MouseEvent.MOUSE_OVER, instructionsBackRollOver);
				_instructionsScreen.backMenuButton.removeEventListener(MouseEvent.MOUSE_OUT, instructionsBackRollOff);
				//Settings listeners
				_settingsScreen.backMenuButton.removeEventListener(MouseEvent.CLICK, settingsBack);
				_settingsScreen.backMenuButton.removeEventListener(MouseEvent.MOUSE_OVER, settingsBackRollOver);
				_settingsScreen.backMenuButton.removeEventListener(MouseEvent.MOUSE_OUT, settingsBackRollOff);
			}
		}
		
		private function settingsBackRollOff(e:MouseEvent):void 
		{
			_settingsScreen.backMenuButton.gotoAndStop(1);
		}
		
		private function settingsBackRollOver(e:MouseEvent):void 
		{
			_settingsScreen.backMenuButton.gotoAndStop(2);
			_buttonBeep.play();
		}
		
		private function settingsBack(e:MouseEvent):void 
		{
			swapScreens(_mainMenuScreen);
		}
		
		private function instructionsBackRollOff(e:MouseEvent):void 
		{
			_instructionsScreen.backMenuButton.gotoAndStop(1);
		}
		
		private function instructionsBackRollOver(e:MouseEvent):void 
		{
			_instructionsScreen.backMenuButton.gotoAndStop(2);
			_buttonBeep.play();
		}
		
		private function instructionsBack(e:MouseEvent):void 
		{
			swapScreens(_mainMenuScreen);
		}
		
		private function playInstructionsRollOff(e:MouseEvent):void 
		{
			_mainMenuScreen.instructionsScreenButton.gotoAndStop(1);
		}
		
		private function playInstructionsRollOver(e:MouseEvent):void 
		{
			_mainMenuScreen.instructionsScreenButton.gotoAndStop(2);
			_buttonBeep.play();
		}
		
		private function playInstructions(e:MouseEvent):void 
		{
			swapScreens(_instructionsScreen)
		}
		
		private function playSettingsRollOff(e:MouseEvent):void 
		{
			_mainMenuScreen.settingsScreenButton.gotoAndStop(1);
		}
		
		private function playSettingsRollOver(e:MouseEvent):void 
		{
			_mainMenuScreen.settingsScreenButton.gotoAndStop(2);
			_buttonBeep.play();
		}
		
		private function playSettings(e:MouseEvent):void 
		{
			swapScreens(_settingsScreen);
		}
		
		private function playGameRollOff(e:MouseEvent):void 
		{
			_mainMenuScreen.gameScreenButton.gotoAndStop(1);
		}
		
		private function playGameRollOver(e:MouseEvent):void 
		{
			_mainMenuScreen.gameScreenButton.gotoAndStop(2);
			_buttonBeep.play();
		}
		
		private function playGame(e:MouseEvent):void 
		{
			swapScreens(_gameScreen)
			_menuParticleContainer.dispatchEvent(new Event("gameStarted"));
		}
	}
}
