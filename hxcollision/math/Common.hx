package hxcollision.math;

/**
 * ...
 * @author P Svilans
 */
class Common
{
	
	/** Internal api - find the normal axis of a vert in the list at index */
    public static function findNormalAxis(vertices:Array<Vector>, index:Int):Vector
	{
        var vector1:Vector = vertices[index];
        var vector2:Vector = (index >= vertices.length - 1) ? vertices[0] : vertices[index + 1]; //make sure you get a real vertex, not one that is outside the length of the vector.
        
        var normalAxis:Vector = new Vector(-(vector2.y - vector1.y), vector2.x - vector1.x); //take the two vertices, make a line out of them, and find the normal of the line
		normalAxis.normalize(); //normalize the line(set its length to 1)
		
		return normalAxis;
    } //findNormalAxis
	
}