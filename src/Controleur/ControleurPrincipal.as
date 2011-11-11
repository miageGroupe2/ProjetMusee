package Controleur
{
	import DAO.DaoSalle;
	
	import modele.Oeuvre;
	import modele.Salle;
	
	import mx.collections.ArrayList;

	public class ControleurPrincipal
	{
		public function ControleurPrincipal()
		{
			
			
		}
		
		public function chargerSalle():void{
			
			
			var listeSalles:ArrayList = new DaoSalle().getToutesLesSalles();
			
			for (var i:Number = 0; i<listeSalles.length(); i++) {
				
				var salleCourante:Salle = listeSalles.getItemAt(i)(Salle);
				var oeuvre:Oeuvre ;
				salleCourante.setOeuvre(oeuvre);
				
			}
		}
	}
}