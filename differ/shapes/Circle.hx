package differ.shapes;

import differ.math.*;
import differ.shapes.*;
import differ.data.*;
import differ.sat.*;

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

        /** Test for collision against a shape. */
    override public function test( shape:Shape ) : ShapeCollision {

        return shape.testCircle( this, true );

    } //test

        /** Test for collision against a circle. */
    override public function testCircle( circle:Circle, flip:Bool = false ) : ShapeCollision {

        return SAT2D.testCircleVsCircle( this, circle, flip );

    } //testCircle

        /** Test for collision against a polygon. */
    override public function testPolygon( polygon:Polygon, flip:Bool = false ) : ShapeCollision {

        return SAT2D.testCircleVsPolygon( this, polygon, flip );

    } //testPolygon

        /** Test for collision against a ray. */
    override public function testRay( ray:Ray ) : RayCollision {

        return SAT2D.testRayVsCircle(ray, this);

    } //testRay

//Internal API

    function get_radius():Float {

        return _radius;

    } //get_radius

    function get_transformedRadius():Float {

        return _radius * scaleX;

    } //get_transformedRadius

} //Circle
