package modele;

import java.awt.Color;

import controleur.deplacement;

public class Joueur {
	
	private Personnage personnage;
	private Color couleur;
	private deplacement deplacement;
	
	/** Le constructeur */
	public Joueur(Personnage personnage, Color couleur) {
		this.personnage = personnage;
		this.couleur = couleur;
	}
	
	public Joueur(Personnage personnage, Color couleur, deplacement deplacement) {
		this.personnage = personnage;
		this.couleur = couleur;
		this.deplacement = deplacement;
	}
	
	/** Recuperer le personnage joué par le joueur
	 * @return personnage
	 */
	public Personnage getPersonnage() {
		return personnage;
	}
	
	/**
	 * Recuperer la couleur du joueur
	 * @return couleur
	 */
	public Color getCouleur() {
		return couleur;
	}
	
	public void deplacerPersonnage() {
		
		int x = this.personnage.getPosition().getX();
		if (x == deplacement.partie.getEnv().getLargeur()) {
			deplacement.droite = false;
		}
		if (x == 0) {
			deplacement.gauche = false;
		}

		int y = this.personnage.getPosition().getY();
		if (y == deplacement.partie.getEnv().getHauteur()) {
			deplacement.haut = false;
		}
		if (y == 0) {
			deplacement.bas = false;
		}
		
		if (deplacement.bas) {
			this.personnage.setPosition(x, y - 1);
		} else if(deplacement.haut) {
			this.personnage.setPosition(x, y + 1);
		} else if(deplacement.droite) {
			this.personnage.setPosition(x + 1, y);
		}   else if(deplacement.gauche) {
			this.personnage.setPosition(x - 1, y);
		} else {
			
		}
	}
}
