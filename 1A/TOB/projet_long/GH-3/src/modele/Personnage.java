package modele;

public class Personnage{

	//Attributs
	private String nom; //Nom du personnage
	private String description; //Description, histoire du personnage
	private Inventaire inventaire; //Inventaire du personnage
	private Equipement equipement; //Equipement du personnage
	private Statistiques stats; //Stats du personnage
	private Race race; //Race du personnage
	private Position position; //Position du personnage

	/** Le constructeur */
	public Personnage(String nom, Race race, String description) {
		this.nom = nom; 
		this.race = race;
		this.description = description;
		this.inventaire = new Inventaire(this.race);
		this.position = new Position(0,0);		
		this.inventaire = new Inventaire(race);
		this.equipement = new Equipement();
		this.stats = race.getStatistiques();
	}

	//Requetes

	/**Recuperer la position du personnage
	 * @return Position, emplacement du personnage sur le plateau
	 */
	public Position getPosition() {
		return this.position;
	}

	/**Recuperer la race du personnage
	 * @return race
	 */
	public Race getRace() {
		return this.race;
	}

	/**Recuperer le nom du personnage
	 * @return nom
	 */
	public String getNom() {
		return this.nom;
	}

	/**Recuperer la description du personnage
	 * @return description
	 */
	public String getDescription() {
		return this.description;
	}

	/**Recuperer la vie du personnage
	 * @return vitalite
	 */
	public int getVitalite() {
		return this.race.getVitalite();
	}

	/**Recuperer l'inventaire du personnage
	 * @return inventaire
	 */
	public Inventaire getInventaire() {
		return this.inventaire;
	}

	/**Recuperer l'equipement du personnage
	 * @return equipement
	 */
	public Equipement getEquipement() {
		return this.equipement;
	}

	/**Recuperer les statistiques du personnage (race, equipement,...)
	 * @return stats
	 */
	public Statistiques getStatistiques() {
		return this.stats.cumulStats(this.equipement.getStatsEquipement());
	}
	
	/** Recuperer uniquement les stats du personnage sans bonus equipement
	 * @return
	 */
	public Statistiques getStatistiquesPerso() {
		return this.stats;
	}

	//Commandes

	/**Nommer ou renommer le personnage
	 * @param nouveauNom
	 */
	public void setNom(String nouveauNom) {
		this.nom = nouveauNom;
	}

	/**Ecrire une description liée au personnage
	 * @param nouvelleDesc
	 */
	public void setDescription(String nouvelleDesc) {
		this.description = nouvelleDesc;
	}

	/**Modifier la position du personnage
	 * @param nouveauX
	 * @param nouveauY
	 */
	public void setPosition(int nouveauX, int nouveauY) {
		this.position.setX(nouveauX);
		this.position.setY(nouveauY);
	}

	/**Modifier la race du personnage
	 * @param nouvelleRace
	 */
	public void setRace(Race nouvelleRace) {
		this.race = nouvelleRace;
	}

	/**Determiner l'attaque
	 * @return
	 */
	public int attaquer() {
		return this.stats.getForce();
	}

	public String toString(){
		return String.join(" ", nom, description);
	}
}
