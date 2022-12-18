package allumettes;

import java.util.Random;

/** La classe qui représente le joueur naïf
 * @author	Issam Alouane
 */

public class StrategieNaïf implements Strategie {
	
	/** Construire un joueur naïf à partir de son nom
	 * @param Nom le nom du joueur
	 */
	//public JoueurNaïf(String Nom) {
		//super(Nom, "naïf");
	//}

	/** Obtenir le nombre d'allumettes que le joueur veut tirer.
	 * @param jeu Le jeu en cours
	 */
	public int getPrise(Jeu jeu, String nom) {
		
		// Ce joueur fait un choix aléatoire entre 1 et le minimum entre prise max et le nombre d'allumettes restantes
		
		Random random = new Random();
		
		int prise = random.nextInt(Math.min(Jeu.PRISE_MAX, jeu.getNombreAllumettes())) + 1;
		
		return prise;
	}

}
