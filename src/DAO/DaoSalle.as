package DAO
{
	import flash.xml.XMLDocument;
	
	import modele.Salle;
	
	import mx.collections.ArrayList;
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import spark.components.Button;
	import spark.components.TextArea;

	public class DaoSalle
	{
		
		private var httpService:HTTPService ;
		private var xmlList:XMLList;
		private var listeSalle:ArrayList ;
		
		private var resultatRequete:Object ;
		
		public function DaoSalle()
		{
			this.httpService = new HTTPService();
			this.httpService.url = "http://localhost/linkProjetMusee.php" ;
			this.httpService.addEventListener("result", httpResult);
			this.httpService.addEventListener("fault", httpFault); 
			this.httpService.resultFormat = "e4x"; 
		
			this.httpService.send();
		}
		
		public function getToutesLesSalles():ArrayList{
			
			this.listeSalle = new ArrayList();
			
			var xml:XML= new XML(this.resultatRequete.toString());
			var listSalle: XMLList = xml.child("row");
			
			for (var i:Number = 0; i<listSalle.length(); i++) {
				
				var id:int= listSalle[i].id ;
				var nom:String = listSalle[i].nom ;
				var idOeuvre:int= listSalle[i].idOeuvre ;
				
				var salle:Salle = new Salle(id, nom, idOeuvre);
				this.listeSalle.addItem(salle);
			}
			return this.listeSalle;
		}
		
		private function httpResult(event:ResultEvent):void { 
			
			this.resultatRequete = event.result ;
		} 
				
		private function httpFault(event:FaultEvent):void { 
			var faultstring:String = event.fault.faultString; 
			Alert.show("Probleme de connection à la base" + faultstring); 
		}
	}
}