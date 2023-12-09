package pack1;

import java.awt.List;
import java.util.ArrayList;
import java.util.Collection;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class,property="id")
public class Film {
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int id;
	private String nom;
	private String release_date;
	private int note;
	private String synopsis;
	private String genres;
	private String affiche;
	@ManyToMany(mappedBy = "films", fetch = FetchType.EAGER)
	@JsonIgnoreProperties(value = "films")
	private Collection<Utilisateur> utilisateurs = new ArrayList<Utilisateur>();
	
	@ManyToMany(fetch= FetchType.EAGER)
	@JsonIgnoreProperties(value = "films")
	private Collection<Acteur> acteurs = new ArrayList<Acteur>();
	
	@OneToMany(mappedBy ="film", fetch = FetchType.EAGER)
	@JsonIgnoreProperties(value = "film")
	private Collection<Note> notes = new ArrayList<Note>();
	
	public Film(){}
	public Film(String nom) {
		
		this.nom=nom;
	}
	public String getNom() {
		return nom;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getRelease_date() {
		return release_date;
	}
	public void setRelease_date(String release_date) {
		this.release_date = release_date;
	}
	public int getNote() {
		return note;
	}
	public void setNote(int note) {
		this.note = note;
	}
	public String getSynopsis() {
		return synopsis;
	}
	public void setSynopsis(String synopsis) {
		this.synopsis = synopsis;
	}
	public String getGenres() {
		return genres;
	}
	public void setGenres(String genres) {
		this.genres = genres;
	}
	
	public Collection<Acteur> getActeurs() {
		return acteurs;
	}
	public void setActeurs(Collection<Acteur> acteurs) {
		this.acteurs = acteurs;
	}
	public Collection<Utilisateur> getUtilisateurs() {
		return utilisateurs;
	}
	public void setUtilisateurs(Collection<Utilisateur> utilisateurs) {
		this.utilisateurs = utilisateurs;
	}
	public String getAffiche() {
		return affiche;
	}
	public void setAffiche(String affiche) {
		this.affiche = affiche;
	}
	public Collection<Note> getNotes() {
		return notes;
	}
	public void setNotes(Collection<Note> notes) {
		this.notes = notes;
	}
	
}
