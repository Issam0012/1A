package pack1;

public class NoteDTO {
	
	private int idFilm;
	private String pseudo;
	private int note;
	
	public NoteDTO(int idFilm, String pseudo, int note) {
		this.idFilm = idFilm;
		this.pseudo = pseudo;
		this.note = note;
	}
	
	public int getIdFilm() {
		return idFilm;
	}
	public void setIdFilm(int idFilm) {
		this.idFilm = idFilm;
	}
	public String getPseudo() {
		return pseudo;
	}
	public void setPseudo(String pseudo) {
		this.pseudo = pseudo;
	}
	public int getNote() {
		return note;
	}
	public void setNote(int note) {
		this.note = note;
	}
	
	
}
