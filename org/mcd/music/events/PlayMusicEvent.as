package org.mcd.music.events
{
	import flash.events.Event;
	import org.mcd.music.vo.MusicFile;

	public class PlayMusicEvent extends Event
	{
		public static const PLAY_MUSIC_EVENT:String = "play_music_event";
		
		public var musicFile:MusicFile;
		
		public function PlayMusicEvent(a_musicFile:MusicFile)
		{
			super(PLAY_MUSIC_EVENT, true);
			this.musicFile = a_musicFile;
		}

		// This is good practice
		override public function clone():Event
		{
			return new PlayMusicEvent(this.musicFile);
		}
	}
}