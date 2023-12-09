package pack1;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class,property="id")
@JsonIgnoreProperties({"idFilm", "pseudo"})
public class Note {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int id;
	
	@ManyToOne(targetEntity=Film.class, fetch = FetchType.EAGER)
	@JoinColumn(name = "id_film")
	@JsonIgnoreProperties(value = "notes")
	private Film film;
	
	@ManyToOne(targetEntity=Utilisateur.class, fetch = FetchType.EAGER)
	@JoinColumn(name = "utilisateur_pseudo")
	@JsonIgnoreProperties(value = "notes")
	private Utilisateur utilisateur;
	
	private int note;
	
	public Note() {	
	}
	
	public Note(int note) {
		this.setNote(note);
	}

	public int getNote() {
		return note;
	}
	

	public void setNote(int note) {
		this.note = note;
	}
	
	public Film getFilm() {
		return film;
	}
	
	public void setFilm(Film film) {
		this.film = film;
	}
	
	public Utilisateur getUtilisateur() {
		return utilisateur;
	}
	
	public void setUtilisateur(Utilisateur utilisateur) {
		this.utilisateur = utilisateur;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
}
