package modele;

public class RaceHumain implements Race {
	
	private Statistiques statsHumain;
	private int tailleInventaire;
	private int vitalite;
	private String race = "Humain";
	
	/** Le constructeur */
	public RaceHumain() {
		this.statsHumain = new Statistiques(3,4,3,2,1);
		this.tailleInventaire = 10;
		this.vitalite = 10;
	}

	/**
	 * Recuperer la taille de l'inventaire lié à la race
	 * @return tailleInventaire
	 */
	public int getInventaireDispo() {
		return this.tailleInventaire;
	}
	
	/**
	 * Recuperer la vitalite associée à la race
	 * @return vitalite
	 */
	public int getVitalite() {
		return this.vitalite;
	}
	
	/**
	 * Recuperer statistique liée à la race
	 */
	public Statistiques getStatistiques() {
		return this.statsHumain;
	}

	@Override
	public String getRace() {
		return this.race;
	}

}
