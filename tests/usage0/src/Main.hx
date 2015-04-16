
import luxe.Input;
import luxe.Vector;
import luxe.Text;

import differ.shapes.Shape;
import differ.shapes.Ray;

class Main extends luxe.Game {

        //shared conveniences for the states
    public static var drawer: LuxeDrawer;
    public static var shapes: Array<Shape>;
    public static var rays: Array<Ray>;
    static var disp : Text;

        //main specifics
    var desc : Text;
    var state : luxe.States;
    var current : Int = 0;
    var count : Int = 0;

    override function config(config:luxe.AppConfig) {

        config.render.antialiasing = 8;
        return config;

    } //config

    override function ready() {

        Luxe.renderer.batcher.add_group(0,
            function(_) {
                Luxe.renderer.state.lineWidth(2);
            },
            function(_) {
                Luxe.renderer.state.lineWidth(1);
            });

        drawer = new LuxeDrawer();
        shapes = [];
        rays = [];

        desc = new Text({
            pos: new Vector(10,10),
            point_size: 18,
            text: 'differ usage examples, press 1 or 2 to cycle'
        });

        disp = new Text({
            pos: new Vector(10, 30),
            point_size: 15,
            text: 'usage text goes here'
        });

        state = new luxe.States({ name:'machine' });

        state.add( new states.RayAndShape({ name:'state0' }) );

        count = Lambda.count( state._states );
        state.set( 'state0' );

    } //ready

    public static function display(text:String) {
        disp.text = text;
    }

    function change(to:String) {
        shapes = [];
        rays = [];
        disp.text = '';
        state.set(to);
    }

    override function onkeyup( e:KeyEvent ) {

        if(e.keycode == Key.key_1) {
            current--;
            if(current <= count) current = count-1;
            change('state$current');
        }

        if(e.keycode == Key.key_2) {
            current++;
            if(current >= count) current = 0;
            change('state$current');
        }

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup

    override function onrender() {
        for(shape in shapes) drawer.drawShape(shape);
        for(ray in rays) drawer.drawLine(ray.start, ray.end);
    }

} //Main
