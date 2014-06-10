package hxcollision;

import hxcollision.data.RayData;
import hxcollision.data.RayIntersectionData;
import hxcollision.shapes.Ray;
import hxcollision.shapes.Shape;
import hxcollision.shapes.Circle;
import hxcollision.shapes.Polygon;

import hxcollision.data.CollisionData;
import hxcollision.ShapeDrawer;

import hxcollision.math.Vector;

class Collision {

        /** Test a single shape against another shape. 
            When no collision is found between them, this function returns null.
            Returns a `CollisionData` if a collision is found.
        */
    public static function test( shape1:Shape, shape2:Shape ): CollisionData
	{
		return shape1.test(shape2);
    } //test
   
        /** Test a single shape against multiple other shapes. 
            Will never return null, always length 0 array. 
            Returns a list of `CollisionData` information for each collision found.
        */
    public static function testShapes( shape1:Shape, shapes:Array<Shape> ) : Array<CollisionData> {
        
        var results : Array<CollisionData> = [];

        for (other_shape in shapes)
		{
            var result = test(shape1, other_shape);
            if(result != null) results.push(result);
        } //for all shapes passed in

        return results;

    } //testShapes

	/** Test a line between two points against a list of shapes. 
		If a collision is found, returns true, otherwise false.
	*/
    public static function rayShape( ray:Ray, shape:Shape ) : RayData
	{
		return shape.testRay(ray);
    } //ray

	/** Test a line between two points against a list of shapes. 
		If a collision is found, returns true, otherwise false.
	*/
    public static function rayShapes( ray:Ray, shapes:Array<Shape> ) : Array<RayData>
	{
		var results = new Array<RayData>();
		
		//check against each shape
        for (shape in shapes)
		{
			var r = shape.testRay(ray);
			if (r != null) results.push(r);
		}
		
        return results;
    } //ray
	
	public static function rayRay( ray1:Ray, ray2:Ray ):RayIntersectionData
	{
		return Collision2D.rayRay(ray1, ray2);
	}
	
	public static function rayRays( ray:Ray, rays:Array<Ray> ):Array<RayIntersectionData>
	{
		var results = new Array<RayIntersectionData>();
		
		for (ray2 in rays)
		{
			var r = Collision2D.rayRay(ray, ray2);
			if (r != null) results.push(r);
		}
		
		return results;
	}

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
