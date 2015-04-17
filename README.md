
[![Logo](docs/images/logo.png)](./index.html)

---
## What is differ?

A [Separating Axis Theorom](http://en.wikipedia.org/wiki/Hyperplane_separation_theorem) collision library for [haxe](http://haxe.org)

[ ![haxe](docs/images/haxe.png) ](http://haxe.org)

----

##View docs info and more

https://underscorediscovery.github.io/differ/

##Demos


##Previous Demos (being updated)

- [demo 1](http://underscorediscovery.com/sven/hxcollision/usage1)
- [demo 2](http://underscorediscovery.com/sven/hxcollision/usage2)
- [demo 3](http://underscorediscovery.com/sven/hxcollision/usage3)

---

#History

**1.2.0 (github dev)**

 The biggest change for sure, renamed `hxcollision` to `differ`
 Now that the library is getting more use its better to have a consistent name
 and to have a more explicit path. Think of "differ" as a diff tool for shapes/rays, 
 it tells you how shapes differ (i.e the separation).

 - Added ray intersection information, rather than just true/false
 - Added ray vs ray intersection with info on overlap
 - Added more granular tests, that will expand further
    - New test case uses luxe http://luxeengine.com/
    - hxcollision/differ was born for luxe.collision, separate for any framework
 - **Refactor** continued separating code for future 3D vs 2D
    - moved all internal 2D code into differ.sat.SAT2D
    - moved all internal common code into differ.sat.Common
 - **Renamed** `Collision.test` to `Collision.shapeWithShape`
 - **Renamed** `Collision.testShapes` to `Collision.shapeWithShapes`
 - **Renamed** `Collision.rayShape` to `Collision.rayWithShape`
 - **Renamed** `Collision.rayShapes` to `Collision.rayWithShapes`
 - **Renamed** `Collision.rayRay` to `Collision.rayWithRay`
 - **Renamed** `Collision.rayRays` to `Collision.rayWithRays`
 - **Renamed** `Collision.rayRays` to `Collision.rayWithRays`
 - **Renamed** `data.CollisionData` to `data.ShapeCollision`
 - **Renamed** `data.RayCollisionData` to `data.RayCollision`
 - **Renamed** `data.RayIntersectionData` to `data.RayIntersection`
 - **Removed** `OpenFLDrawer`, will replace with gist or test later

**1.1.0 (Latest release, haxelib)**
 - Added documentation and clean up of code
 - Renamed `Vector2D` to `Vector` and cleaned up code to ONLY what is needed. This class is meant to be as small and easy to integrate as possible.   
 - Refactored for easier maintaining in embedded libraries   
 - Renamed `BaseShape` to `Shape`, continued refactoring
 - Renamed `Collision.testShapes` to `Collision.test`
 - Renamed `Collision.testShapeList` to `Collision.testShapes`
 - Renamed `Collision.rayCollision` to `Collision.ray`
 - Fixed various bugs in collisions
 - Fixed `separation`/`unitVector` behaviour (signs bugs)
 - Fixed bug with `Polygon`/`Polygon` collisions not returning best vectors 
 - Fixed bug where you couldn't `beginFill` using `OpenFLDrawer`
 - Fixed `collisionData` in `CheckCircles`, shape2 wasn't assigned.
 - `separation`/`unitVector` is now bound to shape1
 - Added 2 samples (usage2 & usage3)
 - Added `drawVector` in `OpenFLDrawer` showing vector direction
 - Added `drawShape` in `ShapeDrawer`, will cast proper types and call appropriate drawing functions.

**1.0.4**
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

---

&nbsp;
