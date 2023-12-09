package pack1;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.ArrayList;
import java.util.Collection;

public class UtilisateurDTO {
	private String pseudo;
    private String nom;
    private String prenom;
    private String mdp;
    private String naissance;
    private Collection<UtilisateurFilmDTO> films = new ArrayList<>();
    private Collection<NoteDTO> notes = new ArrayList<>();
    

    public UtilisateurDTO() {
    }

    public UtilisateurDTO(String pseudo, String nom, String prenom, String mdp, String naissance) {
        this.pseudo = pseudo;
        this.nom = nom;
        this.prenom = prenom;
        this.mdp = mdp;
        this.naissance = naissance;
    }

    // Getters and setters

    public String getPseudo() {
        return pseudo;
    }

    public void setPseudo(String pseudo) {
        this.pseudo = pseudo;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getMdp() {
        return mdp;
    }

    public void setMdp(String mdp) {
        this.mdp = mdp;
    }

    public String getNaissance() {
        return naissance;
    }

    public void setNaissance(String naissance) {
        this.naissance = naissance;
    }

	public Collection<UtilisateurFilmDTO> getFilms() {
		return films;
	}

	public void setFilms(Collection<UtilisateurFilmDTO> films) {
		this.films = films;
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
