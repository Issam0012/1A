package allumettes;

/** La classe abstraite qui représente le joueur d'une partie et qui laisse la méthode de prise d'allumettes à definir par
 * chaque type de stratégie
 * @author	Issam Alouane
 */

public class Joueur {
	
	/** Le nom du joueur */
	private String nom;
	
	/** la stratégie du joueur */
	private Strategie strategie;
	
	/** Construire un joueur à partir de son nom et de sa stratégie
	 * @param Nom le nom du joueur
	 * @param Strategie La strategie du joueur
	 */
	public Joueur(String Nom, Strategie strategie) {
		this.nom = Nom;
		this.strategie = strategie;
	}
	
	/** Obtenir le nom du joueur
	 * @return nom du joueur
	 */
	public String getNom() {
		return this.nom;
	}
	
	/** Savoir si le joueur est humain
	 * @return le joueur est humain ou pas
	 */
	public boolean estHumain() {
		return (strategie instanceof StrategieHumain);
	}
	
	/** Savoir si le joueur est tricheur
	 * @return le joueur est reicheur ou pas
	 */
	public boolean estTricheur() {
		return (strategie instanceof StrategieTricheur);
	}
	
	/** Avoir la stratégie d'un joueur
	 * @return strategie la strategie du joueur
	 */
	public Strategie getStrategie() {
		return this.strategie;
	}
	
	/** Obtenir le nombre d'allumettes que le joueur veut tirer.
	 * @param jeu Le jeu en cours
	 */
	public int getPrise(Jeu jeu) {
		return this.strategie.getPrise(jeu, this.nom);
	}
	
}
