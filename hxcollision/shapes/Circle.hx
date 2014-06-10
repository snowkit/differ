package hxcollision.shapes;

import hxcollision.Collision;
import hxcollision.data.CollisionData;
import hxcollision.data.RayData;
import hxcollision.shapes.Circle;
import hxcollision.shapes.Polygon;
import hxcollision.shapes.Shape;

/** A circle collision shape */
class Circle extends Shape {

        /** The radius of this circle. Set on construction */
    public var radius( get_radius, never ) : Float;
        /** The transformed radius of this circle, based on the scale/rotation */
    public var transformedRadius( get_transformedRadius, never ) : Float;
    
    var _radius:Float;
    
    public function new(x:Float, y:Float, radius:Float) {

        super( x, y );
        _radius = radius;
        name = 'circle ' + _radius;

    } //new
	
	override public function test(shape:Shape):CollisionData
	{
		return shape.testCircle(this, true);
	}
	
	override public function testCircle(circle:Circle, flip:Bool = false):CollisionData
	{
		var c1 = flip ? circle : this;
		var c2 = flip ? this : circle;
		return Collision2D.testCircles( c1, c2 );
	}
	
	override public function testPolygon(polygon:Polygon, flip:Bool = false):CollisionData
	{
		return Collision2D.testCircleVsPolygon( this, polygon, flip );
	}
	
	override public function testRay(ray:Ray):RayData 
	{
		return Collision2D.rayCircle(ray, this);
	}

//Internal API

    function get_radius():Float {
        
        return _radius;

    } //get_radius
    
    function get_transformedRadius():Float {
        
        return _radius * scaleX;

    } //get_transformedRadius

} //Circle
