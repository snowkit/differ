package com.rocketmandevelopment.utils.KeyboardUtils {
	public class Key {
		public var name:String;
		public var isDown:Boolean;
		public var code:int;
		
		public function Key(name:String,code:int){
			this.name = name;
			this.code = code;
		}
	}
}