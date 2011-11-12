package DAO
{
	
	import modele.Oeuvre;
	import modele.Video;
	
	import mx.collections.ArrayList;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class DaoVideo
	{
		
		private var httpService:HTTPService ;
		private var xmlList:XMLList;
		private var oeuvre:Oeuvre;
		
		private var resultatRequete:Object ;
		
		public function DaoVideo(oeuvre:Oeuvre)
		{
			this.oeuvre = oeuvre ;
			this.httpService = new HTTPService();
			
			this.httpService.addEventListener("result", httpResult);
			this.httpService.addEventListener("fault", httpFault); 
			this.httpService.resultFormat = "e4x"; 
			this.httpService.url = "http://localhost/linkProjetMusee.php?table=video&idOeuvre="+oeuvre.getId() ;
			this.httpService.send();
		}
		
		private function httpResult(event:ResultEvent):void { 
			
			this.resultatRequete = event.result ;
			
			var xml:XML= new XML(this.resultatRequete.toString());
			var xmlList: XMLList = xml.child("row");
			
			for (var i:Number = 0; i<xmlList.length(); i++) {
				
				var id:int= xmlList[i].id ;
				var nom:String = xmlList[i].nom ;
				var path:String= xmlList[i].path ;
				var description:String= xmlList[i].description ;
				var idOeuvre:int= xmlList[i].idOeuvre ;
				
				var video:Video = new Video(id, nom, path, description);
				this.oeuvre.setVideo(video);
			}
			
			
		} 
		
		private function httpFault(event:FaultEvent):void { 
			var faultstring:String = event.fault.faultString; 
			Alert.show("Probleme de connection à la base dans DAO Video" + faultstring); 
		}
	}
}