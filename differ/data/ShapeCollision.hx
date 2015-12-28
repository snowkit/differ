package differ.data;

import differ.math.*;
import differ.shapes.*;
import differ.data.*;

/** Collision data, obtained by testing two shapes for a collision. */
class ShapeCollision {

        /** the overlap amount */
    public var overlap : Float = 0;
        /** y component of the separation vector, when subtracted to shape 1 will separate it from shape 2 */
    public var separationX : Float;
        /** y component of the separation vector, when subtracted to shape 1 will separate it from shape 2 */
    public var separationY : Float;

        /** the first shape */
    public var shape1 : Shape;
        /** the second shape */
    public var shape2 : Shape;
        /** x value for unit vector on the axis of the collision (the normal of the face that was collided with) */
    public var unitVectorX : Float;
        /** y value for unit vector on the axis of the collision (the normal of the face that was collided with) */
    public var unitVectorY : Float;

    @:noCompletion
    public function new() {}

    public inline function reset() {
        separationX = separationY = overlap = unitVectorX = unitVectorY = 0.0;
        shape1 = shape2 = null;
    }

    public inline function clone() {
        var c = new ShapeCollision();
        c.overlap = overlap;
        c.separationX = separationX;
        c.separationY = separationY;
        c.shape1 = shape1;
        c.shape2 = shape2;
        c.unitVectorX = unitVectorX;
        c.unitVectorY = unitVectorY;
        return c;
    }

} //ShapeCollision
