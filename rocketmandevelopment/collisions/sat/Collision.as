package com.rocketmandevelopment.collisions.sat {
	import com.rocketmandevelopment.collisions.shapes.BaseShape;
	import com.rocketmandevelopment.collisions.shapes.Circle;
	import com.rocketmandevelopment.collisions.shapes.Polygon;
	import com.rocketmandevelopment.math.Vector2D;
	
	public class Collision {
		
		public function Collision() {
			throw new Error("Collision is a static class. No instances can be created.");
		}
		
		public static function testShapes(shape1:BaseShape, shape2:BaseShape):CollisionData {
			if(shape1 is Circle && shape2 is Circle) {
				return checkCircles(Circle(shape1), Circle(shape2));
			}
			if(shape1 is Polygon && shape2 is Polygon) {
				if(checkPolygons(Polygon(shape2), Polygon(shape1))) {
					return checkPolygons(Polygon(shape1), Polygon(shape2));
				}
			}
			if(shape1 is Circle) {
				return checkCircleVsPolygon(Circle(shape1), Polygon(shape2));
			}
			if(shape2 is Circle) {
				return checkCircleVsPolygon(Circle(shape2), Polygon(shape1));
			}
			return null;
		}
		
		private static function checkCircleVsPolygon(circle:Circle, polygon:Polygon):CollisionData {
			var test1:Number; //numbers for testing max/mins
			var test2:Number;
			var test:Number;
			
			var min1:Number; //same as above
			var max1:Number;
			var min2:Number;
			var max2:Number;
			var normalAxis:Vector2D;
			var offset:Number;
			var vectorOffset:Vector2D;
			var vectors:Array;
			var p2:Array;
			var distance:Number;
			var testDistance:Number = int.MAX_VALUE;
			var closestVector:Vector2D = new Vector2D(); //the vector to use to find the normal
			
			// find offset
			vectorOffset = new Vector2D(polygon.x - circle.x, polygon.y - circle.y);
			vectors = polygon.vertices.concat(); //we don't want the transformed ones here, we transform the points later
			
			//adds some padding to make it more accurate
			if(vectors.length == 2) {
				var temp:Vector2D = new Vector2D(-(vectors[1].y - vectors[0].y), vectors[1].x - vectors[0].x);
				temp.truncate(0.0000000001);
				vectors.push(Vector2D(vectors[1]).cloneVector().add(temp));
			}
			
			// find the closest vertex to use to find normal
			for(var i:int = 0; i < vectors.length; i++) {
				distance = (circle.x - (polygon.x + vectors[i].x)) * (circle.x - (polygon.x + vectors[i].x)) + (circle.y - (polygon.y + vectors[i].y)) * (circle.y - (polygon.y + vectors[i].y));
				if(distance < testDistance) { //closest has the lowest distance
					testDistance = distance;
					closestVector.x = polygon.x + vectors[i].x;
					closestVector.y = polygon.y + vectors[i].y;
				}
				
			}
			
			//get the normal vector
			normalAxis = new Vector2D(closestVector.x - circle.x, closestVector.y - circle.y);
			normalAxis.normalize(); //normalize is(set its length to 1)
			
			// project the polygon's points
			min1 = normalAxis.dotProduct(vectors[0]);
			max1 = min1; //set max and min
			
			for(var j:int = 1; j < vectors.length; j++) { //project all its points, starting with the first(the 0th was done up there^)
				test = normalAxis.dotProduct(vectors[j]); //dotProduct to project
				if(test < min1) {
					min1 = test;
				} //smallest min is wanted
				if(test > max1) {
					max1 = test;
				} //largest max is wanted
			}
			
			// project the circle
			max2 = circle.transformedRadius; //max is radius
			min2 -= circle.transformedRadius; //min is negative radius
			
			// offset the polygon's max/min
			offset = normalAxis.dotProduct(vectorOffset);
			min1 += offset;
			max1 += offset;
			
			// do the big test
			test1 = min1 - max2;
			test2 = min2 - max1;
			
			if(test1 > 0 || test2 > 0) { //if either test is greater than 0, there is a gap, we can give up now.
				return null;
			}
			
			// find the normal axis for each point and project
			for(i = 0; i < vectors.length; i++) {
				normalAxis = findNormalAxis(vectors, i);
				
				// project the polygon(again? yes, circles vs. polygon require more testing...)
				min1 = normalAxis.dotProduct(vectors[0]); //project
				max1 = min1; //set max and min
				
				//project all the other points(see, cirlces v. polygons use lots of this...)
				for(j = 1; j < vectors.length; j++) {
					test = normalAxis.dotProduct(vectors[j]); //more projection
					if(test < min1) {
						min1 = test;
					} //smallest min
					if(test > max1) {
						max1 = test;
					} //largest max
				}
				
				// project the circle(again)
				max2 = circle.transformedRadius; //max is radius
				min2 = -circle.transformedRadius; //min is negative radius
				
				//offset points
				offset = normalAxis.dotProduct(vectorOffset);
				min1 += offset;
				max1 += offset;
				
				// do the test, again
				test1 = min1 - max2;
				test2 = min2 - max1;
				
				if(test1 > 0 || test2 > 0) {
					
					//failed.. quit now
					return null
					
				}
				
			}
			
			//if you made it here, there is a collision!!!!!
			
			var collisionData:CollisionData = new CollisionData();
			collisionData.overlap = -(max2 - min1);
			collisionData.unitVector = normalAxis;
			collisionData.shape1 = polygon;
			collisionData.shape2 = circle;
			collisionData.separation = new Vector2D(normalAxis.x * (max2 - min1) * -1, normalAxis.y * (max2 - min1) * -1); //return the separation distance
			return collisionData;
		}
		
		private static function checkCircles(circle1:Circle, circle2:Circle):CollisionData {
			var totalRadius:Number = circle1.transformedRadius + circle2.transformedRadius; //add both radii together to get the colliding distance
			var distanceSquared:Number = (circle1.x - circle2.x) * (circle1.x - circle2.x) + (circle1.y - circle2.y) * (circle1.y - circle2.y); //find the distance between the two circles using Pythagorean theorem. No square roots for optimization
			
			if(distanceSquared < totalRadius * totalRadius) { //if your distance is less than the totalRadius square(because distance is squared)
				var difference:Number = totalRadius - Math.sqrt(distanceSquared); //find the difference. Square roots are needed here.
				var collisionData:CollisionData = new CollisionData(); //new CollisionData class to hold all the data for this collision
				collisionData.separation = new Vector2D((circle2.x - circle1.x) * difference, (circle2.y - circle1.y) * difference); //find the movement needed to separate the circles
				collisionData.shape1 = circle1;
				collisionData.unitVector = new Vector2D(circle2.x - circle1.x, circle2.y - circle1.y);
				collisionData.unitVector.normalize();
				collisionData.overlap = collisionData.separation.length;
				return collisionData;
			}
			return null; //no collision, return null
		}
		
		private static function checkPolygons(polygon1:Polygon, polygon2:Polygon):CollisionData {
			var test1:Number; // numbers to use to test for overlap
			var test2:Number;
			var testNum:Number; // number to test if its the new max/min
			var min1:Number; //current smallest(shape 1)
			var max1:Number; //current largest(shape 1)
			var min2:Number; //current smallest(shape 2)
			var max2:Number; //current largest(shape 2)
			var axis:Vector2D; //the normal axis for projection
			var offset:Number;
			var vectors1:Array; //the points
			var vectors2:Array; //the points
			var shortestDistance:Number = int.MAX_VALUE;
			var collisionData:CollisionData = new CollisionData();
			vectors1 = polygon1.transformedVertices.concat();
			vectors2 = polygon2.transformedVertices.concat();
			// add a little padding to make the test work correctly for lines
			if(vectors1.length == 2) {
				var temp:Vector2D = new Vector2D(-(vectors1[1].y - vectors1[0].y), vectors1[1].x - vectors1[0].x);
				temp.truncate(0.0000000001);
				vectors1.push(vectors1[1].add(temp));
			}
			if(vectors2.length == 2) {
				temp = new Vector2D(-(vectors2[1].y - vectors2[0].y), vectors2[1].x - vectors2[0].x);
				temp.truncate(0.0000000001);
				vectors2.push(vectors2[1].add(temp));
			}
			
			// loop to begin projection
			for(var i:int = 0; i < vectors1.length; i++) {
				// get the normal axis, and begin projection
				axis = findNormalAxis(vectors1, i);
				
				// project polygon1
				min1 = axis.dotProduct(vectors1[0]);
				max1 = min1; //set max and min equal
				
				for(var j:int = 1; j < vectors1.length; j++) {
					testNum = axis.dotProduct(vectors1[j]); //project each point
					if(testNum < min1) {
						min1 = testNum;
					} //test for new smallest
					if(testNum > max1) {
						max1 = testNum;
					} //test for new largest
				}
				
				// project polygon2
				min2 = axis.dotProduct(vectors2[0]);
				max2 = min2; //set 2's max and min
				
				for(j = 1; j < vectors2.length; j++) {
					testNum = axis.dotProduct(vectors2[j]); //project the point
					if(testNum < min2) {
						min2 = testNum;
					} //test for new min
					if(testNum > max2) {
						max2 = testNum;
					} //test for new max
				}
				
				// and test if they are touching
				test1 = min1 - max2; //test min1 and max2
				test2 = min2 - max1; //test min2 and max1
				if(test1 > 0 || test2 > 0) { //if they are greater than 0, there is a gap
					return null; //just quit
				}
				var distance:Number = -(max2 - min1);
				if(Math.abs(distance) < shortestDistance) {
					collisionData.unitVector = axis;
					collisionData.overlap = distance;
					shortestDistance = Math.abs(distance);
				}
			}
			
			//if you're here, there is a collision
			collisionData.shape1 = polygon1;
			collisionData.shape2 = polygon2;
			collisionData.separation = new Vector2D(collisionData.unitVector.x * collisionData.overlap, collisionData.unitVector.y * collisionData.overlap); //return the separation, apply it to a polygon to separate the two shapes.
			return collisionData;
		}
		
		private static function findNormalAxis(vertices:Array, index:int):Vector2D {
			var vector1:Vector2D = vertices[index];
			var vector2:Vector2D = (index >= vertices.length - 1) ? vertices[0] : vertices[index + 1]; //make sure you get a real vertex, not one that is outside the length of the vector.
			
			var normalAxis:Vector2D = new Vector2D(-(vector2.y - vector1.y), vector2.x - vector1.x); //take the two vertices, make a line out of them, and find the normal of the line
			normalAxis.normalize(); //normalize the line(set its length to 1)
			return normalAxis;
		}
	}
}
