package Controleur
{
	import DAO.DaoSalle;
	
	import mx.collections.ArrayList;

	public class ControleurPrincipal
	{
		public function ControleurPrincipal()
		{
			
			
		}
		
		public function chargerSalle():void{
			
			
			var listeSalles:ArrayList = new DaoSalle().getToutesLesSalles();
			
		}
	}
}