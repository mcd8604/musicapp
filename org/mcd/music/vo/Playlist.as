package org.mcd.music.vo
{
	import mx.collections.ArrayCollection;
	
	public class Playlist
	{
		public var name:String;
		
		[Bindable]
		public var list:ArrayCollection;
		
		public function Playlist(a_name:String, a_list:ArrayCollection) {
			this.name = a_name;
			this.list = a_list;
		}
		
		public function toXML():XML {
		    var xmlPlaylist:XML =
		        <playlist name={this.name}> 
		        </playlist>;

			for each(var musicFile:MusicFile in this.list) {
				xmlPlaylist.appendChild(musicFile.toXML());				
			}
			
			return xmlPlaylist;
		}
	}
}