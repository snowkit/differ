package hxcollision;

import flash.display.Graphics;

import hxcollision.shapes.Circle;
import hxcollision.shapes.Polygon;
import hxcollision.math.Vector2D;

class OpenFLDrawer extends ShapeDrawer {
    
    public var graphics : Graphics;


    public override function drawCircle( circle:Circle ) { 
        if(graphics != null) {
            graphics.drawCircle( circle.x, circle.y, circle.transformedRadius );
        }
    } //drawCircle

    public override function drawLine( p0:Vector2D, p1:Vector2D ) {
        
        if(graphics != null) {
            graphics.moveTo( p0.x, p0.y );
            graphics.lineTo( p1.x, p1.y);
        } //graphics != null

    } //drawLine

} //OpenFLDrawer