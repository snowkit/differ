
import nme.display.Graphics;
import nme.display.Sprite;
import nme.events.Event;
import nme.geom.Point;
import nme.Lib;

import hxcollision.math.Vector2D;
import hxcollision.shapes.BaseShape;
import hxcollision.shapes.Circle;
import hxcollision.shapes.Polygon;
import hxcollision.CollisionData;
import hxcollision.Collision;
import hxcollision.OpenFLDrawer;





class Main extends Sprite {

        //For viewing the collision states
    var drawer : OpenFLDrawer;
    var visualise : Sprite;
    var collide_color : Int = 0xCC1111;
    var collide_color2 : Int = 0x2233CC;
    var collide_color3 : Int = 0x11CC88;
    var collide_color4 : Int = 0xCC00CC;
    var normal_color : Int = 0x999999;

    var mouse_pos : Point;
    var mouse_is_box : Bool = false;

        //A few static shapes to test against
    var circle_static : Circle;
    var box_static : Polygon;
        //A circle that follows the mouse
    var circle_mouse : Circle;
    var box_mouse : Polygon;

        //a raycast line
    var line_start : Vector2D;
    var line_end : Vector2D;
    var line_y : Float = 0;
    var line_dir : Int = 1;

        //A collision data object for the mouse circle
    var mouse_collide : CollisionData;
    var line_collide = false;

    public function new() {

        super();

        addEventListener (Event.ADDED_TO_STAGE, construct);   

    }
    public function construct(e: Event) {        

            //Our debug view
        drawer = new OpenFLDrawer();
        visualise = new Sprite();
        drawer.graphics = visualise.graphics;

        addChild( visualise );

            //Init
        mouse_pos = new Point();

            //Create a bit of a space to play in 
        circle_static = new Circle( 50, new Vector2D(300,200) );
        circle_mouse = new Circle( 30, new Vector2D(250,250) );
        box_static = Polygon.rectangle(50,150, new Vector2D(0,0) );
        box_mouse = Polygon.normalPolygon(6, 50, new Vector2D(250,100) );

            //Variety
        box_static.rotation = 45;
        box_static.x = 150;
        box_static.y = 300;

            //our little line for the raycast tests
        line_start = new Vector2D(0,0);
        line_end = new Vector2D(500,0);

            //Listen for the changes in mouse movement
        stage.addEventListener (nme.events.MouseEvent.MOUSE_MOVE, mousemove);
        stage.addEventListener (nme.events.MouseEvent.CLICK, mousedown);

            //Finally, hook up the event for updating.
        addEventListener( Event.ENTER_FRAME, update );

    }

    public function mousedown( e : nme.events.MouseEvent ) {
        mouse_is_box = !mouse_is_box;
    }

    public function mousemove( e : nme.events.MouseEvent ) {

        mouse_pos.x = e.stageX;
        mouse_pos.y = e.stageY;

        if(!mouse_is_box) {
            circle_mouse.x = mouse_pos.x;
            circle_mouse.y = mouse_pos.y;
        } else {
            box_mouse.x = mouse_pos.x;
            box_mouse.y = mouse_pos.y;
        }

    }

    var end_dt : Float = 0;
    var dt : Float = 0;

    public function update( e:Event ) {

        dt = haxe.Timer.stamp() - end_dt;
        end_dt = haxe.Timer.stamp();

            //move the line downward
        line_y += 50 * line_dir * dt;

        if(line_dir == 1 && line_y >= 500) {    
            line_dir = -1;
        } else if(line_dir == -1 && line_y <= 0) {
            line_dir = 1;
        }

        line_start.y = line_y;
        line_end.y = line_y;

        //draw things
        var mouse_color : Int = normal_color;

        visualise.graphics.clear();

            //Test the static circle
        if(!mouse_is_box) {
            
            mouse_collide = Collision.testShapes( circle_static, circle_mouse );

            if(mouse_collide != null) {
                mouse_color = collide_color;
            }

        } else {
            mouse_collide = Collision.testShapes( circle_static, box_mouse );

            if(mouse_collide != null) {
                mouse_color = collide_color;
            }

        }

            //Test the static box
        if(!mouse_is_box) {
            
            mouse_collide = Collision.testShapes( box_static, circle_mouse );

            if(mouse_collide != null) {
                mouse_color = collide_color2;
            }

        } else {
            mouse_collide = Collision.testShapes( box_static, box_mouse );

            if(mouse_collide != null) {
                mouse_color = collide_color2;
            }
            
        }
            
            //Test mouse box and circle
        mouse_collide = mouse_collide = Collision.testShapes( circle_mouse, box_mouse );        
        if(mouse_collide != null) {
            mouse_color = collide_color3;
        }

        visualise.graphics.lineStyle( 2, normal_color );

            drawer.drawCircle( circle_static );
            drawer.drawPolygon( box_static );
            drawer.drawPolygon( box_mouse );

            if(!mouse_is_box) {
                drawer.drawPolygon( box_mouse );
            } else {
                drawer.drawCircle( circle_mouse );
            }

        visualise.graphics.lineStyle( 2, mouse_color );

            if(!mouse_is_box) {
                drawer.drawCircle( circle_mouse );
            } else {
                drawer.drawPolygon( box_mouse );
            }

            //test the line raycasting

        visualise.graphics.lineStyle( 2, normal_color );

            line_collide = Collision.rayCollision(line_start, line_end, [box_static, box_mouse, circle_static, circle_mouse]);
            if(line_collide) {
                visualise.graphics.lineStyle( 2, collide_color4 );
            } 

            drawer.drawLine(line_start, line_end);

    }



   public static function main () {
        var test = new Main();
        Lib.current.addChild(test);
    }

}