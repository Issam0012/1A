package modele;

public abstract class Equipable extends Objet {
	
	// Attributs
	private Statistiques statsEquipable;
	
	/** Les consctructeur */
	public Equipable(String nom, String desc) {
		super(nom, desc);
		this.statsEquipable = new Statistiques(0,0,0,0,0);
	}
	
	public Equipable(String nom, String desc, Statistiques statsEquipable) {
		super(nom, desc);
		this.statsEquipable = statsEquipable;
	}
	
	/**
	 * Recuperer statistiques equipable
	 * @return statistiques
	 */
	 public Statistiques getStatistiques() {
		return this.statsEquipable;
	}

}
