package Controleur
{
	import DAO.DaoOeuvre;
	import DAO.DaoSalle;
	import DAO.DaoVideo;
	
	import flash.utils.setTimeout;
	
	import modele.Oeuvre;
	import modele.Salle;
	import modele.Video;
	
	import mx.collections.ArrayList;
	import mx.controls.Alert;

	public class ControleurPrincipal
	{
		
		private var daoSalle:DaoSalle ;
		private var daoOeuvre:DaoOeuvre ;
		private var listeSalles:ArrayList ;
		
		public function ControleurPrincipal()
		{
			this.daoSalle = new DaoSalle();
			this.daoOeuvre = new DaoOeuvre();
			
		}
		
		
		
		public function chargerSalle():void{
			
			
			this.listeSalles = this.daoSalle.getToutesLesSalles();
			
			this.chargerOeuvreDansLesSalles();
			
		}
		
		public function chargerOeuvreDansLesSalles():void{
			
			var length:int = this.listeSalles.length ;
			
			for (var i:Number = 0; i<length; i++) {
				
				var salleCourante:Salle = Salle(this.listeSalles.getItemAt(i));
				salleCourante.setOeuvre(this.daoOeuvre.getOeuvreById(salleCourante.getIdOeuvre()));				
			}
		}
		
		public function getSalle():ArrayList{
			this.chargerSalle();
			return this.listeSalles;
		}
		public function getVideo():String{
			
			var length:int = this.listeSalles.length ;
			var o:Oeuvre = this.daoOeuvre.getOeuvreById(1) ;
			new DaoVideo(o);
			
			setTimeout(o.getVideo, 4000);
			
			
			return "prout";
			
		}
	}
}