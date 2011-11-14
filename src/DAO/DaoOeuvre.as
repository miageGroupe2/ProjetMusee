package DAO
{
	import Controleur.ControleurPrincipal;
	
	import flash.xml.XMLDocument;
	
	import modele.Oeuvre;
	import modele.Salle;
	
	import mx.collections.ArrayList;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class DaoOeuvre
	{
		
		private var httpService:HTTPService ;
		private var xmlList:XMLList;
		private var listeOeuvre:ArrayList ;
		
		private var resultatRequete:Object ;
		private var salle:Salle ;
		
		public function DaoOeuvre()
		{
			
			this.listeOeuvre = new ArrayList();
			this.httpService = new HTTPService();
			
			this.httpService.addEventListener("result", httpResult);
			this.httpService.addEventListener("fault", httpFault); 
			this.httpService.resultFormat = "e4x"; 
			
			
		}
		public function getOeuvreById(id:int):void{
			
			this.httpService.url = "http://localhost/linkProjetMusee.php?table=oeuvre&idOeuvre="+id ;
			this.httpService.send();
			
		}
		
		private function httpResult(event:ResultEvent):void { 
			
			this.resultatRequete = event.result ;
			
			var xml:XML= new XML(this.resultatRequete.toString());
			var xmlList: XMLList = xml.child("row");
			
			
			var id:int= xmlList[0].id ;
			var nom:String = xmlList[0].nom ;
			var path:String= xmlList[0].path ;
			
			var oeuvre:Oeuvre = new Oeuvre(id, nom, path);
			ControleurPrincipal.instance.chargerOeuvre(oeuvre);
		} 
		
		private function httpFault(event:FaultEvent):void { 
			var faultstring:String = event.fault.faultString; 
			Alert.show("Probleme de connection à la base dans DAO Oeuvre" + faultstring); 
		}
		
	}
}