package hxcollision.shapes {
	
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import com.rocketmandevelopment.math.Math2;
	import com.rocketmandevelopment.math.Vector2D;
	 
	public class BaseShape {
		public var d:Number;
		
		protected var _position:Vector2D;
		
		public function get position():Vector2D {
			return _position;
		}
		
		public function set position(newPosition:Vector2D):void {
			_transformMatrix.tx = newPosition.x
			_transformMatrix.ty = newPosition.y;
			_position = newPosition;
			_transformed = false;
		}
		protected var _rotation:Number;
		
		public function get rotation():Number {
			return _rotation;
		}
		
		public function set rotation(newRotation:Number):void {
			_rotation = newRotation;
			_transformMatrix.rotate(Math2.degreesToRadians(newRotation));
			_transformed = false;
		}
		private var _scaleX:Number;
		
		public function get scaleX():Number {
			return _scaleX;
		}
		
		public function set scaleX(scale:Number):void {
			_scaleX = scale;
			_transformMatrix.scale(_scaleX, _scaleY);
			_transformed = false;
		}
		private var _scaleY:Number;
		
		public function get scaleY():Number {
			return _scaleY;
		}
		
		public function set scaleY(scale:Number):void {
			_scaleY = scale;
			_transformMatrix.scale(_scaleX, _scaleY);
			_transformed = false;
		}
		protected var _transformedVertices:Array;
		
		public function get transformedVertices():Array {
			if(!_transformed) {
				_transformedVertices = [];
				_transformed = true;
				for(var i:int = 0; i < _vertices.length; i++) {
					_transformedVertices.push(_vertices[i].transform(_transformMatrix));
				}
			}
			return _transformedVertices;
		}
		protected var _vertices:Array;
		
		public function get vertices():Array {
			return _vertices;
		}
		
		public function get x():Number {
			return _position.x
		}
		
		public function set x(x:Number):void {
			_position.x = x;
			_transformMatrix.tx = x;
			_transformed = false;
		}
		
		public function get y():Number {
			return _position.y;
		}
		
		public function set y(y:Number):void {
			_position.y = y;
			_transformMatrix.ty = y;
			_transformed = false;
		}
		
		private var _transformMatrix:Matrix;
		private var _transformed:Boolean = false;
		
		public function BaseShape(position:Vector2D) {
			_position = position;
			_rotation = 0;
			_scaleX = 1;
			_scaleY = 1;
			_transformMatrix = new Matrix();
			_transformMatrix.tx = _position.x;
			_transformMatrix.ty = _position.y;
		}
		
		public function destroy():void {
			_position = null;
		}
		
		public function draw(graphics:Graphics):void {
			return;
		}
	}
}