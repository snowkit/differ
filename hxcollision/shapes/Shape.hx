package hxcollision.shapes;
    
import hxcollision.math.Matrix;
import hxcollision.math.Vector2D;

/** A base collision class shape */
class Shape {


        /** The state of this shape, if inactive can be ignored in results */
    public var active : Bool = true;
        /** The name of this shape, to help in debugging */
    public var name : String = 'shape';
        /** A generic data object where you can store anything you want, for later use */
    public var data : Dynamic;
        /** A list of tags to use for marking shapes with data for later use, by key/value */
    public var tags : Map<String, String>;
        /** The position of this shape */
    public var position ( get, set ) : Vector2D;
        /** The x position of this shape */
    public var x ( get, set ) : Float;
        /** The y position of this shape */
    public var y ( get, set ) : Float;
        /** The rotation of this shape, in degrees */
    public var rotation ( get, set ) : Float;
        /** The scale in the x direction of this shape */
    public var scaleX ( get, set ) : Float;
        /** The scale in the y direction of this shape */
    public var scaleY ( get, set ) : Float;
        /** The transformed (rotated/scale) vertices cache */
    public var transformedVertices ( get, never ) : Array<Vector2D>;
        /** The vertices of this shape */
    public var vertices ( get, never ) : Array<Vector2D>;


    var _position : Vector2D;
    var _rotation : Float = 0;

    var _scaleX : Float = 1;
    var _scaleY : Float = 1;

    var _transformed : Bool = false;
    var _transformMatrix : Matrix;

    var _transformedVertices : Array<Vector2D>;
    var _vertices : Array<Vector2D>;


//Public API


        /** Create a new shape at give position x,y */
    public function new( _x:Float, _y:Float ) {

        tags = new Map();

        _position = new Vector2D(_x,_y);
        _rotation = 0;

        _scaleX = 1;
        _scaleY = 1;

        _transformMatrix = new Matrix();
        _transformMatrix.tx = _position.x;
        _transformMatrix.ty = _position.y;

        _transformedVertices = new Array<Vector2D>();
        _vertices = new Array<Vector2D>();

    } //new

        /** clean up and destroy this shape */
    public function destroy():Void {
    
        _position = null;
    
    } //destroy

//.position

    function get_position() : Vector2D {
        return _position;
    }

    function set_position( v : Vector2D ) : Vector2D {
        _transformMatrix.tx = v.x;
        _transformMatrix.ty = v.y;
        _position = v;
        _transformed = false;
        return _position;
    }

//.x 

    function get_x() : Float {
        return _position.x;
    }
    
    function set_x(x : Float) : Float {
        _position.x = x;
        _transformMatrix.tx = x;
        _transformed = false;
        return _position.x;
    }
    
//.y

    function get_y() : Float {
        return _position.y;
    }
    
    function set_y(y : Float) : Float {
        _position.y = y;
        _transformMatrix.ty = y;
        _transformed = false;
        return _position.y;
    }    

//.rotation 

    function get_rotation() : Float {
        return _rotation;
    }

    function set_rotation( v : Float ) : Float {
        _transformMatrix.rotate( (v - _rotation) * Math.PI / 180 );
        _rotation = v;
        _transformed = false;
       return _rotation;
    }

//.scaleX 

    function get_scaleX():Float {
        return _scaleX;
    }
    
    function set_scaleX( scale : Float ) : Float {
        _scaleX = scale;
        _transformMatrix.scale( _scaleX, _scaleY );
        _transformed = false;
        return _scaleX;
    }

//.scaleY

    function get_scaleY():Float {
        return _scaleY;
    }
    
    function set_scaleY(scale:Float) : Float {
        _scaleY = scale;
        _transformMatrix.scale( _scaleX, _scaleY );
        _transformed = false;
        return _scaleY;
    }    

//.transformedVertices

    function get_transformedVertices() : Array<Vector2D> {

        if(!_transformed) {
            _transformedVertices = new Array<Vector2D>();
            _transformed = true;

            var _count : Int = _vertices.length;

            for(i in 0..._count) {
                _transformedVertices.push( _vertices[i].transform( _transformMatrix ) );
            }
        }

        return _transformedVertices;
    }

//.vertices 

    function get_vertices() : Array<Vector2D> {
        return _vertices;
    }

    
}
