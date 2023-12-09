package pack1;

public class UtilisateurFilmDTO {
	
	private int id;
	private String nom;
	
	public UtilisateurFilmDTO(int id, String nom) {
		this.id = id;
		this.nom = nom;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNom() {
		return nom;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}


}
