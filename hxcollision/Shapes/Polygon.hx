package com.rocketmandevelopment.collisions.shapes {
	import flash.display.Graphics;
	import com.rocketmandevelopment.math.Math2;
	import com.rocketmandevelopment.math.Vector2D;
	
	public class Polygon extends BaseShape {
		
		public function Polygon(vertices:Array, position:Vector2D) {
			_vertices = vertices;
			super(position);
		}
		
		override public function destroy():void {
			for(var i:int = 0; i < _vertices.length; i++) {
				_vertices[i] = null;
			}
			_vertices = null;
			super.destroy();
		}
		
		override public function draw(graphics:Graphics):void {
			var v:Array = transformedVertices.concat();
			graphics.moveTo(v[0].x, v[0].y);
			for(var i:int = 0; i < v.length; i++) {
				graphics.lineTo(v[i].x, v[i].y);
			}
			graphics.lineTo(v[0].x, v[0].y);
		}
		
		public static function normalPolygon(sides:int, radius:Number=100, position:Vector2D=null):Polygon {
			if(sides < 3) {
				throw new Error('Polygon - Needs at least 3 sides');
			}
			if(!position) {
				position = new Vector2D();
			}
			var rotation:Number = (Math.PI * 2) / sides;
			var angle:Number;
			var vector:Vector2D;
			var vertices:Array = [];
			for(var i:int = 0; i < sides; i++) {
				angle = (i * rotation) + ((Math.PI - rotation) * 0.5);
				vector = new Vector2D();
				vector.x = Math.cos(angle) * radius;
				vector.y = Math.sin(angle) * radius;
				vertices.push(vector);
			}
			return new Polygon(vertices, position);
		}
		
		public static function rectangle(width:Number, height:Number, position:Vector2D):Polygon {
			var vertices:Array = [];
			vertices.push(new Vector2D(-width / 2, -height / 2), new Vector2D(width / 2, -height / 2), new Vector2D(width / 2, height / 2), new Vector2D(-width / 2, height / 2));
			return new Polygon(vertices, position);
		}
		
		public static function square(width:Number, position:Vector2D):Polygon {
			return rectangle(width, width, position);
		}
	}
}