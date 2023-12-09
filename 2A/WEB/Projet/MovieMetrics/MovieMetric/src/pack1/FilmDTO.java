package pack1;

import java.util.ArrayList;
import java.util.Collection;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class FilmDTO {

	private int id;
	private String nom;
	private String release_date;
	private String synopsis;
	private String genres;
	private String affiche;
	private Collection<String> utilisateurs = new ArrayList<String>();
	
	private Collection<FilmActeurDTO> acteurs = new ArrayList<FilmActeurDTO>();
	
	
	private Collection<NoteDTO> notes = new ArrayList<NoteDTO>();
	
	public FilmDTO(int id, String nom, String realease_date, String synopsis, String genres, String affiche){
		this.id = id;
		this.nom = nom;
		this.release_date = realease_date;
		this.synopsis = synopsis;
		this.genres = genres;
		this.affiche = affiche;
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
	
	public Collection<FilmActeurDTO> getActeurs() {
		return acteurs;
	}
	public void setActeurs(Collection<FilmActeurDTO> acteurs) {
		this.acteurs = acteurs;
	}
	public Collection<String> getUtilisateurs() {
		return utilisateurs;
	}
	public void setUtilisateurs(Collection<String> utilisateurs) {
		this.utilisateurs = utilisateurs;
	}
	public String getAffiche() {
		return affiche;
	}
	public void setAffiche(String affiche) {
		this.affiche = affiche;
	}
	public Collection<NoteDTO> getNotes() {
		return notes;
	}
	public void setNotes(Collection<NoteDTO> notes) {
		this.notes = notes;
	}
	
	public String toJson() {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            return objectMapper.writeValueAsString(this);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return null;
        }
    }
}
