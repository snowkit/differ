
import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.Lib;

import hxcollision.math.Vector;
import hxcollision.shapes.Shape;
import hxcollision.shapes.Circle;
import hxcollision.shapes.Polygon;
import hxcollision.CollisionData;
import hxcollision.Collision;
import hxcollision.OpenFLDrawer;

class Main extends Sprite {

        //For viewing the collision states
    var drawer : OpenFLDrawer;
    var visualise : Sprite;

    var collide_color : Int = 0x62ea93;
    var separation_color : Int = 0xff4b03;
    var normal_color : Int = 0x72846c;
    var player_color : Int = 0x72846c;

        //A few static shapes to test against
    var box_static : Polygon;
    var oct_static : Polygon;
    var circle_static : Circle;
    var hexagon_static : Polygon;
    var triangle_static : Polygon;

    var static_list : Array<Shape>;

        //"player" collider
    var player_collider : Shape;
    var player_vel : Vector;
    var move_speed : Float = 2;

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

            //Create the collider shapes
        box_static = Polygon.rectangle( 0, 0, 50, 150 );
        oct_static = Polygon.create( 120,120, 8,60 );
        circle_static = new Circle( 375, 280, 50 );        
        hexagon_static = Polygon.create( 290,100, 6, 50 );
        triangle_static = Polygon.triangle( 300,400, 60 );

        static_list = [box_static, oct_static, circle_static, hexagon_static, triangle_static];

            //player
        player_collider = new Circle( 250, 250, 15 );

            //remember the order of operations is important
        box_static.rotation = 45;
        box_static.x = 150;
        box_static.y = 300;

        player_vel = new Vector(0,0);

            //caption
        var inputFormat = new flash.text.TextFormat();
            inputFormat.font = "Helvetica, sans-serif";
            inputFormat.color = separation_color;
        var textField = new flash.text.TextField();
            textField.defaultTextFormat = inputFormat;
            textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            textField.mouseEnabled = false;
            textField.width = stage.stageWidth;
            textField.text = "[ENTER] TO SWITCH PLAYER SHAPE\n" +
                             "[SPACE] TO RESET PLAYER POSITION\n" +
                             "[ARROWS] TO MOVE THE PLAYER";

        stage.addChild(textField);

            //Listen for the changes in mouse movement
        stage.addEventListener( flash.events.KeyboardEvent.KEY_DOWN, keydown );
        stage.addEventListener( flash.events.KeyboardEvent.KEY_UP, keyup );


            //And finally, listen for updates.
        addEventListener( Event.ENTER_FRAME, update );

    } //construct

    var up : Bool = false;
    var left : Bool = false;
    var right : Bool = false;
    var down : Bool = false;

    public function keydown( e : flash.events.KeyboardEvent ) {
        switch(e.keyCode) {
            case 32: //reset player position when pressing [SPACE]
                player_collider.x = 250;
                player_collider.y = 250;
            case 37: left = true;
            case 38: up = true;
            case 39: right = true;
            case 40: down = true;
            case 13: //switch player shape when pressing [ENTER]
                if( Std.is(player_collider, Polygon ) )
                    player_collider = new Circle( player_collider.x,
                                                  player_collider.y,
                                                  15 );
                else
                    player_collider = Polygon.create( player_collider.x,
                                                      player_collider.y,
                                                      7, 15 );
                
        }
    } //keydown

    public function keyup( e : flash.events.KeyboardEvent ) {
        switch(e.keyCode) {
            case 37: left = false;
            case 38: up = false;
            case 39: right = false;
            case 40: down = false;
        }
    } //keyup

    var end_dt : Float = 0;
    var dt : Float = 0;

    public function update( e:Event ) {

        dt = haxe.Timer.stamp() - end_dt;
        end_dt = haxe.Timer.stamp();

            //start clean each update
        visualise.graphics.clear();

//Update player velocity and input

        if(left)    { player_vel.x = -move_speed; }
        if(right)   { player_vel.x = move_speed; }
        if(up)      { player_vel.y = -move_speed; }
        if(down)    { player_vel.y = move_speed; }

//First update the player collider position
    
            //we calculate "future" position without
            //changing the current position, that way
            //we can cancel or negative movement easily
            //without losing track of what we are doing,
            //but it starts with where we are now
        var next_pos_x = player_collider.x;
        var next_pos_y = player_collider.y;

            //here we apply what would happen, if no
            //collision was occuring, THEN do collision and subvert it
        next_pos_x += player_vel.x;
        next_pos_y += player_vel.y;

            //start at normal color
        player_color = separation_color;

            //now check for collisions against the static items
        var results = Collision.testShapes(player_collider, static_list);
            //handle any potential collisions by separating the items
        for(_result in results) {
            player_color = collide_color;
            next_pos_x += _result.separation.x;
            next_pos_y += _result.separation.y;
        }

//Finally, Update the collider position
        
        player_collider.x = next_pos_x;
        player_collider.y = next_pos_y;

//Draw everything

        visualise.graphics.lineStyle( 1, normal_color );

            drawer.drawCircle( circle_static );
            drawer.drawPolygon( box_static );
            drawer.drawPolygon( hexagon_static );
            drawer.drawPolygon( oct_static );
            drawer.drawPolygon( triangle_static );

        visualise.graphics.lineStyle();


            //draw where the player is right now

        visualise.graphics.beginFill(player_color);
            if( Std.is(player_collider, Circle) )
                drawer.drawCircle( cast (player_collider, Circle) );
            else
                drawer.drawPolygon( cast(player_collider, Polygon) );
        visualise.graphics.endFill();

//Apply drag
        
        player_vel.x *= 0.75;
        player_vel.y *= 0.75;

        if(Math.abs(player_vel.x) < 0.1) { player_vel.x = 0; }
        if(Math.abs(player_vel.y) < 0.1) { player_vel.y = 0; }

    } //update


   public static function main () {
        var test = new Main();
        Lib.current.addChild(test);
    } //entry point

} //Main 

