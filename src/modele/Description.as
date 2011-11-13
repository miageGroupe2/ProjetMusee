package modele
{
	public class Description
	{
		private var id:int ;
		private var idOeuvre:int ;
		private var path:String ;
		
		public function Description(id:int, idOeuvre:int, path:String)
		{
			this.id = id ;
			this.idOeuvre = idOeuvre;
			this.path = path ;
		}
		
		
		
		public function toString():String{
			
			var retour:String = "toString description :"+this.path;
			return retour ;
		}
	}
}