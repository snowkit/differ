package hxcollision;

import hxcollision.shapes.Shape;
import hxcollision.shapes.Circle;
import hxcollision.shapes.Polygon;

import hxcollision.CollisionData;
import hxcollision.ShapeDrawer;

import hxcollision.math.Vector;

class Collision {

        /** Test a single shape against another shape. 
            When no collision is found between them, this function returns null.
            Returns a `CollisionData` if a collision is found.
        */
    public static function test( shape1:Shape, shape2:Shape ): CollisionData {

        var result1:CollisionData;
        var result2:CollisionData;

        if( Std.is(shape1, Circle) && Std.is(shape2, Circle) ) {
            return Collision2D.testCircles(cast(shape1,Circle), cast(shape2,Circle));
        }

        if( Std.is(shape1,Polygon) && Std.is(shape2,Polygon) ) {
            return Collision2D.testPolygons(cast(shape1,Polygon), cast(shape2,Polygon));
        }

        if(Std.is(shape1,Circle)) {
            return Collision2D.testCircleVsPolygon(cast(shape1,Circle), cast(shape2,Polygon), true);
        }

        if(Std.is(shape1,Polygon)) {
            return Collision2D.testCircleVsPolygon(cast(shape2,Circle), cast(shape1,Polygon), false);
        }

        return null;

    } //test
   
        /** Test a single shape against multiple other shapes. 
            Will never return null, always length 0 array. 
            Returns a list of `CollisionData` information for each collision found.
        */
    public static function testShapes( shape1:Shape, shapes:Array<Shape> ) : Array<CollisionData> {
        
        var results : Array<CollisionData> = [];

        for(other_shape in shapes) {
            var result = test(shape1, other_shape);
            if(result != null) {
                results.push(result);
            } //result != null
        } //for all shapes passed in

        return results;

    } //testShapes

        /** Test a line between two points against a list of shapes. 
            If a collision is found, returns true, otherwise false.
        */
    public static function ray( lineStart:Vector, lineEnd:Vector, shapes:Array<Shape> ) : Bool {
            
            //check against each shape
        for(_shape in shapes) {

                //if the shape is a circle
            if( Std.is(_shape,Circle) ) { 

                if( testCircleLine( cast _shape, lineStart, lineEnd) ) {
                    return true;
                }

            } else {

                    //if it's not a circle, it's a polygon
                var line:Array<Vector> = Collision2D.bresenhamLine( lineStart, lineEnd );

                for(_point in line) {
                    if( pointInPoly( _point, cast _shape) ) {
                        return true;
                    } //if the point is inside the polygon
                } //for each point in the line

           } //shape ! is circle

        } //for _shape in shapes

        return false;

    } //ray
        
        /** Test a circle vs a line between two points */
    public static function testCircleLine( circle:Circle, lineStart:Vector, lineEnd:Vector ) : Bool {

            //set up some variables we will use to check for a collision
        var d:Vector = lineEnd.clone().subtract(lineStart);
            //vector representing the length of the line
        var f:Vector = lineStart.clone().subtract(circle.position);
            //vector representing distance from start of line to circle center
        var a:Float = d.dot(d);
        var b:Float = 2 * f.dot(d);
        var c:Float = f.dot(f) - circle.radius * circle.radius;
        var discrm:Float = b * b - 4 * a * c;

            //quadratic equation
        if(discrm < 0) {
            return false;
        } else {

            discrm = Math.sqrt(discrm);
            
            var t1:Float = (-b + discrm) / (2 * a);
            var t2:Float = (-b - discrm) / (2 * a);

                if(t1 >= 0 && t1 <= 1) {
                    return true;
                } else {
                    return false;
                }

        }
            
        return false;

    } //testCircleLine

        /** Test if a given point lands inside the given polygon */
    public static function pointInPoly(point:Vector, poly:Polygon):Bool {

        var sides:Int = poly.transformedVertices.length; //amount of sides the polygon has
        var i:Int = 0;
        var j:Int = sides - 1;
            //how many sides have we passed through?
        var oddNodes:Bool = false;

        for(i in 0 ... sides) {

            if( (poly.transformedVertices[i].y < point.y && poly.transformedVertices[j].y >= point.y) || 
                (poly.transformedVertices[j].y < point.y && poly.transformedVertices[i].y >= point.y)) 
            {
                if( poly.transformedVertices[i].x + 
                    (point.y - poly.transformedVertices[i].y) / 
                    (poly.transformedVertices[j].y - poly.transformedVertices[i].y) * 
                    (poly.transformedVertices[j].x - poly.transformedVertices[i].x) < point.x) 
                {
                    oddNodes = !oddNodes;
                } //second if

            } //first if

            j = i;

        } //for each side

        return oddNodes; 

    } //pointInPoly     

//Internal API

    @:noCompletion public function new() {
        throw "Collision is a static class. No instances can be created.";
    }
	
} //Collision
