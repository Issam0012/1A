package modele;

public class Statistiques {
	
	// Attributs
	private int force;
	private int intelligence;
	private int vitesse;
	private int chance;
	private int resistance;
	
	public Statistiques(int force, int intelligence,
			int vitesse, int chance, int resistance) {
		this.force = force;
		this.intelligence = intelligence;
		this.vitesse = vitesse;
		this.chance = chance;
		this.resistance = resistance;
	}

	/**
	 * Recuperer la statistique de force
	 * @return force
	 */
	public int getForce() {
		return this.force;
	}
	
	/** Récuperer la stat d'intelligence
	 * @return intelligence
	 */
	public int getIntelligence() {
		return this.intelligence;
	}
	
	/** Récuperer la stat de vitesse
	 * @return vitesse
	 */
	public int getVitesse() {
		return this.vitesse;
	}
	
	/** Récuperer la stat de chance
	 * @return chance
	 */
	public int getChance() {
		return this.chance;
	}
	
	/** Récuperer la stat de resistance
	 * @return resistance
	 */
	public int getResistance() {
		return this.resistance;
	}
	
	/** Ajouter ou retirer de la force
	 * Le parametre peut soit être positif soit négatif
	 * @param gain, positif ou négatif
	 */
	public void addForce(int gain) {
		if(gain < this.force) {
			this.force = this.force + gain;
		}
	}
	
	/** Ajouter ou retirer de l'intelligence
	 * Le parametre peut soit être positif soit négatif
	 * @param gain
	 */
	public void addIntelligence(int gain) {
		if(gain < this.intelligence) {
			this.intelligence = this.intelligence + gain;
		}
	}
	
	/** Ajouter ou retirer de la vitesse
	 * Le parametre peut soit être positif soit négatif
	 * @param gain
	 */
	public void addVitesse(int gain) {
		if(gain < this.vitesse) {
			this.vitesse = this.vitesse + gain;
		}
	}
	
	/** Ajouter ou retirer de la chance
	 * Le parametre peut soit être positif soit négatif
	 * @param gain
	 */
	public void addChance(int gain) {
		if(gain < this.chance) {
			this.chance = this.chance + gain;
		}
	}
	
	/** Ajouter ou retirer de la resistance
	 * Le parametre peut soit être positif soit négatif
	 * @param gain
	 */
	public void addResistance(int gain) {
		if(gain < this.resistance) {
			this.resistance = this.resistance + gain;
		}
	}
	
	public Statistiques cumulStats(Statistiques statCumul) {
		int cumulForce = this.force + statCumul.force;
		int cumulIntel = this.intelligence + statCumul.intelligence;
		int cumulVitesse = this.vitesse + statCumul.vitesse;
		int cumulChance = this.chance + statCumul.chance;
		int cumulResistance = this.resistance + statCumul.resistance;
		return new Statistiques(cumulForce, cumulIntel,
				cumulVitesse, cumulChance, cumulResistance);
	}
}
