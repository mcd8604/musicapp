package org.mcd.music.vo
{
	import mx.controls.Alert;
	import flash.media.Sound;
	
	public class MusicFile
	{
		public var soundFile:Sound;
		
		public var album:String;
		public var artist:String;
		public var comment:String;
		public var genre:String;
		public var songName:String;
		public var track:String;
		public var year:String;
		
		public var length:Number;
		
		public function MusicFile(a_xmlData:XML = null, a_soundFile:Sound = null) {
			if(a_xmlData != null) {
				this.songName = a_xmlData.title;
				this.artist = a_xmlData.artist;
				this.album = a_xmlData.album;
				this.length = a_xmlData.length;
				this.genre = a_xmlData.genre;
				this.year = a_xmlData.year;
			}
			if(a_soundFile != null) {
				this.soundFile = a_soundFile;
				
				this.album = a_soundFile.id3.album;
				this.artist = a_soundFile.id3.artist;
				this.comment = a_soundFile.id3.comment;
				this.genre = a_soundFile.id3.genre;
				this.songName = a_soundFile.id3.songName;
				this.track = a_soundFile.id3.track;
				this.year = a_soundFile.id3.year;
				
				this.length = a_soundFile.length;
			}
		}
		
		public function toXML():XML {
			var musicXML:XML = new XML();
			musicXML = 
				<musicfile>
					<title>{this.songName}</title>
					<artist>{this.artist}</artist>
					<album>{this.album}</album>
					<length>{this.length}</length>
					<genre>{this.genre}</genre>
					<year>{this.year}</year>
				</musicfile>;
				return musicXML;
		}
		
	}
}