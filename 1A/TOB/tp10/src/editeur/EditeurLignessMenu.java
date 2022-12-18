package editeur;

import editeur.commande.*;
import menu.Menu;

public class EditeurLignessMenu {
	
	/** La ligne de notre éditeur */
	private Ligne ligne;

	/** Le menu principal de l'éditeur */
	private MenuPrincipal menuPrincipal;
	private Menu SsMenu_1;
	private Menu SsMenu_2;

	/** Initialiser l'éditeur à partir de la lign à éditer. */
	public EditeurLignessMenu(Ligne l) {
		ligne = l;

		// Créer le menu principal
		menuPrincipal = new Menu("Menu principal");
		this.SsMenu_1 = new Menu("Sous-menu 1");
		this.SsMenu_2 = new Menu("Sous-menu 2");
		
		this.SsMenu_1.ajouter("Ajouter un texte en fin de ligne",
					new CommandeAjouterFin(ligne));
		this.SsMenu_2.ajouter("Avancer le curseur d'un caractère",
					new CommandeCurseurAvancer(ligne));
		this.SsMenu_2.ajouter("Reculer le curseur d'un caractère",
					new CommandeCurseurReculer(ligne));
		this.SsMenu_2.ajouter("Ramener le curseur sur le premier caractère de la ligne",
				new CommandeRaz(ligne));
		this.SsMenu_2.ajouter("Supprimer le caractère sous le curseur",
				new CommandeSupprimer(ligne));
	}

	public void editer() {
		do {
			// Afficher la ligne
			System.out.println();
			ligne.afficher();
			System.out.println();

			// Afficher le menu
			menuPrincipal.afficher();
			
			// Afficher les sous-menus
			SsMenu_1.afficher();
			SsMenu_2.afficher();

			// Sélectionner une entrée dans le menu
			menuPrincipal.selectionner();
			
			

			// Valider l'entrée sélectionnée
			menuPrincipal.valider();

		} while (! menuPrincipal.estQuitte());
	}
	
}
