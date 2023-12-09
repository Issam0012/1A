package pack1;

import java.util.ArrayList;
import java.util.Collection;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class,property="pseudo")
public class Utilisateur {

	@Id
	private String pseudo;

	private String nom;
	private String prenom;
	private String mdp;
	private String naissance;
	@ManyToMany(fetch = FetchType.EAGER, cascade = {CascadeType.PERSIST,CascadeType.MERGE})
	@JoinTable(name="utilisateur_Film",
			joinColumns = @JoinColumn(name = "pseudo_utilisateur"),
			inverseJoinColumns = @JoinColumn(name = "id_film")
			)
	@JsonIgnoreProperties(value = "utilisateurs")
	private Collection<Film> films = new ArrayList<Film>();

	@OneToMany(mappedBy = "utilisateur", fetch = FetchType.EAGER)
	@JsonIgnoreProperties(value = "utilisateur")
	private Collection<Note> notes = new ArrayList<Note>();
	
	public Utilisateur (){		
	}

	public Utilisateur(String pseudo, String mdp) {
		this.pseudo = pseudo;
		this.mdp = mdp;
	}
	public Utilisateur(String pseudo) {
		this.pseudo = pseudo;
	}

	public Utilisateur(String pseudo, String nom, String prenom, String mdp) {
		this.pseudo = pseudo;
		this.mdp = mdp;
		this.nom = nom;
		this.prenom = prenom;
	}
	public Utilisateur(String pseudo, String nom, String mdp) {
		this.pseudo = pseudo;
		this.mdp = mdp;
		this.nom = nom;
	}
	public String getPseudo() {
		return pseudo;
	}
	public void setPseudo(String pseudo) {
		this.pseudo = pseudo;
	}
	public String getMdp() {
		return mdp;
	}
	public void setMdp(String mdp) {
		this.mdp = mdp;
	}
	public String getPrenom() {
		return prenom;
	}
	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}
	public String getNom() {
		return nom;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}
	public Collection<Film> getFilms() {
		return films;
	}
	public void setFilms(Collection<Film> films) {
		this.films = films;
	}
	public void addFilm(Film film) {
		this.films.add(film);
	}
	public Collection<Note> getNotes() {
		return notes;
	}
	public void setNotes(Collection<Note> notes) {
		this.notes = notes;
	}
	public String getNaissance() {
		return naissance;
	}
	public void setNaissance(String naissance) {
		this.naissance = naissance;
	}

}
