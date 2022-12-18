package modele;

import java.util.*;

public class Inventaire {
	
	// Attributs
	private ArrayList<Objet> inventaire;
	private int placeRestantes;
	
	/** Constructeur */
	public Inventaire(Race race) {
		this.placeRestantes = race.getInventaireDispo();
	}
	
	/**
	 * Recuperer l'inventaire
	 * @return
	 */
	public ArrayList<Objet> getInventaire() {
		ArrayList<Objet> inventaireCopy = this.inventaire;
		return inventaireCopy;
	}
	
	/**
	 * Recuperer le nombre de place restante dans l'inventaire des personnages
	 * @return
	 */
	public int getPlaceRestantes() {
		return this.placeRestantes;
	}
	
	/**
	 * Ajouter un objet dans l'inventaire
	 * @param objet
	 * @throws AjoutInventaireImpossibleException
	 */
	public void addContenu(Objet objet) throws AjoutInventaireImpossibleException {
		if (this.placeRestantes > 0) {
			this.inventaire.add(objet);
			this.placeRestantes = this.placeRestantes - 1;
		} else {
			throw new AjoutInventaireImpossibleException("Inventaire plein");
		}
	}
	
	/**
	 * Retirer un objet de l'inventaire
	 * @param objet
	 * @throws AjoutInventaireImpossibleException
	 */
	public void removeContenu(Objet objet) throws AjoutInventaireImpossibleException {
		if (this.inventaire.contains(objet)) {
			this.inventaire.remove(objet);
			this.placeRestantes = this.placeRestantes + 1;
		} else {
			throw new AjoutInventaireImpossibleException("Objet introuvable");
		}
	}

}
