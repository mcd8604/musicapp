package org.mcd.music.events
{
	import flash.events.Event;
	import mx.collections.ArrayCollection;

	public class LibraryLoadedEvent extends Event
	{
		public static const LIBRARY_LOADED:String = "library_loaded_event";
		
		public var library:ArrayCollection;
		
		public function LibraryLoadedEvent(a_library:ArrayCollection)
		{
			super(LIBRARY_LOADED);
			this.library = a_library;
		}

		// This is good practice
		override public function clone():Event
		{
			return new LibraryLoadedEvent(this.library);
		}
	}
}