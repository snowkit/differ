package states;

import luxe.Vector;
import luxe.Input;
import luxe.Color;

import phoenix.geometry.LineGeometry;

import differ.Collision;
import differ.math.Vector in V;
import differ.shapes.*;
import differ.data.*;

using differ.data.RayCollision.RayCollisionHelper;

class RayAndShape extends luxe.States.State {

    var beam:Ray;

    var intersect:LineGeometry;
    var before:LineGeometry;
    var after:LineGeometry;

    override function onenter<T>(_:T) {

        Main.display('pink = ray\ngreen = before hit\nwhite = intersection\npurple = after hit');

        beam = new Ray( new V(450,300), new V(400,100), false );

        Main.rays.push(beam);
        Main.shapes.push(new Circle(600,400,50));
        Main.shapes.push(new Circle(200,400,50));
        Main.shapes.push( Polygon.rectangle(600,200,50,50));
        Main.shapes.push( Polygon.rectangle(200,200,50,50));

        intersect = Luxe.draw.line({ depth:100, batcher: Main.thicker, p0:new Vector(), p1:new Vector(), color:new Color().rgb(0xffffff) });
        before = Luxe.draw.line({ depth:100, batcher: Main.thicker, p0:new Vector(), p1:new Vector(), color:new Color().rgb(0x00f67b) });
        after = Luxe.draw.line({ depth:100, batcher: Main.thicker, p0:new Vector(), p1:new Vector(), color:new Color().rgb(0x7b00f6) });

    } //onenter

    override function onleave<T>(_:T) {

        beam = null;
        intersect.drop();
        before.drop();
        after.drop();

        intersect = null;
        before = null;
        after = null;

    } //onleave

     override function onkeyup(e:KeyEvent) {
        
        if(e.keycode == Key.space) {
            if(beam != null) beam.infinite = !beam.infinite;
        }

    } //onkeyup

    override function onmousemove( e:MouseEvent ) {
        if(beam != null) {
            if(beam.infinite) {
                var end = new Vector(e.pos.x, e.pos.y);
                end.subtract_xyz(beam.start.x, beam.start.y);
                end.normalize();
                end.multiplyScalar(9999);
                beam.end.x = end.x;
                beam.end.y = end.y;
            } else {
                beam.end.x = e.pos.x;
                beam.end.y = e.pos.y;
            }
        }
    }

    override function update(dt:Float) {

        if(Main.shapes.length <= 0) return;

        var colls = Collision.rayWithShapes(beam, Main.shapes);

        Luxe.draw.text({
            point_size:15,
            pos:new Vector(Luxe.screen.w - 10, 10),
            align: right,
            text: 'Hit ${colls.length} shapes',
            immediate:true,
        });

        var textYval = 30;

        for (c in colls) {
            var hitstartx = c.hitStartX();
            var hitstarty = c.hitStartY();
            var hitendx = c.hitEndX();
            var hitendy = c.hitEndY();

            intersect.p0 = new Vector(hitstartx, hitstarty);
            intersect.p1 = new Vector(hitendx, hitendy);

            before.p0 = new Vector(c.ray.start.x, c.ray.start.y);
            before.p1 = new Vector(hitstartx, hitstarty);

            after.p0 = new Vector(hitendx, hitendy);
            after.p1 = new Vector(c.ray.end.x, c.ray.end.y);

            Luxe.draw.text({
                point_size:13,
                pos:new Vector(Luxe.screen.w - 10,textYval),
                align: right,
                text: 'hit start %: ${c.start}\n end %: ${c.end}',
                immediate:true,
            });

            textYval += 30;

        } //each collision

    } //update

} //RayAndShape
