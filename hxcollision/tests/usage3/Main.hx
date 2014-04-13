
import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.Lib;

import hxcollision.math.Vector2D;
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

        //Shows number of entities
    var caption : flash.text.TextField;

        //Shapes/speed containers
    var allshapes_list : Array<Shape> = new Array();
    var dynamic_list : Array<Shape> = new Array();
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
        allshapes_list.push( box );
        allshapes_list.push( Polygon.create( 320,100, 6, 50 ) );
        allshapes_list.push( new Circle( 350, 400, 50 ) );
        allshapes_list.push( Polygon.create( 220,300, 9,60 ) );
        allshapes_list.push( new Circle( 150, 450, 50 ) );

            //caption
        var inputFormat = new flash.text.TextFormat();
        inputFormat.font = "Helvetica, sans-serif";
        inputFormat.color = 0xd04648;
        caption = new flash.text.TextField();
        caption.defaultTextFormat = inputFormat;
        caption.autoSize = flash.text.TextFieldAutoSize.LEFT;
        caption.mouseEnabled = false;
        caption.width = stage.stageWidth;
        stage.addChild( caption );

            //theming the fps counter
        var fps = new openfl.display.FPS();
        fps.x = 0; fps.y += 2;
        fps.defaultTextFormat = inputFormat;
        stage.addChild( fps );

            //timer to spawn dynamic collider shapes at the top of the screen
        var shape_timer:flash.utils.Timer = new flash.utils.Timer(500, 0);
        shape_timer.addEventListener( flash.events.TimerEvent.TIMER, addRandomShape );
        shape_timer.start();

            //And finally, listen for updates.
        addEventListener( Event.ENTER_FRAME, update );

    } //construct

        //Add random shapes from top of the stage
    function addRandomShape( e:flash.events.TimerEvent ) {

        var shape : Shape;
        var size : Int;
        var start_x : Int;

        size = Std.random(15) + 10;
        start_x = 90;

            //randomly spawn Circle or Polygon
        (Std.random(2) == 0) ?
            shape = new Circle( start_x,-50, size ):
            shape = Polygon.create( start_x,-50, 9,size );

        dynamic_list.push( shape );
        allshapes_list.push( shape );
        speeds.push( Std.random(6) + 1 );
    }

    var end_dt : Float = 0;
    var dt : Float = 0;

    public function update( e:Event ) {

        dt = haxe.Timer.stamp() - end_dt;
        end_dt = haxe.Timer.stamp();

        var shape : Shape;

            //update number of entities in caption
        caption.text = "STRESS TEST : " + dynamic_list.length + " shapes";

            //collision handling
        var i = dynamic_list.length;
        while(i-- > 0) { //iterating backwards so that i can remove shape in the meantime
            shape = dynamic_list[i];
            shape.y += speeds[i];

            var results = Collision.testShapeList( shape, allshapes_list );

            for(result in results)
            {
                    //ignore collision on ourself
                if(result.shape2 == shape) continue;

                    //applies correction
                shape.x += result.separation.x;
                shape.y += result.separation.y;

            }

                //remove the shape if outside of the viewport
            if(shape.y > stage.stageHeight + 50) {
                dynamic_list.remove(shape);
                allshapes_list.remove(shape);
            }
        }
    
            //start clean each update
        visualise.graphics.clear();

            //shapes theming
        visualise.graphics.lineStyle( 2, 0x757161 );

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

