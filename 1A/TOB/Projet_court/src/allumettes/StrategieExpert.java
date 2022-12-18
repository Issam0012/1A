package allumettes;

import java.util.Random;

/** La classe qui représente le joueur expert
 * @author	Issam Alouane
 */

public class StrategieExpert implements Strategie {
	
	/** Construire un joueur expert à partir de son nom
	 * @param Nom le nom du joueur
	 */
	//public JoueurExpert(String Nom) {
		//super(Nom, "expert");
	//}

	/** Obtenir le nombre d'allumettes que le joueur veut tirer.
	 * @param jeu Le jeu en cours
	 */
	public int getPrise(Jeu jeu, String nom) {
		int prise;
		
		/** Si le nombre d'allumettes moins 1 (car c'est l'autre joueur qui va prendre la dernière) est divisible par 
		 *  prise_max+1 alors on fait un choix aléatoire sinon on prend le reste de cette division
		 */
		if ((jeu.getNombreAllumettes()-1)%(Jeu.PRISE_MAX+1) == 0) {
			Random random = new Random();
			prise = random.nextInt(Math.min(Jeu.PRISE_MAX, jeu.getNombreAllumettes())) + 1;
		} else {
			prise = (jeu.getNombreAllumettes()-1)%(Jeu.PRISE_MAX+1);
		}
		
		return prise;
		
	}
	
}
