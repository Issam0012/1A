package editeur.commande;

import editeur.Ligne;

public class CommandeRaz extends CommandeLigne {

	/** Initialiser la ligne sur laquelle travaille
	 * cette commande.
	 * @param l la ligne
	 */
	//@ requires l != null;	// la ligne doit être définie
	public CommandeRaz(Ligne l) {
		super(l);
	}

	public void executer() {
		ligne.raz();
	}

	public boolean estExecutable() {
		return ligne.getLongueur() > 0;
	}
}
