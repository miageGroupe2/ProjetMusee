package modele
{
	
	
	
	import mx.rpc.http.mxml.HTTPService;

	public class Oeuvre
	{
		
		private var id:int ;
		private var nom:String ;
		private var path:String ;
		
		
		private var video:Video ;
		
		public function Oeuvre(id:int, nom:String, path:String)
		{
			this.id = id ;
			this.nom = nom ;
			this.path = path ;
			
		}
		public function toString():String{
			
			var retour:String = "toString Oeuvre :"+this.nom;
			return retour ;
		}
		
		public function getId():int{
			
			return this.id;
		}
		
		public function getNom():String{
			
			return this.nom ;
		}
		
		public function getVideo():Video{
			
			return this.video ;
		}
		
		public function setVideo(video:Video):void{
			
			this.video = video ;
		}
	}
	
}