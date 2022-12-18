package allumettes;

public interface Strategie {
	
	/** Obtenir le nombre d'allumettes que le joueuer va tirer suivant cette stratégie
	 * @param jeu Le jeu en cours
	 * @param nom Le nom du joueur en train de jouer
	 * @return nombre d'allumettes qui va être tirées
	 */
	int getPrise(Jeu jeu, String nom);
	
}
