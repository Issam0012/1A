package modele;

public class Objet {
	
	//Attributs 
	private String nomObjet;
	private String descriptionObjet;
	
	public Objet(String nom, String desc) {
		this.nomObjet = nom;
		this.descriptionObjet = desc;
	}
	
	/**
	 * Recuperer le nom de l'objet
	 * @return String
	 */
	public String getNom() {
		return this.nomObjet;
	}
	
	/**
	 * Recuperer description de l'objet
	 * @return String
	 */
	public String getDesc() {
		return this.descriptionObjet;
	}
}
