
import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.Lib;

import hxcollision.math.Vector;
import hxcollision.shapes.Shape;
import hxcollision.shapes.Circle;
import hxcollision.shapes.Polygon;
import hxcollision.data.CollisionData;
import hxcollision.Collision;
import hxcollision.OpenFLDrawer;

class Main extends Sprite {

        //For viewing the collision states
    var drawer : OpenFLDrawer;
    var visualise : Sprite;

        //for viewing when collisions happen, we change colors
    var normal_color : Int = 0x72846c;
    var collide_color : Int = 0x62ea93;
    var separation_color : Int = 0xff4b03;

        //the mouse position
    var mouse_pos : Point;
        //whether we are using the box or polygon as the mouse
    var mouse_is_hexagon : Bool = false;

        //A few static shapes to test against
    var circle_static : Circle;
    var box_static : Polygon;
    var oct_static : Polygon;
    var triangle_static : Polygon;
    var custom_static : Polygon;

        //A circle that can follow the mouse
    var circle_mouse : Circle;
        //A polygon that can follow the mouse
    var hexagon_mouse : Polygon;
        //Default mouse shape
    var shape_mouse : Shape;

        //A line to raycase across the screen
    var line_start : Vector;
    var line_end : Vector;
        //For movint the line, the current y position and movement direction
    var line_y : Float = 0;
    var line_dir : Int = 1;

        //A collision data object for the current mouse shape
    var mouse_collide : CollisionData;
        //True if there is a collision with the line and any shape
    var line_collide = false;

    public function new() {

        super();

        addEventListener(Event.ADDED_TO_STAGE, construct);

    } //new

    public function construct(e: Event) {        

            //Our debug view
        visualise = new Sprite();
            //the shape drawer
        drawer = new OpenFLDrawer( visualise.graphics );
            //add to the stage so we can see it
        addChild( visualise );


        mouse_pos = new Point();

            //Create the collider shapes
        circle_static = new Circle( 300, 200, 50 );        
        box_static = Polygon.rectangle( 0, 0, 50, 150 );
        oct_static = Polygon.create( 70,90, 8,60 );
        triangle_static = Polygon.triangle( 400,300, 60 );
        custom_static = new Polygon(325, 400, [new Vector(-100, 0),
                                               new Vector(-75, -50),
                                               new Vector(75, -50),
                                               new Vector(100, 0),
                                               new Vector(75, 50),
                                               new Vector(-75, 50)]);
            //and the noes that will follow the mouse
        circle_mouse = new Circle( 250, 250, 30 );
        hexagon_mouse = Polygon.create( 260,100, 6, 50 );
        shape_mouse = circle_mouse;

            //remember the order of operations is important
        box_static.rotation = 45;
        box_static.x = 150;
        box_static.y = 300;

            //the horizontal line for the raycast tests, 
            //starting at the top of the screen
        line_start = new Vector(0,0);
        line_end = new Vector(500,0);

            //caption
        var inputFormat = new flash.text.TextFormat();
            inputFormat.font = "Helvetica, sans-serif";
            inputFormat.color = separation_color;
        var textField = new flash.text.TextField();
            textField.defaultTextFormat = inputFormat;
            textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            textField.mouseEnabled = false;
            textField.width = stage.stageWidth;
            textField.text = " CLICK TO SWITCH MOUSE SHAPE";
            stage.addChild(textField);

            //Listen for the changes in mouse movement
        stage.addEventListener( flash.events.MouseEvent.MOUSE_MOVE, mousemove );
        stage.addEventListener( flash.events.MouseEvent.CLICK, mousedown );

            //And finally, listen for updates.
        addEventListener( Event.ENTER_FRAME, update );

    } //construct

    public function mousedown( e : flash.events.MouseEvent ) {

        (mouse_is_hexagon) ?
            shape_mouse = circle_mouse:
            shape_mouse = hexagon_mouse;
        mouse_is_hexagon = !mouse_is_hexagon;

            //Triggers mousemove in order to move the shape
            //before actually moving the mouse
        mousemove(e);

    } //mousedown

    public function mousemove( e : flash.events.MouseEvent ) {

        mouse_pos.x = e.stageX;
        mouse_pos.y = e.stageY;

        shape_mouse.x = mouse_pos.x;
        shape_mouse.y = mouse_pos.y;

    } //mousemove

    public function update_line() {

        line_start.x = circle_mouse.x;
        line_start.y = circle_mouse.y;

        line_end.x = hexagon_mouse.x;
        line_end.y = hexagon_mouse.y;

    } //update_line

    public function draw_collision_response( collision_response:CollisionData ) {

        var shape1_origin : Vector;
        var shape1_unit_vector : Vector;
        var shape1_target : Vector;
        var shape1_separation : Vector;

        var shape2_origin : Vector;
        var shape2_unit_vector : Vector;
        var shape2_target : Vector;
        var shape2_separation : Vector;

            //draw the unit vector pointing to the colliding shape
        visualise.graphics.lineStyle( 1, collide_color );
            shape1_origin = collision_response.shape1.position;
            shape1_unit_vector = collision_response.unitVector;
            shape1_target = new Vector( shape1_origin.x+(shape1_unit_vector.x*20), shape1_origin.y+(shape1_unit_vector.y*20) );
            drawer.drawVector( shape1_origin, shape1_target );

            shape2_origin = collision_response.shape2.position;
            shape2_unit_vector = shape1_unit_vector.invert();
            shape2_target = new Vector( shape2_origin.x+(shape2_unit_vector.x*20), shape2_origin.y+(shape2_unit_vector.y*20) );
            drawer.drawVector( shape2_origin, shape2_target );

            //draw the separation vector pointing to the opposite direction of the colliding shape
        visualise.graphics.lineStyle( 1, separation_color );
            shape1_separation = collision_response.separation;
            shape1_target = new Vector( shape1_origin.x+(shape1_separation.x), shape1_origin.y+(shape1_separation.y) );
            drawer.drawVector( shape1_origin, shape1_target );

            shape2_separation = shape1_separation.invert();
            shape2_target = new Vector( shape2_origin.x+(shape2_separation.x), shape2_origin.y+(shape2_separation.y) );
            drawer.drawVector( shape2_origin, shape2_target );

    } //draw_collision_response

    var end_dt : Float = 0;
    var dt : Float = 0;

    public function update( e:Event ) {

        dt = haxe.Timer.stamp() - end_dt;
        end_dt = haxe.Timer.stamp();

            update_line();

            //draw things
        var mouse_color : Int = normal_color;
        var circle_color : Int = normal_color;
        var circle2_color : Int = normal_color;
        var box_color : Int = normal_color;
        var triangle_color : Int = normal_color;
        var hexa_color : Int = normal_color;
        var oct_color : Int = normal_color;
        var custom_color : Int = normal_color;

            //start clean each update
        visualise.graphics.clear();

//Test the static circle

        mouse_collide = Collision.test( shape_mouse, circle_static );

        if(mouse_collide != null) {
            mouse_color = collide_color;
            circle_color = collide_color;
            draw_collision_response(mouse_collide);
        }

//Test the static octagon

        mouse_collide = Collision.test( shape_mouse, oct_static );

        if(mouse_collide != null) {
            mouse_color = collide_color;
            oct_color = collide_color;
            draw_collision_response(mouse_collide);
        }

//Test the static box

        mouse_collide = Collision.test( shape_mouse, box_static );

        if(mouse_collide != null) {
            mouse_color = collide_color;
            box_color = collide_color;
            draw_collision_response(mouse_collide);
        }

//Test the static triangle

        mouse_collide = Collision.test( shape_mouse, triangle_static );

        if(mouse_collide != null) {
            mouse_color = collide_color;
            triangle_color = collide_color;
            draw_collision_response(mouse_collide);
        }

//Test the static custom polygon

        mouse_collide = Collision.test( shape_mouse, custom_static );

        if(mouse_collide != null) {
            mouse_color = collide_color;
            custom_color = collide_color;
            draw_collision_response(mouse_collide);
        }

//Test mouse box and circle

        if(mouse_is_hexagon) {

            mouse_collide = Collision.test( shape_mouse, circle_mouse );

            if(mouse_collide != null) {
                mouse_color = collide_color;
                circle2_color = collide_color;
                draw_collision_response(mouse_collide);
            }

        } else { //mouse_is_hexagon

            mouse_collide = Collision.test( shape_mouse, hexagon_mouse );

            if(mouse_collide != null) {
                mouse_color = collide_color;
                hexa_color = collide_color;
                draw_collision_response(mouse_collide);
            }
        } //!mouse_is_hexagon else

//Test the line and all the shapes

        line_collide = Collision.ray( line_start, line_end, 
                [ box_static, circle_static, oct_static, triangle_static, custom_static ]);

//Now draw them

        visualise.graphics.lineStyle( 2, circle_color );
            drawer.drawCircle( circle_static );
        visualise.graphics.lineStyle( 2, circle2_color );
            drawer.drawCircle( circle_mouse );
        visualise.graphics.lineStyle( 2, box_color );
            drawer.drawPolygon( box_static );
        visualise.graphics.lineStyle( 2, triangle_color );
            drawer.drawPolygon( triangle_static );
        visualise.graphics.lineStyle( 2, hexa_color );
            drawer.drawPolygon( hexagon_mouse );
        visualise.graphics.lineStyle( 2, oct_color );
            drawer.drawPolygon( oct_static );
        visualise.graphics.lineStyle( 2, custom_color );
            drawer.drawPolygon( custom_static );

        if(mouse_is_hexagon) {
            visualise.graphics.lineStyle( 2, mouse_color );
            drawer.drawPolygon( hexagon_mouse );
        } else {
            visualise.graphics.lineStyle( 2, mouse_color );
            drawer.drawCircle( circle_mouse );
        }

        visualise.graphics.lineStyle( 2, normal_color );

            if(line_collide) {
                visualise.graphics.lineStyle( 2, collide_color );
            } 

            drawer.drawLine(line_start, line_end);

    } //update


   public static function main () {
        var test = new Main();
        Lib.current.addChild(test);
    } //entry point

} //Main 

