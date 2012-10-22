package com.rocketmandevelopment.math {
	
	public class Math2 {
		
		public function Math2() {
		}
		
		public static function degreesToRadians(degrees:Number):Number {
			return degrees * Math.PI / 180;
		}
		
		public static function distance(x1:Number, y1:Number, x2:Number, y2:Number):Number {
			return Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
		}
		
		public static function distanceSquared(x1:Number, y1:Number, x2:Number, y2:Number):Number {
			return ((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
		}
		
		public static function polarToCartesian(radius:Number, angle:Number):Vector2D {
			var obj:Vector2D = new Vector2D();
			obj.x = radius * Math.cos(angle);
			obj.y = radius * Math.sin(angle);
			return obj;
		}
		
		/**
		 * Projects vector v onto vector u
		 * @param v Vector2D, the vector to project
		 * @param u Vector2D, the vector v is projected onto
		 * @return Vector2D The projected vector
		 */
		public static function proj(v:Vector2D, u:Vector2D):Vector2D {
			v = v.cloneVector();
			u = u.cloneVector();
			u.normalize();
			return u.multiply(u.dotProduct(v));
		}
		
		public static function radiansToDegrees(radians:Number):Number {
			return radians * 180 / Math.PI;
		}
		
		public static function randomFrom(nums:Array):Number {
			return nums[Math2.randomInt(0, nums.length - 1)];
		}
		
		public static function randomInt(lowVal:int, highVal:int):int {
			if(lowVal > highVal) {
				var t:int = lowVal;
				lowVal = highVal;
				highVal = t;
			}
			return Math.floor(Math.random() * (1 + highVal - lowVal)) + lowVal;
		}
		
		public static function randomNumb(lowVal:Number, highVal:Number):Number {
			return (Math.random() * (1 + highVal - lowVal)) + lowVal;
		}
		
		public static function randomSmallNumb(lowVal:Number, highVal:Number):Number {
			return (Math.random() * (highVal - lowVal)) + lowVal;
		}
		
		public static function rotate(v:Vector2D, angle:Number):Vector2D {
			var result:Vector2D = new Vector2D();
			var sin:Number = Math2.degreesToRadians(angle);
			var cos:Number = Math.cos(sin);
			sin = Math.sin(sin);
			result.x = v.x * cos - v.y * sin;
			result.y = v.y * cos + v.x * sin;
			return result;
		}
		
		public static function rotateNumbers(vx:Number, vy:Number, angle:Number):Vector2D {
			var result:Vector2D = new Vector2D();
			var sin:Number = Math2.degreesToRadians(angle);
			var cos:Number = Math.cos(sin);
			sin = Math.sin(sin);
			result.x = vx * cos - vy * sin;
			result.y = vy * cos + vx * sin;
			return result;
		}
	}
}