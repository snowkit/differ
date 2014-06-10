package hxcollision.shapes;
import hxcollision.math.Vector;

/**
 * ...
 * @author P Svilans
 */
class Ray extends Vector
{
	
	public var direction:Vector;
	
	public function new(x:Float = 0.0, y:Float = 0.0, direction:Vector) 
	{
		super(x, y);
		
		this.direction = direction;
	}
	
}