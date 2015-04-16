package differ.math;

import differ.math.Matrix;

//NOTE : Only implements the basics required for the collision code.
//The goal is to make this library as simple and unencumbered as possible, making it easier to integrate
//into an existing codebase. This means that using abstracts or similar you can add a function like "toMyEngineVectorFormat()"
//or simple an adapter pattern to convert to your preferred format. It simplifies usage and handles internals, nothing else.
//This also means that ALL of these functions are used and are needed.


    /** 2D vector class */
class Vector {

        /** The x component */
    public var x  : Float = 0;
        /** The y component */
    public var y  : Float = 0;

        /** The length of the vector */
    public var length ( get, set ) : Float;
        /** The length, squared, of the vector */
    public var lengthsq ( get, never ) : Float;

    public function new( _x:Float = 0, _y:Float = 0 ) {

        x = _x;
        y = _y;

    } //new

        /** Copy, returns a new vector instance from this vector. */
    public inline function clone() : Vector {

        return new Vector(x, y);

    } //clone

        /** Transforms Vector based on the given Matrix. Returns this vector, modified. */
    public function transform(matrix:Matrix):Vector {

        var v:Vector = clone();

            v.x = x*matrix.a + y*matrix.c + matrix.tx;
            v.y = x*matrix.b + y*matrix.d + matrix.ty;

        return v;

    } //transform

        /** Sets the vector's length to 1. Returns this vector, modified. */
    public function normalize() : Vector {

        if(length == 0){
            x = 1;
            return this;
        }

        var len:Float = length;

            x /= len;
            y /= len;

        return this;

    } //normalize

        /** Sets the length to fit under the given maximum value.
            Nothing is done if the vector is already shorter.
            Returns this vector, modified. */
    public function truncate( max:Float ) : Vector {

        length = Math.min(max, length);

        return this;

    } //truncate

        /** Invert this vector. Returns this vector, modified. */
    public function invert() : Vector {

            x = -x;
            y = -y;

        return this;

    } //invert

        /** Return the dot product of this vector and another vector. */
    public function dot( other:Vector ) : Float {

        return x * other.x + y * other.y;

    } //dot

        /** Return the cross product of this vector and another vector. */
    public function cross( other:Vector ) : Float {

        return x * other.y - y * other.x;

    } //cross

        /** Add a vector to this vector. Returns this vector, modified. */
    public function add(other:Vector):Vector {

            x += other.x;
            y += other.y;

        return this;

    } //add

        /** Subtract a vector from this one. Returns this vector, modified. */
    public function subtract( other:Vector ) : Vector {

            x -= other.x;
            y -= other.y;

        return this;

    } //subtract

        /** Return a string representation of this vector. */
    public function toString() : String return "Vector x:" + x + ", y:" + y;

//Internal


    inline function set_length(value:Float) : Float {

        var ep:Float = 0.00000001;
        var _angle:Float = Math.atan2(y, x);

            x = Math.cos(_angle) * value;
            y = Math.sin(_angle) * value;

        if(Math.abs(x) < ep) x = 0;
        if(Math.abs(y) < ep) y = 0;

        return value;

    } //set_length

    inline function get_length() : Float return Math.sqrt(lengthsq);
    inline function get_lengthsq() : Float return x * x + y * y;


} //Vector
