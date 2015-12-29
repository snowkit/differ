
import differ.ShapeDrawer;
import differ.shapes.Circle;
import differ.math.Vector;
import luxe.Log.*;

class LuxeDrawer extends ShapeDrawer {

    static var color = new luxe.Color().rgb(0xf6007b); //0xff4b03

    override public function drawCircle( circle:Circle ) {

        assertnull(circle);

        Luxe.draw.ring({
            x: circle.position.x,
            y: circle.position.y,
            r: circle.transformedRadius,
            color: color,
            depth: 20,
            immediate: true
        });

    }

    override public function drawLine( p0x:Float, p0y:Float, p1x:Float, p1y:Float, ?startPoint:Bool = true ) {

        Luxe.draw.line({
            p0 : new luxe.Vector(p0x, p0y),
            p1 : new luxe.Vector(p1x, p1y),
            color : color,
            depth : 20,
            immediate : true
        });

    } //drawLine

} //LuxeDrawer