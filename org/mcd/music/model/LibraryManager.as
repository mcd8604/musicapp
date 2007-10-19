package org.mcd.music.model
{
	import org.mcd.music.service.Services;
	import mx.rpc.http.HTTPService;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import org.asc.services.GenericResponder;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import flash.media.Sound;
	import flash.events.EventDispatcher;
	
	import org.mcd.music.events.LibraryLoadedEvent;
	import org.mcd.music.view.Library;
	import org.mcd.music.vo.MusicFile;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	public class LibraryManager extends EventDispatcher
	{
		
		//Singleton Pattern
		
		private static var _instance:LibraryManager = new LibraryManager();
	
		public function LibraryManager() {
			if(_instance != null) 
				throw new Error("LibraryManager instances cannot be created outside the class.");
		}
		
		public static function getInstance():LibraryManager {
			return _instance;
		}
	
		//Library Model
	
		private var filepathList:ArrayCollection;
		private var mp3List:ArrayCollection;
		
		//Service Control
		
		private var service:Services;
		
		public function setServices(a_service:Services):void {
			this.service = a_service;
		}
		
		//Library Loader
		
		public function getXMLLibrary():void {
			//var responder:GenericResponder = new GenericResponder(getXMLLibrary_Result, getLibrary_Fault);
			var responder:GenericResponder = new GenericResponder(getLibrary_Result, getLibrary_Fault);
			var httpService:HTTPService = this.service.getHTTPService("xmlLibraryLoader");
			var token:AsyncToken;
			token = httpService.send();
			token.addResponder(responder);
		}
		
		/*private function getXMLLibrary_Result(a_event:ResultEvent):void {
			this.id3List = new ArrayCollection();
			var musiclist:XML = XML( a_event.result );
			for each( var musicXML:XML in musiclist.musicfile) {
				var musicFile:MusicFile = new MusicFile(musicXML);
				this.id3List.addItem( musicFile );
			}
			this.dispatchEvent(new LibraryLoadedEvent(this.id3List));			
		}*/
		
		public function getLibrary():void {
			var responder:GenericResponder = new GenericResponder(getLibrary_Result, getLibrary_Fault);
			var httpService:HTTPService = this.service.getHTTPService("libraryLoader");
			var token:AsyncToken;
			token = httpService.send();
			token.addResponder(responder);
		}
		
		private function getLibrary_Result(a_event:ResultEvent):void {
			this.mp3List = new ArrayCollection();
			var filepathsXML:XML = XML(a_event.result);			
			for each(var filepathXML:XML in filepathsXML.filepath) {
				var url:URLRequest = new URLRequest("musicLibrary/" + filepathXML.toString());
				var mp3:Sound = new Sound();
				mp3.load(url);
				mp3.addEventListener(Event.ID3, this.id3Ready);
				//var musicFile:MusicFile = new MusicFile(null, mp3);
				//this.mp3List.addItem(musicFile);
			}
			
			//this.dispatchEvent(new LibraryLoadedEvent(this.mp3List));			
		}
		
		private function id3Ready(a_event:Event):void {
			var mp3:Sound = a_event.target as Sound;
			var musicFile:MusicFile = new MusicFile(null, mp3);
			this.mp3List.addItem(musicFile);
			this.dispatchEvent(new LibraryLoadedEvent(this.mp3List));
		}
		
		private function getLibrary_Fault(a_event:FaultEvent):void {
			Alert.show( a_event.fault.faultString, "An Error has Occurred" );
		}
		
		private static function streamMusic(id:String):void {
			var test:Sound = new Sound();
			
		}
	}
}