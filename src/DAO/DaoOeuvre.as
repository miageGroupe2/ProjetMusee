package DAO
{
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
			this.httpService.url = "http://localhost/linkProjetMusee.php?table=oeuvre" ;
			this.httpService.send();
			
		}
		public function getOeuvreById(id:int):Oeuvre{
			
			var length:int = this.listeOeuvre.length;
			
			var oeuvreCourante:Oeuvre ;
			
			for (var i:Number = 0; i<length; i++) {
				
				oeuvreCourante = Oeuvre(this.listeOeuvre.getItemAt(i));
				//Alert.show(oeuvreCourante.getId() + " " + id);
				if (oeuvreCourante.getId() == id){
					
					return oeuvreCourante ;
				}
			}
			
			return null;
		}
		
		private function httpResult(event:ResultEvent):void { 
			
			this.resultatRequete = event.result ;
			
			var xml:XML= new XML(this.resultatRequete.toString());
			var xmlList: XMLList = xml.child("row");
			
			for (var i:Number = 0; i<xmlList.length(); i++) {
				
				var id:int= xmlList[i].id ;
				var nom:String = xmlList[i].nom ;
				var path:String= xmlList[i].path ;
				
				var oeuvre:Oeuvre = new Oeuvre(id, nom, path);
				this.listeOeuvre.addItem(oeuvre);
			}
			
			
		} 
		
		private function httpFault(event:FaultEvent):void { 
			var faultstring:String = event.fault.faultString; 
			Alert.show("Probleme de connection à la base dans DAO Oeuvre" + faultstring); 
		}
		
	}
}