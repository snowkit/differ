package com.rocketmandevelopment.utils {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;

	public class Preloader extends MovieClip {
			protected function beginLoading() : void {}
			protected function updateLoading( a_percent : Number ) : void {}
			protected function endLoading() : void {}
			protected function get mainClassName() : String { return main; }
			
			private var m_firstFrame : Boolean = true;
			protected var main:String = "Main";
			
			public function Preloader()
			{
				addEventListener( Event.ENTER_FRAME, checkFrame );
			}
			
			private function checkFrame(e:Event):void
			{
				
				if( m_firstFrame )
				{
					beginLoading();
					m_firstFrame = false;
					return;
				}
				
				var percent : Number = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
				updateLoading( percent );
				if( percent == 1 )
				{
					removeEventListener( Event.ENTER_FRAME, checkFrame );
					startup();
					return;
				}
			}
			
			private function startup():void
			{
				stop();
				
				if( !m_firstFrame )
				{
					endLoading();
				}
				
				var MainClass:Class = getDefinitionByName( mainClassName ) as Class;
				if( MainClass == null )
				{
					throw new Error( "Preloader:startup. There was no class matching [" + mainClassName + "]. You may need to override Preloader::mainClassName" );
				}
				
				var m : DisplayObject = new MainClass() as DisplayObject;
				if( m == null )
				{
					throw new Error( "Preloader::startup. [" + mainClassName + "] needs to inherit from Sprite or MovieClip." );
				}
				
				addChildAt( m, 0 );
			}
			
		}
		
	}
	
