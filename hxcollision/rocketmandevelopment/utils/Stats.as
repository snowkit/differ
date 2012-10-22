/**
 * Hi-ReS! Stats
 *
 * Released under MIT license:
 * http://www.opensource.org/licenses/mit-license.php
 *
 * How to use:
 *
 *      addChild( new Stats() );
 *
 * version log:
 *
 *      09.02.21                2.0             Mr.doob                 + Removed Player version, until I know if it's really needed.
 *                                                                                      + Added MAX value (shows Max memory used, useful to spot memory leaks)
 *                                                                                      + Reworked text system / no memory leak (original reason unknown)
 *                                                                                      + Simplified
 *      09.02.07                1.5             Mr.doob                 + onRemovedFromStage() (thx huihuicn.xu)
 *      08.12.14                1.4             Mr.doob                 + Code optimisations and version info on MOUSE_OVER
 *      08.07.12                1.3             Mr.doob                 + Some speed and code optimisations
 *      08.02.15                1.2             Mr.doob                 + Class renamed to Stats (previously FPS)
 *      08.01.05                1.2             Mr.doob                 + Click changes the fps of flash (half up increases, half down decreases)
 *      08.01.04                1.1             Mr.doob                 + Shameless ripoff of Alternativa's FPS look :P
 *                                                      Theo                    + Log shape for MEM
 *                                                                                      + More room for MS
 *      07.12.13                1.0             Mr.doob                 + First version
 **/

package com.rocketmandevelopment.utils {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.utils.getTimer;
	
	public class Stats extends Sprite {
		private var fps:uint;
		
		private var fps_graph:uint;
		
		private var graph:BitmapData;
		private var mem:Number;
		private var mem_graph:uint;
		private var mem_max:Number;
		private var mem_max_graph:uint;
		private var ms:uint;
		private var ms_prev:uint;
		private var rectangle:Rectangle;
		private var style:StyleSheet;
		
		private var text:TextField;
		
		private var timer:uint;
		private var xml:XML;
		
		public function Stats():void {
			addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			graphics.beginFill(0x33);
			graphics.drawRect(0, 0, 70, 50);
			graphics.endFill();
			
			mem_max = 0;
			
			xml = <xml><fps>FPS:</fps><ms>MS:</ms><mem>MEM:</mem><memMax>MAX:</memMax></xml>;
			
			style = new StyleSheet();
			style.setStyle("xml", {fontSize: '9px', fontFamily: '_sans', leading: '-2px'});
			style.setStyle("fps", {color: '#FFFF00'});
			style.setStyle("ms", {color: '#00FF00'});
			style.setStyle("mem", {color: '#00FFFF'});
			style.setStyle("memMax", {color: '#FF0070'});
			
			text = new TextField();
			text.width = 70;
			text.height = 50;
			text.styleSheet = style;
			text.condenseWhite = true;
			text.selectable = false;
			text.mouseEnabled = false;
			addChild(text);
			
			var bitmap:Bitmap = new Bitmap(graph = new BitmapData(70, 50, false, 0x33));
			bitmap.y = 50;
			addChild(bitmap);
			
			rectangle = new Rectangle(0, 0, 1, graph.height);
			
			addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function onClick(e:MouseEvent):void {
			mouseY / height > .5 ? stage.frameRate-- : stage.frameRate++;
			xml.fps = "FPS: " + fps + " / " + stage.frameRate;
			text.htmlText = xml;
		}
		
		private function update(e:Event):void {
			timer = getTimer();
			
			if(timer - 1000 > ms_prev) {
				ms_prev = timer;
				mem = Number((System.totalMemory * 0.000000954).toFixed(3));
				mem_max = mem_max > mem ? mem_max : mem;
				
				fps_graph = Math.min(50, (fps / stage.frameRate) * 50);
				mem_graph = Math.min(50, Math.sqrt(Math.sqrt(mem * 5000))) - 2;
				mem_max_graph = Math.min(50, Math.sqrt(Math.sqrt(mem_max * 5000))) - 2;
				
				graph.scroll(1, 0);
				
				graph.fillRect(rectangle, 0x33);
				graph.setPixel(0, graph.height - fps_graph, 0xFFFF00);
				graph.setPixel(0, graph.height - ((timer - ms) >> 1), 0x00FF00);
				graph.setPixel(0, graph.height - mem_graph, 0x00FFFF);
				graph.setPixel(0, graph.height - mem_max_graph, 0xFF0070);
				
				xml.fps = "FPS: " + fps + " / " + stage.frameRate;
				xml.mem = "MEM: " + mem;
				xml.memMax = "MAX: " + mem_max;
				
				fps = 0;
			}
			
			fps++;
			
			xml.ms = "MS: " + (timer - ms);
			ms = timer;
			
			text.htmlText = xml;
		}
	}
}

