package allumettes;

/** La classe qui représente le joueur rapide
 * @author	Issam Alouane
 */

public class StrategieRapide implements Strategie {
	
	/** Obtenir le nombre d'allumettes que le joueur veut tirer.
	 * @param jeu Le jeu en cours
	 */
	public int getPrise(Jeu jeu, String nom) {
		
		//Ce joueur va tirer le minimum entre le nombre maximum de prises possible ou le nombre d'allumettes
		
		return Math.min(Jeu.PRISE_MAX, jeu.getNombreAllumettes());
		
	}

}
