package hxcollision.data;
import hxcollision.shapes.Ray;
import hxcollision.shapes.Shape;

/**
 * ...
 * @author P Svilans
 */
class RayData
{
	
	/**
	 * shape the intersection was with.
	 */
	public var shape:Shape;
	public var ray:Ray;
	
	/**
	 * distance along ray that the intersection occurred at.
	 */
	public var start:Float;
	public var end:Float;
	
	public function new(shape:Shape, ray:Ray, start:Float, end:Float) 
	{
		this.shape = shape;
		this.ray = ray;
		
		this.start = start;
		this.end = end;
	}
	
}