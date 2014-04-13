package hxcollision;

import hxcollision.math.Vector2D;
import hxcollision.shapes.Circle;
import hxcollision.shapes.Polygon;
import hxcollision.shapes.Shape;

class ShapeDrawer {

    public function new() {}

        //To implement your own shape drawing class, you only need to override this function and implement it
        //the rest is handled internally, or you can override specifics if you want.
    public function drawLine( p0:Vector2D, p1:Vector2D, ?startPoint:Bool = true ) {
        
    } //drawLine

    public function drawShape( shape:Shape ) {

        if(Std.is(shape, Polygon)) {
            drawPolygon(cast(shape, Polygon));
            return;
        }

        if(Std.is(shape, Circle)) {
            drawCircle(cast(shape, Circle));
            return;
        }

    }

    public function drawPolygon( poly:Polygon ) {

        var v : Array<Vector2D> = poly.transformedVertices.copy();
        
        drawVertList( v );

    } //drawPolygon

    public function drawVector( v:Vector2D, start:Vector2D, ?startPoint:Bool = true ) {
        
        drawLine( start, v );

    } //drawVector

    private function drawVertList( _verts : Array<Vector2D> ) {

        var _count : Int = _verts.length;
        if(_count < 3) {
            throw "cannot draw polygon with < 3 verts as this is a line or a point.";
        }

            //start the polygon by drawing this start point
        drawLine( _verts[0], _verts[1], true );

            //draw the rest of the points
        for(i in 1 ... _count-1) {
            drawLine( _verts[i], _verts[i+1], false );
        }
            //join last point to first point
        drawLine( _verts[_count], _verts[0], false );

    } //drawVertList

    public function drawCircle( circle:Circle ) {
            //from :
        //http://slabode.exofire.net/circle_draw.shtml

        var _smooth : Float = 10;
        var _steps : Int = Std.int(_smooth * Math.sqrt( circle.transformedRadius ));

            //Precompute the value based on segments
        var theta = 2 * 3.1415926 / _steps;

        var tangential_factor = Math.tan( theta );
        var radial_factor = Math.cos( theta );
        
        var x : Float = circle.transformedRadius; 
        var y : Float = 0; 
        
        var _verts : Array<Vector2D> = [];

        for( i in 0 ... _steps ) {

            var __x = x + circle.x;
            var __y = y + circle.y;

            _verts.push( new Vector2D(__x,__y));
            
                var tx = -y; 
                var ty = x; 
                
                x += tx * tangential_factor; 
                y += ty * tangential_factor; 
                
                x *= radial_factor;
                y *= radial_factor;

        } //for

            //now draw it
        drawVertList( _verts );

    } //drawCircle


} //ShapeDrawer