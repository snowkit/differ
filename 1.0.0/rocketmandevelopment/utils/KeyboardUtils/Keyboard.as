package com.rocketmandevelopment.utils.KeyboardUtils {
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	public class Keyboard {
		public static const A:Key = new Key("a", 65);
		public static const B:Key = new Key("b", 66);
		public static const BACKSLASH:Key = new Key("\\", 220);
		public static const BACKSPACE:Key = new Key("Backspace", 8);
		public static const C:Key = new Key("c", 67);
		public static const CAPS:Key = new Key("Caps", 20);
		public static const COMMA:Key = new Key(",", 188);
		public static const COMMAND:Key = new Key("Command", 0);
		public static const CONTROL:Key = new Key("Control", 17);
		public static const D:Key = new Key("d", 68);
		public static const DASH:Key = new Key("-", 189);
		public static const DOWN:Key = new Key("Down", 40);
		public static const E:Key = new Key("e", 69);
		public static const EIGHT:Key = new Key("8", 56);
		public static const ENTER:Key = new Key("Enter", 13);
		public static const EQUALS:Key = new Key("=", 187);
		public static const F:Key = new Key("f", 70);
		public static const FIVE:Key = new Key("5", 53);
		public static const FORWARD_SLASH:Key = new Key("/", 191);
		public static const FOUR:Key = new Key("4", 52);
		public static const G:Key = new Key("g", 71);
		public static const H:Key = new Key("h", 72);
		public static const I:Key = new Key("i", 73);
		public static const J:Key = new Key("j", 74);
		public static const K:Key = new Key("k", 75);
		public static const L:Key = new Key("l", 76);
		public static const LEFT:Key = new Key("Left", 37);
		public static const LEFT_BRACKET:Key = new Key("[", 219);
		public static const M:Key = new Key("m", 77);
		public static const N:Key = new Key("n", 78);
		public static const NINE:Key = new Key("9", 57);
		public static const O:Key = new Key("o", 79);
		public static const ONE:Key = new Key("1", 49);
		public static const OPTION:Key = new Key("Option", 18);
		public static const P:Key = new Key("p", 80);
		public static const PERIOD:Key = new Key(".", 190);
		public static const Q:Key = new Key("q", 81);
		public static const R:Key = new Key("r", 82);
		public static const RIGHT:Key = new Key("Right", 39);
		public static const RIGHT_BRACKET:Key = new Key("]", 221);
		public static const S:Key = new Key("s", 83);
		public static const SEMICOLON:Key = new Key(";", 186);
		public static const SEVEN:Key = new Key("7", 55);
		public static const SHIFT:Key = new Key("Shift", 16);
		public static const SINGLE_QUOTE:Key = new Key("'", 222);
		public static const SIX:Key = new Key("6", 54);
		public static const SPACE:Key = new Key("Space", 32);
		public static const T:Key = new Key("t", 84);
		public static const TAB:Key = new Key("Tab", 9);
		public static const THREE:Key = new Key("3", 51);
		public static const TILDA:Key = new Key("~", 192);
		public static const TWO:Key = new Key("2", 50);
		public static const U:Key = new Key("u", 85);
		public static const UP:Key = new Key("Up", 38);
		public static const V:Key = new Key("v", 86);
		public static const W:Key = new Key("w", 87);
		public static const X:Key = new Key("x", 88);
		public static const Y:Key = new Key("y", 89);
		public static const Z:Key = new Key("z", 90);
		public static const ZERO:Key = new Key("0", 48);
		
		private static var keyboard:Keyboard;
		private static var stopped:Boolean = false;
		
		private var keys:Vector.<Key>;
		private var stage:Stage;
		
		public function Keyboard(stage:Stage) {
			if(keys) {
				return;
			}
			this.stage = stage;
			keys = new Vector.<Key>();
			keys.push(TILDA, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, ZERO, DASH, EQUALS, BACKSPACE, TAB, Q, W, E, R, T, Y, U, I, O, P, RIGHT_BRACKET, LEFT_BRACKET, FORWARD_SLASH, CAPS, A, S, D, F, G, H, J, K, L, SEMICOLON, SINGLE_QUOTE, ENTER, SHIFT, Z, X, C, V, B, N, M, COMMA, PERIOD, BACKSLASH, SHIFT, CONTROL, OPTION, COMMAND, SPACE, COMMAND, CONTROL, UP, LEFT, DOWN, RIGHT);
			if(stopped) {
				return;
			}
			stage.focus = stage;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			keyboard = this;
		}
		
		public function getKeyFromCode(code:int):Key {
			for(var i:int = 0; i < keys.length; i++) {
				if(code == keys[i].code) {
					return keys[i];
				}
			}
			return null;
		}
		
		public function getKeyFromName(name:String):Key {
			for(var i:int = 0; i < keys.length; i++) {
				if(name.toLowerCase() == keys[i].name) {
					return keys[i];
				}
			}
			return null;
		}
		
		public function keyCodeToName(code:int):String {
			for(var i:int = 0; i < keys.length; i++) {
				if(code == keys[i].code) {
					return keys[i].name;
				}
			}
			return "NONE FOUND";
		}
		
		public function nameToKeyCode(name:String):int {
			for(var i:int = 0; i < keys.length; i++) {
				if(name.toLowerCase() == keys[i].name) {
					return keys[i].code;
				}
			}
			return -1;
		}
		
		private function keyDown(e:KeyboardEvent):void {
			for(var i:int = 0; i < keys.length; i++) {
				if(e.keyCode == keys[i].code) {
					keys[i].isDown = true;
					return;
				}
			}
		}
		
		private function keyUp(e:KeyboardEvent):void {
			for(var i:int = 0; i < keys.length; i++) {
				if(e.keyCode == keys[i].code) {
					keys[i].isDown = false;
					return;
				}
			}
		}
		
		public static function stop():void {
			stopped = true;
			if(!keyboard) {
				return;
			}
			keyboard.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyboard.keyDown);
			keyboard.stage.removeEventListener(KeyboardEvent.KEY_UP, keyboard.keyUp);
		}
	}
}