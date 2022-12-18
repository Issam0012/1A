package allumettes;

/** La classe qui représente le joueur tricheur
 * @author	Issam Alouane
 */

public class StrategieTricheur implements Strategie {
	
	/** Obtenir le nombre d'allumettes que le joueur veut tirer.
	 * @param jeu Le jeu en cours
	 */
	public int getPrise(Jeu jeu, String nom) {
		
		System.out.println("[Je triche...]");
		
		while (jeu.getNombreAllumettes()>2) {
			try {
				jeu.retirer(1);
			} catch (CoupInvalideException e) {
				// cette instruction ne va jamais être exécuté
				System.out.println(e);
			}
		}
		
		System.out.println("[Allumettes restantes : 2]");
		
		return 1;
	}

}
