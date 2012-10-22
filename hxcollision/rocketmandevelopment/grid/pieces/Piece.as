package com.rocketmandevelopment.grid.pieces {
	import com.rocketmandevelopment.grid.cells.Cell;

	public class Piece {
		protected var _cell:Cell;
		
		public function Piece(){
		}
		
		
		public function update():void {
			
		}
		
		public function set active(b:Boolean):void {
			return;
		}
		
		public function get active():Boolean {
			return false;
		}
		
		public function get y():int {
			return _cell.y;
		}
		
		public function get cell():Cell {
			return _cell;
		}
		public function set cell(v:Cell):void {
			_cell = v;
		}
		
	}
}