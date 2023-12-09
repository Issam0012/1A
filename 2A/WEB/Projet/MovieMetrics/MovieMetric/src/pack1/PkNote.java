package pack1;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Embeddable;
import javax.persistence.Id;

@Embeddable
public class PkNote implements Serializable{
	
	
	private static final long serialVersionUID = 1L;
	@Id
	private int idFilm;
	@Id
	private String pseudo;
	
	public PkNote() {
		
	}
	
	public PkNote(int idFilm, String pseudo) {
		this.idFilm = idFilm;
		this.pseudo = pseudo;
	}
	
	public int getIdFilm() {
		return idFilm;
	}
	
	public void setIdFilm(int idfilm) {
		this.idFilm = idfilm;
	}
	
	public String getPseudo() {
		return pseudo;
	}
	
	public void setPseudo(String pseudo) {
		this.pseudo = pseudo;
	}

	@Override
	public int hashCode() {
		return Objects.hash(idFilm, pseudo);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PkNote other = (PkNote) obj;
		return idFilm == other.idFilm && Objects.equals(pseudo, other.pseudo);
	}

	@Override
	public String toString() {
		return "PkNote [idFilm=" + idFilm + ", pseudo=" + pseudo + "]";
	}
	
	

}
