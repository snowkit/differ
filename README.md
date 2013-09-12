#hxcollision : SAT collision for Haxe

##Test / demo

- [Flash Demo](http://underscorediscovery.com/sven/hxcollision)

## Facts

- This is a port of Separating Axis Theorem, for collision detection between shapes.
- **not specific to OpenFL**
- Supports polygons and circles, currently.
- Includes a drawing class for seeing shapes with OpenFL
- See tests/ for a OpenFL ready test project.
- **COLLISION ONLY.** No physics here. By design :)
- Contributions welcome

## Notes

- [Original code ported from rocketmandevelopment blog](http://rocketmandevelopment.com/2010/05/19/separation-of-axis-theorem-for-collision-detection/)
- For usage examples, look inside /tests/

## Getting Started

`haxelib install hxcollision`

or git clone the repo, from here.

#Recent changes

**1.0.3**
 - Fixed bug in circle vs polygon, when polygon was rotated.
 - Added line raycast with collision shapes
 - Added a custom ShapeDrawer class, for drawing the shapes in a non specific way. 
 - Moved to latest haxelib revisions
 - Removed dependency on OpenFL, now completely standalone 
 
**1.0.2**
 - uncommitted internal fixes

**1.0.1**
 - Added an option for Polygon.rectangle() to be non-centered
 
**1.0.0** 
 - Initial project pull and compile/port, functional
