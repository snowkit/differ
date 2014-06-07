package hxcollision;

import flash.display.Graphics;

import hxcollision.shapes.Circle;
import hxcollision.shapes.Polygon;
import hxcollision.math.Vector;


class OpenFLDrawer extends ShapeDrawer {


        /** Access to the graphics object for manually manipulating it post construction */
    public var graphics : Graphics;

        /** Create a new drawing helper, which will draw into the provided `Graphics` object */
    public function new( _graphics : Graphics ) {
        super();
        graphics = _graphics;
    } //new

        /** Implementation required by `ShapeDrawer` */
    public override function drawLine( p0:Vector, p1:Vector, ?startPoint:Bool = true ) {
        
        if(graphics != null) {
            if(startPoint)
                graphics.moveTo( p0.x, p0.y );
            graphics.lineTo( p1.x, p1.y);
        } //graphics != null

    } //drawLine

        /** Implemented by choice, not required */
    public override function drawCircle( circle:Circle ) { 

        if(graphics != null) {
            graphics.drawCircle( circle.x, circle.y, circle.transformedRadius );
        } //graphics != null

    } //drawCircle

    public override function drawVector( p0:Vector, p1:Vector, ?startPoint:Bool = true ) {
        
        if(graphics != null) {
            if(startPoint)
                graphics.moveTo( p0.x, p0.y );
            graphics.lineTo( p1.x, p1.y);
            graphics.drawCircle( p1.x, p1.y, 2);
        } //graphics != null

    } //drawVector


} //OpenFLDrawer
