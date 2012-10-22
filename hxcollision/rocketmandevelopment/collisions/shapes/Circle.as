package com.rocketmandevelopment.collisions.shapes {
	import flash.display.Graphics;
	import com.rocketmandevelopment.math.Vector2D;
	
	public class Circle extends BaseShape {
		private var _radius:Number;
		
		public function get radius():Number {
			return _radius;
		}
		
		public function get transformedRadius():Number {
			return _radius * scaleX;
		}
		
		public function Circle(radius:Number, position:Vector2D) {
			_radius = radius;
			super(position);
		}
		
		override public function draw(graphics:Graphics):void {
			graphics.drawCircle(x, y, transformedRadius);
		}
	}
}