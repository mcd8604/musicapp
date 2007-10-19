package org.mcd.music.model
{
	import org.mcd.music.vo.Playlist;
	import mx.controls.Alert;
	import org.mcd.music.service.Services;
	import mx.collections.ArrayCollection;
	import org.mcd.music.vo.MusicFile;
	
	public class PlaylistManager
	{
		//Singleton Pattern
		
		private static var _instance:PlaylistManager = new PlaylistManager();
	
		public function PlaylistManager() {
			if(_instance != null) 
				throw new Error("PlaylistManager instances cannot be created outside the class.");
		}
		
		public static function getInstance():PlaylistManager {
			return _instance;
		}
	
		//Playlist Model
	
		private var playlistNames:ArrayCollection;
		private var playlists:ArrayCollection;
		
		//Service Control
		
		private var service:Services;
		
		public function setServices(a_service:Services):void {
			this.service = a_service;
		}
		
		public function savePlaylist(playlist:Playlist):void {
			var xmlPlaylist:XML = playlist.toXML();
			Alert.show(xmlPlaylist.toXMLString());
		}
		
	}
}