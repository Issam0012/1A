package editeur.commande;

import editeur.Ligne;

public class CommandeSupprimer extends CommandeLigne {

	/** Initialiser la ligne sur laquelle travaille
	 * cette commande.
	 * @param l la ligne
	 */
	//@ requires l != null;	// la ligne doit être définie
	public CommandeSupprimer(Ligne l) {
		super(l);
	}

	public void executer() {
		ligne.supprimer();
	}

	public boolean estExecutable() {
		return ligne.getLongueur() > 0;
	}
}
