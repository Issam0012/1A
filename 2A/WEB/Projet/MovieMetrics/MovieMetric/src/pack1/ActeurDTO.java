package pack1;
import java.util.*;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class ActeurDTO {
	
	private int id;
	private String nom;
	private String naissance;
	private String description;
	private String photo;
	private String films_absents;
	private Collection<UtilisateurFilmDTO> films = new ArrayList<UtilisateurFilmDTO>();
	
	public ActeurDTO(int id, String nom, String naissance, String description, String photo, String films_absents) {
		this.id = id;
		this.nom = nom;
		this.naissance = naissance;
		this.description = description;
		this.photo = photo;
		this.films_absents = films_absents;
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
	public String getNaissance() {
		return naissance;
	}
	public void setNaissance(String naissance) {
		this.naissance = naissance;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public Collection<UtilisateurFilmDTO> getFilms() {
		return films;
	}
	public void setFilms(Collection<UtilisateurFilmDTO> films) {
		this.films = films;
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

	public String getFilms_absents() {
		return films_absents;
	}

	public void setFilms_absents(String films_absents) {
		this.films_absents = films_absents;
	}
	
}
