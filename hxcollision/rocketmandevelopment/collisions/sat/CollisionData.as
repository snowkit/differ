package com.rocketmandevelopment.collisions.sat {
	import flash.geom.Point;
	import com.rocketmandevelopment.collisions.shapes.BaseShape;
	import com.rocketmandevelopment.math.Vector2D;
	
	public class CollisionData {
		public var overlap:Number = 0; // the overlap
		public var separation:Vector2D = new Vector2D(); // a vector that when subtracted to shape A will separate it from shape B
		
		public var shape1:BaseShape // the first shape
		public var shape2:BaseShape // the second shape
		public var unitVector:Vector2D = new Vector2D(); // unit vector in the direction that you need to move
		
		public function CollisionData() {
		}
	}
}