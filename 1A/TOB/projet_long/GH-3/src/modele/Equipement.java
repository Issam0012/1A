package modele;

public class Equipement {
	
	private EquipableTete tete;
	private EquipableArmure armure;
	private EquipableArme arme;
	private EquipableBottes bottes;
	private Statistiques statEquipement;
	
	/** Constructeur */
	public Equipement() {
		this.tete = new EquipableTete("Rien", "Aucun effet");
		this.armure = new EquipableArmure("Toje de paysan", "Sert uniquement d'habits");
		this.arme = new EquipableArme("Poing", "Moyen de defense primaire");
		this.bottes = new EquipableBottes("Pied", "Ce n'est pas très agréable");
		Statistiques statTeteArmure = tete.getStatistiques().cumulStats(armure.getStatistiques());
		Statistiques statArmeBottes = arme.getStatistiques().cumulStats(bottes.getStatistiques());
		this.statEquipement = statTeteArmure.cumulStats(statArmeBottes);
	}
	
	/**
	 * Recuperer statistiques globale de l'équipement
	 * @return
	 */
	public Statistiques getStatsEquipement() {
		return this.statEquipement;
	}
	
	/**
	 * Recuperer l'equipement de la tête
	 * @return
	 */
	public EquipableTete getTete() {
		return this.tete;
	}
	
	/**
	 * Recuperer l'armure
	 * @return
	 */
	public EquipableArmure getArmure() {
		return this.armure;
	}
	
	/**
	 * Recuperer arme
	 * @return
	 */
	public EquipableArme getArme() {
		return this.arme;
	}
	
	/**
	 * Recuperer bottes
	 * @return
	 */
	public EquipableBottes getBottes() {
		return this.bottes;
	}
	
	/**
	 * Echanger l'equipement de la tete par un nouvel equipement de tete
	 * @param nouvelleTete
	 */
	public void echangerEquipementTete(EquipableTete nouvelleTete) {
		this.tete = nouvelleTete;
		recalculStatsEquip();
	}
	
	/**
	 * Echanger armure par une nouvelle armure
	 * @param nouvelleArmure
	 */
	public void echangerEquipementArmure(EquipableArmure nouvelleArmure) {
		this.armure = nouvelleArmure;
		recalculStatsEquip();
	}
	
	/**
	 * Echanger arme par une nouvelle arme
	 * @param nouvelleArme
	 */
	public void echangerEquipementArme(EquipableArme nouvelleArme) {
		this.arme = nouvelleArme;
		recalculStatsEquip();
	}
	
	/**
	 * Echanger bottes par de nouvelle bottes
	 * @param nouvelleBottes
	 */
	public void echangerEquipementBottes(EquipableBottes nouvelleBottes) {
		this.bottes = nouvelleBottes;
		recalculStatsEquip();
	}
	
	/**
	 * Recalculer les statistiques appres modif
	 */
	private void recalculStatsEquip() {
		Statistiques statTeteArmure = tete.getStatistiques().cumulStats(armure.getStatistiques());
		Statistiques statArmeBottes = arme.getStatistiques().cumulStats(bottes.getStatistiques());
		this.statEquipement = statTeteArmure.cumulStats(statArmeBottes);
	}
	
}