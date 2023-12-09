package hello;

import java.util.*;

import javax.persistence.*;

@Entity
public class Personne {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String nom;
	private String prenom;
	
	@OneToMany(fetch=FetchType.EAGER)
	private Collection<Adresse> adresses = new ArrayList<Adresse>();
	
	public Personne() {}
	
	public Personne(String nom, String prenom) {
		this.nom = nom;
		this.prenom = prenom;
	}
	
	
	public String getNom() {return this.nom;}
	public String getPrenom() {return this.prenom;}
	public int getId() {return this.id;}
	public Collection<Adresse> getAdresses() {return this.adresses;}
	
	public void setNom(String nom) {this.nom = nom;}
	public void setPrenom(String prenom) {this.prenom = prenom;}
	public void setId(int id) {this.id = id;}
	public void addAdress(Adresse adress) {adresses.add(adress);}
}
