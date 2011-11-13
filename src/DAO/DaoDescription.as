package DAO
{
	import Controleur.ControleurPrincipal;
	
	import modele.Description;
	import modele.Oeuvre;
	
	import mx.collections.ArrayList;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import spark.components.TextInput;
	
	public class DaoDescription
	{
		
		private var httpService:HTTPService ;
		private var xmlList:XMLList;
		private var oeuvre:Oeuvre;
		private var resultatRequete:Object ;
		private var controleurPrincipal:ControleurPrincipal ;
		
		public function DaoDescription(oeuvre:Oeuvre, controleurPrincipal:ControleurPrincipal)
		{

			this.controleurPrincipal = controleurPrincipal ;
			this.oeuvre = oeuvre ;
			this.httpService = new HTTPService();
			
			this.httpService.addEventListener("result", httpResult);
			this.httpService.addEventListener("fault", httpFault); 
			this.httpService.resultFormat = "e4x"; 
			this.httpService.url = "http://localhost/linkProjetMusee.php?table=description&idOeuvre="+oeuvre.getId() ;
			this.httpService.send();
		}
		
		private function httpResult(event:ResultEvent):void { 
			
			this.resultatRequete = event.result ;
			
			var xml:XML= new XML(this.resultatRequete.toString());
			var xmlList: XMLList = xml.child("row");
			
			for (var i:Number = 0; i<xmlList.length(); i++) {
				
				var id:int= xmlList[i].id ;
				var path:String= xmlList[i].path ;
				var idOeuvre:int= xmlList[i].idOeuvre ;
				
				var description:Description = new Description(id, idOeuvre, path);
				this.controleurPrincipal.afficherDescription(description);
			}
		} 
		
		private function httpFault(event:FaultEvent):void { 
			var faultstring:String = event.fault.faultString; 
			Alert.show("Probleme de connection à la base dans DAO Description" + faultstring); 
		}
	}
}