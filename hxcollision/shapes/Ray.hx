package hxcollision.shapes;
import hxcollision.math.Vector;

/**
 * ...
 * @author P Svilans
 */
class Ray
{
	
	public var start:Vector;
	public var end:Vector;
	
	public var isInfinite:Bool;
	
	public function new(start:Vector, end:Vector, isInfinite:Bool = true) 
	{
		this.start = start;
		this.end = end;
		
		this.isInfinite = isInfinite;
	}
	
}