package com.rocketmandevelopment.utils {
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	public class Utils {
		private static var waiters:Array = [];
		
		public function Utils() {
		
		}
		
		public static function cloneArray(source:Array, is2D:Boolean):Array {
			var clone:Array = [];
			var len:int = source.length
			if(is2D) {
				for(var i:int = 0; i < len; i++) {
					clone[i] = [];
					for(var j:int = 0; j < source[i].length; j++) {
						clone[i][j] = source[i][j];
					}
				}
			} else {
				for(i = 0; i < len; i++) {
					clone[i] = source[i];
				}
			}
			return clone;
//			var myBA:ByteArray = new ByteArray();
//			myBA.writeObject(source);
//			myBA.position = 0;
//			return(myBA.readObject());
		}
		
		public static function formatNumber(number:Number):String {
			var numString:String = number.toString()
			var result:String = ''
			
			while(numString.length > 3) {
				var chunk:String = numString.substr(-3)
				numString = numString.substr(0, numString.length - 3)
				result = ',' + chunk + result
			}
			
			if(numString.length > 0) {
				result = numString + result
			}
			
			return result
		}
		
		public static function removeCommas(num:String):int {
			var pattern:RegExp = /[ \'\,\-\(\)]/gi;
			return int(num.replace(pattern, ""));
		}
		
		public static function score(score:Number):String {
			var s:String = score.toString();
			var f3:String = s.slice(0, 3);
			s = s.slice(3);
			var n:int = int(s);
			n /= Math.pow(10, s.length - 1)
			n = Math.round(n);
			if(s.length == 0) {
				n = -1;
			}
			var zs:String = "";
			for(var i:int = 0; i < s.length - 1; i++) {
				zs += "0";
			}
			if(n >= 0) {
				f3 += n.toString() + zs;
			}
			f3 = formatNumber(int(f3));
			return f3;
		}
		
		public static function wait(time:int, complete:Function):void {
			var t:Timer = new Timer(time, 1);
			t.addEventListener(TimerEvent.TIMER, complete, false, 0, true);
			t.addEventListener(TimerEvent.TIMER_COMPLETE, remove, false, 0, true);
			t.start();
			waiters.push(t);
		}
		
		private static function remove(e:TimerEvent):void {
			waiters.splice(waiters.indexOf(e.target));
		}
	}
}