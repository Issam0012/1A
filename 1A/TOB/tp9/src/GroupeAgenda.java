import java.util.*;

public class GroupeAgenda {

	private int NbAgendas;
	
	private List<AgendaIndividuel> agenda;
	
	public GroupeAgenda (String nom) {
		this.NbAgendas = 1;
		this.agenda[NbAgendas] = new AgendaIndividuel(nom);
	}
	
	public void ajouter(Agenda agenda) {
		this.NbAgendas++;
		this.agenda[NbAgendas] = agenda;
	}
	
}
