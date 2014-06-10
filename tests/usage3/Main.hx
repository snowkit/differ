
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

    var last_add_time : Float = haxe.Timer.stamp();

        //Shows number of entities
    var caption : flash.text.TextField;

        //Shapes/speed containers
    var allshapes_list : Array<Shape> = new Array();
    var dynamic_list : Array<Shape> = new Array();
    var static_list : Array<Shape> = new Array();
    var speeds : Array<Float> = new Array();

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

            //Create the static collider shapes
        var box = Polygon.rectangle( 140, 80, 150, 50 );
        box.rotation = 20;
        static_list.push( box );
        static_list.push( Polygon.create( 320,100, 6, 50 ) );
        static_list.push( new Circle( 350, 400, 50 ) );
        static_list.push( Polygon.create( 220,300, 9,60 ) );
        static_list.push( new Circle( 150, 450, 50 ) );

        allshapes_list = static_list.copy();

            //caption
        var inputFormat = new flash.text.TextFormat();
            inputFormat.font = "Helvetica, sans-serif";
            inputFormat.color = 0xff4b03;
        caption = new flash.text.TextField();
            caption.defaultTextFormat = inputFormat;
            caption.autoSize = flash.text.TextFieldAutoSize.LEFT;
            caption.mouseEnabled = false;
            caption.width = stage.stageWidth;
            caption.text = "COLLISION RESOLUTION STRESS TEST";
        stage.addChild( caption );

            //And finally, listen for updates.
        addEventListener( Event.ENTER_FRAME, update );

    } //construct

        //Add random shapes from top of the stage
    function addRandomShape( ) {

        var shape : Shape;
        var size : Int;
        var start_x : Int;
        var start_y : Int;
        var random_shapes : Array<Shape>;

        size = Std.random(15) + 10;
        start_x = 90;
        start_y = -50;

            //specify shapes to be randomly spawned
        random_shapes = [new Circle( start_x, start_y, size ),
                         Polygon.create( start_x, start_y, 9, size ),
                         Polygon.triangle( start_x, start_y, size )];

            //randomly select a shape
        shape = random_shapes[Std.random(3)];

        dynamic_list.push( shape );
        allshapes_list.push( shape );
        speeds.push( Std.random(6) + 1 );

    } //addRandomShape

    var end_dt : Float = 0;
    var dt : Float = 0;

    public function update( e:Event ) {

        var results : Array<CollisionData>;
        var shape : Shape;

        dt = haxe.Timer.stamp() - end_dt;
        end_dt = haxe.Timer.stamp();

            //timer to spawn dynamic shapes at the top of the screen
        if(haxe.Timer.stamp() - last_add_time > 1) {
            addRandomShape();
            last_add_time = haxe.Timer.stamp();
        }

            //collision handling
        var i = dynamic_list.length;
        while(i-- > 0) { //iterating backwards so that i can remove shape in the meantime
            shape = dynamic_list[i];
            shape.y += speeds[i];

                //collision against other moving shapes
            results = Collision.testShapes( shape, dynamic_list );

            for(result in results)
            {
                    //ignore collision on ourself
                if(result.shape2 == shape) continue;

                    //applies correction
                shape.x += result.separation.x / 2;
                shape.y += result.separation.y / 2;

                result.shape2.x -= result.separation.x / 2;
                result.shape2.y -= result.separation.y / 2;
            }

                //collision against static shapes
            results = Collision.testShapes( shape, static_list );

            for(result in results) {
                    //applies correction
                shape.x += result.separation.x;
                shape.y += result.separation.y;
            }

                //remove the shape if outside of the viewport
            if(shape.y > stage.stageHeight + 50) {
                dynamic_list.remove(shape);
                allshapes_list.remove(shape);
                speeds.remove(speeds[i]);
            }
        }
    
            //start clean each update
        visualise.graphics.clear();

            //shapes theming
        visualise.graphics.lineStyle( 2, 0x72846c );

            //draw all the shapes
        for(shape in allshapes_list) {
            drawer.drawShape(shape);
        }

    } //update


   public static function main () {
        var test = new Main();
        Lib.current.addChild(test);
    } //entry point

} //Main 

