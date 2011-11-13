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
		
		private var daoSalle:DaoSalle ;
		private var daoOeuvre:DaoOeuvre ;
		private var listeSalles:ArrayList ;
		
		private var mur:Mur ;
		
		public function ControleurPrincipal(mur:Mur)
		{
			this.mur = mur ;
			this.daoSalle = new DaoSalle(this);
			this.daoOeuvre = new DaoOeuvre();
			
		}
		
		public function chargerSalle(nomSalle:String):Salle{
			
			this.mur.area.text += "demande du chargement de la salle "+ nomSalle;
			return this.daoSalle.getSalleByNom(nomSalle);
		}
		public function chargerListeDesSalles(listeSalle:ArrayList):void{
					
			this.listeSalles = listeSalle;
			this.mur.afficherListeDesSalles(this.listeSalles);
			//this.chargerOeuvreDansLesSalles();
		}
		public function demanderChargerListeDesSalles():void{
			
			this.daoSalle.getToutesLesSalles();
		}
		
		public function chargerOeuvreDansLesSalles():void{
			
			var length:int = this.listeSalles.length ;
			
			for (var i:Number = 0; i<length; i++) {
				
				var salleCourante:Salle = Salle(this.listeSalles.getItemAt(i));
				salleCourante.setOeuvre(this.daoOeuvre.getOeuvreById(salleCourante.getIdOeuvre()));				
			}
		}
		
		
		public function getVideo():String{
			
			var length:int = this.listeSalles.length ;
			var o:Oeuvre = this.daoOeuvre.getOeuvreById(1) ;
			new DaoVideo(o);
			
			setTimeout(o.getVideo, 4000);
			
			
			return "prout";
			
		}
		
		public function demanderDescription():void{
			
			var o:Oeuvre = this.daoOeuvre.getOeuvreById(1);
			new DaoDescription(o, this);
		}
		
		public function afficherDescription(description:Description):void{
			
			var o:Oeuvre = this.daoOeuvre.getOeuvreById(1);
			this.mur.champNom.text = o.getNom();
			this.mur.champAnnee.text = "annee bidon";
			
		}
			
		
		
	}
}