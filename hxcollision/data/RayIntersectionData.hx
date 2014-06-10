package hxcollision.data;
import hxcollision.shapes.Ray;

/**
 * ...
 * @author P Svilans
 */
class RayIntersectionData
{
	
	/**
	 * rays the intersection was with.
	 */
	public var ray1:Ray;
	public var ray2:Ray;
	
	/**
	 * u values for each ray.
	 */
	public var u1:Float;
	public var u2:Float;
	
	public function new(ray1:Ray, u1:Float, ray2:Ray, u2:Float) 
	{
		this.ray1 = ray1;
		this.ray2 = ray2;
		
		this.u1 = u1;
		this.u2 = u2;
	}
	
}