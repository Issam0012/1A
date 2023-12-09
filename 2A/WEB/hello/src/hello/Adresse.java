package hello;

import javax.persistence.*;

@Entity
public class Adresse {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String rue;
	private String ville;
	
	public Adresse() {}
	
	public Adresse(String rue, String ville) {
		this.rue = rue;
		this.ville = ville;
	}
	
	public String getRue() {return this.rue;}
	public String getVille() {return this.ville;}
	public int getId() {return this.id;}
	
	public void setRue(String rue) {this.rue = rue;}
	public void setVille(String ville) {this.ville = ville;}
	public void setId(int id) {this.id = id;}
}