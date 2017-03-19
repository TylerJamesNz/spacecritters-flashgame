package mvc
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Tyler Batchelor
	 */
	public class UIView
	{
		private var _wKeyPressed:Boolean;
		private var _aKeyPressed:Boolean;
		private var _sKeyPressed:Boolean;
		private var _dKeyPressed:Boolean;
		private var _pKeyPressed:Boolean;
		private var _spaceKeyPressed:Boolean;
		private var _mouseDown:Boolean;
		private var _stage:Stage;
		
		public function UIView(stageReference:Stage)
		{
			//Initialize Vars
			_stage = stageReference;
			
			//Key references
			_wKeyPressed = false;
			_aKeyPressed = false;
			_sKeyPressed = false;
			_dKeyPressed = false;
			_pKeyPressed = false;
			_mouseDown = false;
			_spaceKeyPressed = false;
			
			//Add Event Listeners
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			_stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			_stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		public function keyPressed(keyReference:String):Boolean
		{
			switch (keyReference)
			{
				case "w": 
					return _wKeyPressed;
					break;
				case "a": 
					return _aKeyPressed;
					break;
				case "s": 
					return _sKeyPressed;
					break;
				case "d": 
					return _dKeyPressed;
					break;
				case "p": 
					return _pKeyPressed;
					break;
				case "space": 
					return _spaceKeyPressed;
					break;
				default: 
					return false;
					break;
			}
		}
		
		public function mousePressed():Boolean
		{
			return _mouseDown;
		}
		
		private function keyDownHandler(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.W)
			{
				_wKeyPressed = true;
			}
			if (e.keyCode == Keyboard.A)
			{
				_aKeyPressed = true;
			}
			if (e.keyCode == Keyboard.S)
			{
				_sKeyPressed = true;
			}
			if (e.keyCode == Keyboard.D)
			{
				_dKeyPressed = true;
			}
			if (e.keyCode == Keyboard.P)
			{
				_pKeyPressed = true;
			}
		}
		
		private function keyUpHandler(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.W)
			{
				_wKeyPressed = false;
			}
			if (e.keyCode == Keyboard.A)
			{
				_aKeyPressed = false;
			}
			if (e.keyCode == Keyboard.S)
			{
				_sKeyPressed = false;
			}
			if (e.keyCode == Keyboard.D)
			{
				_dKeyPressed = false;
			}
			if (e.keyCode == Keyboard.P)
			{
				_pKeyPressed = false;
			}
		}
		
		private function mouseDownHandler(e:MouseEvent):void
		{
			_mouseDown = true;
		}
		
		private function mouseUpHandler(e:MouseEvent):void
		{
			_mouseDown = false;
		}
	}
}