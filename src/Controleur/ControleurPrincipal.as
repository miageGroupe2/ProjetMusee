package Controleur
{
	import DAO.DaoDescription;
	import DAO.DaoOeuvre;
	import DAO.DaoSalle;
	import DAO.DaoVideo;
	
	import Vue.Mur;
	
	import flash.utils.setTimeout;
	
	import modele.Description;
	import modele.Oeuvre;
	import modele.Salle;
	import modele.Video;
	
	import mx.collections.ArrayList;
	import mx.controls.Alert;
	
	import spark.components.Label;
	import spark.components.TextInput;

	public class ControleurPrincipal
	{
		
		public static var instance:ControleurPrincipal ;
		private var daoSalle:DaoSalle ;
		private var daoOeuvre:DaoOeuvre ;
		private var listeSalles:ArrayList ;
		
		private var mur:Mur ;
		//la salle affichée par la vue
		private var salleAffichee:Salle;
		
		public function ControleurPrincipal(mur:Mur)
		{
			this.mur = mur ;
			this.daoSalle = new DaoSalle(this);
			this.daoOeuvre = new DaoOeuvre();
			instance = this ;
		}
		
		public function chargerSalle(nomSalle:String):Salle{
			
			this.mur.area.text += "demande du chargement de la salle "+ nomSalle;
			this.salleAffichee = this.daoSalle.getSalleByNom(nomSalle) ;
			
			this.daoOeuvre.getOeuvreById(this.salleAffichee.getIdOeuvre());
			return this.salleAffichee;
		}
		public function chargerListeDesSalles(listeSalle:ArrayList):void{
					
			this.listeSalles = listeSalle;
			this.mur.afficherListeDesSalles(this.listeSalles);
			//this.chargerOeuvreDansLesSalles();
		}
		public function demanderChargerListeDesSalles():void{
			
			this.daoSalle.getToutesLesSalles();
		}
		
		public function chargerOeuvre(oeuvre:Oeuvre):void{
			
			this.salleAffichee.setOeuvre(oeuvre);
			this.mur.nomOeuvre.text = oeuvre.getNom();
		}
		
		
		public function demanderVideo():void{
			
			new DaoVideo(this.salleAffichee.getOeuvre());
		}
		public function afficherVideo(video:Video):void{
			
			this.mur.afficherVideo(video);
		}
		
		public function demanderDescription():void{
			
			new DaoDescription(this.salleAffichee.getOeuvre());
		}
		
		public function afficherDescription(description:Description):void{
			
			this.mur.afficherDescription(this.salleAffichee.getOeuvre().getNom(), description);
		}
			
		
		
		
	}
}