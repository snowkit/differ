package com.rocketmandevelopment.grid {
	import flash.display.Graphics;
	import com.rocketmandevelopment.grid.cells.Cell;
	
	public class Grid {
		private static var theGrid:Grid;
		private static const unlock:int = 8675309;
		
		private var _height:int;
		
		private var _width:int;
		private var grid:Array;
		
		public function Grid(key:Object, width:int, height:int) {
			if(!key || key.code != unlock) {
				trace("ERROR");
				return;
			}
			_width = width;
			_height = height;
			grid = [];
			for(var x:int = 0; x < _width; x++) {
				grid[x] = [];
				for(var y:int = 0; y < _height; y++) {
					grid[x][y] = new Cell(x, y);
				}
			}
		}
		
		public static function cellAt(x:int, y:int):Cell {
			if((x >= 0 && x < theGrid.grid.length) && y >= 0 && y < theGrid.grid[0].length) {
				return theGrid.grid[x][y];
			}
			return null;
		}
		
		public static function clear():void {
			if(!theGrid.grid) {
				return;
			}
			for(var x:int = 0; x < theGrid._width; x++) {
				for(var y:int = 0; y < theGrid._height; y++) {
					theGrid.grid[x][y].clear();
				}
			}
		}
		
		public static function createGrid(width:int, height:int):Grid {
			if(theGrid) {
				return theGrid;
			}
			var o:Object = new Object();
			o.code = unlock;
			var g:Grid = new Grid(o, width, height);
			theGrid = g;
			return g;
		}
		
		
		public static function draw(graphics:Graphics, width:Number, height:Number):void {
			if(!theGrid.grid) {
				return;
			}
			graphics.lineStyle(0, 0x555555);
			for(var x:int = 0; x < theGrid._width; x++) {
				for(var y:int = 0; y < theGrid._height; y++) {
					theGrid.grid[x][y].draw(graphics, width, height);
				}
			}
		}
		
		public static function forEachCell(runFunction:Function):void {
			for(var x:int = 0; x < theGrid._width; x++) {
				for(var y:int = 0; y < theGrid._height; y++) {
					runFunction(theGrid.grid[x][y]);
				}
			}
		}
		
		
		public static function getGrid():Grid {
			if(theGrid) {
				return theGrid;
			}
			return null;
		}
		
		public static function reset():void {
			if(!theGrid.grid) {
				return;
			}
			for(var x:int = 0; x < theGrid._width; x++) {
				for(var y:int = 0; y < theGrid._height; y++) {
					theGrid.grid[x][y].reset();
				}
			}
		}
	}
}