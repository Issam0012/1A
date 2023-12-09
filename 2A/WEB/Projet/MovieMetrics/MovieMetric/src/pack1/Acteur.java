package pack1;

import java.util.Collection;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Acteur {
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int id;
	private String nom;
	private String naissance;
	private String descr;
	private String photo;
	private String films_absents;
	@ManyToMany(mappedBy = "acteurs", fetch = FetchType.EAGER)
	@JsonIgnoreProperties(value = "acteurs")
	private Collection<Film> films;
	
	public Acteur() {}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public Acteur(String nom) { 
		this.nom = nom;
	}
	public String getNom() {
		return nom;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}
	public String getNaissance() {
		return naissance;
	}
	public void setNaissance(String naissance) {
		this.naissance = naissance;
	}
	public String getDescription() {
		return descr;
	}
	public void setDescription(String descr) {
		this.descr = descr;
	}

	public Collection<Film> getFilms() {
		return films;
	}

	public void setFilms(Collection<Film> films) {
		this.films = films;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getFilms_absents() {
		return films_absents;
	}

	public void setFilms_absents(String films_absents) {
		this.films_absents = films_absents;
	}
}
