package hxcollision.math;

import hxcollision.math.Matrix;

//NOTE : Only implements the basics required for the collision code.
//The goal is to make this library as simple and unencumbered as possible, making it easier to integrate
//into an existing codebase. This means that using abstracts or similar you can add a function like "toMyEngineVectorFormat()"
//or simple an adapter pattern to convert to your preferred format. It simplifies usage and handles internals, nothing else.
//This also means that ALL of these functions are used and are needed.

/**
 * 2D vector class
 */
class Vector {

    public var x  : Float = 0;
    public var y  : Float = 0;

    public var length ( get, set ) : Float;
    public var lengthsq ( get, never ) : Float;
    
    /**
     * Constructor
     */
    public function new( _x:Float = 0, _y:Float = 0 ) {

        x = _x;
        y = _y;

    }

    /**
     * Creates an exact copy of this Vector
     * @return Vector A copy of this Vector
     */
    public function clone():Vector {
        return new Vector(x, y);
    }

    /**
     *  Transforms Vector based on the given Matrix
     * @param matrix The matrix to use to transform this vector.
     * @return Vector returns a new, transformed Vector.
     */
    public function transform(matrix:Matrix):Vector {

        var v:Vector = clone();

            v.x = x*matrix.a + y*matrix.c + matrix.tx;
            v.y = x*matrix.b + y*matrix.d + matrix.ty;

        return v;

    } //transform
    
    /**
     * Sets the length which will change x and y, but not the angle.
     */
    public function set_length(value:Float):Float {
        
        var _angle:Float = Math.atan2(y, x);
        
            x = Math.cos(_angle) * value;
            y = Math.sin(_angle) * value;
        
        if(Math.abs(x) < 0.00000001) x = 0;
        if(Math.abs(y) < 0.00000001) y = 0;
        
        return value;

    } //set_length

    /**
     * Returns the length of the vector.
     **/
    private function get_length():Float {
        return Math.sqrt(lengthsq);
    }
    
    /**
     * Returns the length of this vector, before square root. Allows for a faster check.
     */
    private function get_lengthsq():Float {
        return x * x + y * y;
    }

    /**
     * Sets the vector's length to 1.
     * @return Vector This vector.
     */
    public function normalize():Vector {
        
        if(length == 0){
            x = 1;
            return this;
        }

        var len:Float = length;

            x /= len;
            y /= len;

        return this;

    } //normalize
    
    /**
     * Sets the length under the given value. Nothing is done if the vector is already shorter.
     * @param max The max length this vector can be.
     * @return Vector This vector.
     */
    public function truncate(max:Float):Vector {
        
        length = Math.min(max, length);

        return this;

    } //truncate

    /**
     * Makes the vector face the opposite way.
     * @return Vector This vector.
     */
    public function invert() : Vector {

            x = -x;
            y = -y;

        return this;

    } //invert

    /**
     * Calculate the dot product of this vector and another.
     * @param vector2 Another Vector.
     * @return Float The dot product.
     */
    public function dot( vector2:Vector ) : Float {
        return x * vector2.x + y * vector2.y;
    }
	
    /**
     * Calculate the cross product of this vector and another.
     * @param vector2 Another Vector.
     * @return Float The dot product.
     */
	public function cross( vector2:Vector ) : Float
	{
		return x * vector2.y - y * vector2.x;
	}

    /**
     * Add a vector to this vector.
     * @param vector2 The vector to add to this one.
     * @return Vector This vector.
     */
    public function add(vector2:Vector):Vector {
        
            x += vector2.x;
            y += vector2.y;

        return this;

    } //add

    /**
     * Subtract a vector from this one.
     * @param vector2 The vector to subtract.
     * @return Vector This vector.
     */
    public function subtract(vector2:Vector):Vector {
        
            x -= vector2.x;
            y -= vector2.y;

        return this;

    } //subtract

    /**
     * Turn this vector into a string.
     * @return String This vector in string form.
     */
    public function toString():String {
        return "Vector x:" + x + ", y:" + y;
    }
    
} //Vector
