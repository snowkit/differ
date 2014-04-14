#hxcollision : SAT collision for Haxe

##Demo

- [current demo](http://underscorediscovery.com/sven/hxcollision/wip)

## Facts

- This is a port of Separating Axis Theorem, for collision detection between shapes.
- Supports polygons and circles, currently.
- Includes a simple drawing interface for debugging shapes
- **COLLISION ONLY.** No physics here. By design :)
- Contributions welcome

###Other notes 

- **not specific to OpenFL**
- See tests/ for a OpenFL ready test project.
- Includes a drawing class for seeing shapes with OpenFL

## More Notes

- [Original code ported from rocketmandevelopment blog](http://rocketmandevelopment.com/2010/05/19/separation-of-axis-theorem-for-collision-detection/)
- For usage examples, look inside /tests/

## Getting Started

`haxelib install hxcollision`

or git clone the repo, from here.

#Recent changes

**1.0.5 (Latest repo)**
 - Renamed `BaseShape` to `Shape`, continued refactoring
 - Fixed various bugs in collisions
 - Fixed `separation`/`unitVector` behaviour (signs bugs)
 - Fixed bug with `Polygon`/`Polygon` collisions not returning best vectors 
 - Fixed bug where you couldn't `beginFill` using `OpenFLDrawer`
 - Fixed `collisionData` in `CheckCircles`, shape2 wasn't assigned.
 - `separation`/`unitVector` is now bound to shape1
 - Added 2 samples (usage2 & usage3)
 - Added `drawVector` in `OpenFLDrawer` showing vector direction
 - Added `drawShape` in `ShapeDrawer`, will cast proper types and call appropriate drawing functions.

**1.0.4 (Latest release, haxelib)**
 - Renamed `Polygon.normalPolygon` to `Polygon.create`
 - Added `testShapeList` for testing one shape with many
 - Added changes to the test to display the `unitVector` response (soon to be renamed also)
 - Migrating to more integration friendly api, and more logical order of arguments for shapes. 
 - Making rotation on the base shapes absolute (submitted by @grapefrukt). 
 - Adding name and data flag to `BaseShape`

**1.0.3**
 - Fixed bug in circle vs polygon, when polygon was rotated.
 - Added line raycast with collision shapes
 - Added a custom `ShapeDrawer` class, for drawing the shapes in a non specific way. 
 - Moved to latest haxelib revisions
 - Removed dependency on OpenFL, now completely standalone 
 
**1.0.2**
 - uncommitted internal fixes

**1.0.1**
 - Added an option for `Polygon.rectangle()` to be non-centered
 
**1.0.0** 
 - Initial project pull and compile/port, functional
