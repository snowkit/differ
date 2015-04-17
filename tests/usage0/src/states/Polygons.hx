package states;

import luxe.Vector;
import luxe.Input;
import luxe.Color;

import differ.Collision;
import differ.math.Vector in V;
import differ.shapes.*;
import differ.data.*;

class Polygons extends luxe.States.State {

    var fixed : Polygon;
    var mover : Polygon;

    override function onenter<T>(_:T) {

        fixed = Polygon.rectangle(Luxe.screen.mid.x, Luxe.screen.mid.y, 100, 60);
        mover = Polygon.square(10, 100, 50);

        Main.shapes.push(fixed);
        Main.shapes.push(mover);

        var text =  '\nThe white polygon is the position the separation would result in.\n';
            text += 'Hold down left or right mouse to rotate the box.';

        Main.display(text);

    } //onenter

    override function onleave<T>(_:T) {

        fixed.destroy();
        fixed = null;

        mover.destroy();
        mover = null;

    } //onleave


    override function onmousemove(e:MouseEvent) {

        mover.position = new V(e.pos.x, e.pos.y);

    } //onmousemove

    override function onrender() {

        if( Luxe.input.mousedown(MouseButton.left) ) {
            mover.rotation += 50 * Luxe.dt;
        }

        if( Luxe.input.mousedown(MouseButton.right) ) {
            mover.rotation -= 50 * Luxe.dt;
        }

        var coll = Collision.shapeWithShape(mover, fixed);

        if(coll != null) {
            Main.drawer.drawShapeCollision(coll);

            //draw a ghost shape where the collision would resolve to
            //we do that by using the separation data, and add it to the "shape1"
            //position, above, that shape1 is mover

            var sep = new Vector(coll.separation.x, coll.separation.y);

            var mover_separated_pos = new Vector( coll.shape1.position.x + sep.x, coll.shape1.position.y + sep.y );

            var r = Luxe.draw.rectangle({
                immediate: true,
                color: new Color(1,1,1,0.4),
                group: 2,
                x: mover_separated_pos.x,
                y: mover_separated_pos.y,
                w: 50, h: 50,
                origin: new Vector(25,25)
            });

            var rot_radians = luxe.utils.Maths.radians(mover.rotation);
            r.transform.rotation.setFromEuler(new Vector(0,0,rot_radians));

        }

    }

}
