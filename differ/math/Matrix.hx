package differ.math;

import differ.math.*;
import differ.shapes.*;
import differ.data.*;

//NOTE : Only implements the basics required for the shape transformations
//NOTE : Not a full implementation, some code copied from openfl/flash/geom/Matrix.hx

class Matrix  {

//#if cpp implements cpp.rtti.FieldNumericIntegerLookup #end

    public var a:Float;
    public var b:Float;
    public var c:Float;
    public var d:Float;
    public var tx:Float;
    public var ty:Float;

    var _last_rotation : Float = 0;

    public function new(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1, tx:Float = 0, ty:Float = 0) {

        this.a = a;
        this.b = b;
        this.c = c;
        this.d = d;
        this.tx = tx;
        this.ty = ty;

    } //new

    public function identity() {

        a = 1;
        b = 0;
        c = 0;
        d = 1;
        tx = 0;
        ty = 0;

    } //identity

    public function translate (x:Float, y:Float):Void {

        tx += x;
        ty += y;

    } //translate

    public function compose( _position:Vector, _rotation:Float, _scale:Vector ) {

        identity();

        scale( _scale.x, _scale.y );
        rotate( _rotation );
        makeTranslation( _position.x, _position.y );

    } //compose

    public function makeTranslation( _x:Float, _y:Float ) : Matrix {

        tx = _x;
        ty = _y;

        return this;

    } //makeTranslation

    public function rotate (angle:Float):Void {

        var cos = Math.cos (angle);
        var sin = Math.sin (angle);

        var a1 = a * cos - b * sin;
            b = a * sin + b * cos;
            a = a1;

        var c1 = c * cos - d * sin;
            d = c * sin + d * cos;
            c = c1;

        var tx1 = tx * cos - ty * sin;
            ty = tx * sin + ty * cos;
            tx = tx1;

    } //rotate

    public function scale (x:Float, y:Float):Void {

        a *= x;
        b *= y;

        c *= x;
        d *= y;

        tx *= x;
        ty *= y;

    } //scale

    public function toString ():String {

        return "(a=" + a + ", b=" + b + ", c=" + c + ", d=" + d + ", tx=" + tx + ", ty=" + ty + ")";

    } //toString

} //Matrix
