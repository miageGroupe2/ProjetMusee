package modele
{
	public class Salle
	{
		
		private var id:int ;
		private var nom:String ;
		private var idOeuvre:int ;
		private var oeuvre:Oeuvre ;
		
		public function Salle(id:int, nom:String, idOeuvre:int)
		{
			this.id = id ;
			this.nom = nom ;
			this.idOeuvre = idOeuvre ;
		}
		
		public function toString():String{
			
			var retour:String = this.id + this.nom + this.idOeuvre;
			return retour ;
		}
		
		public function setOeuvre(oeuvre:Oeuvre):void{
			
			this.oeuvre = oeuvre ;
		}
		
		
	}
}