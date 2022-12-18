package modele;
import java.awt.Color;

/**
 * classe modélisant un dé
 *
 */
public class De {
	
	private int nbFaces;
	private Color couleurDe;
	private int valDe;
	
	// Constructeur
	public De(int vnbFaces, Color couleur) {
		this.nbFaces = vnbFaces;
		this.couleurDe = couleur;
		this.valDe = 1;
	}
	
	public De(int vnbFaces) {
		this.nbFaces = vnbFaces;
		this.couleurDe = Color.WHITE;
		this.valDe = 1;
	}
	
	// Lancer un De
	public int lancerDe() {
		 double r = Math.random();
		 int valeur = (int) Math.floor(r + (1 - r) * (this.nbFaces + 1));
		 this.valDe = valeur;
		 return valeur;
	}
	
	// Recuperer la derniere valeur prise par le de
	public int getValDe() {
		return valDe;
	}
	
	// Recuperer la couleur du de
	public Color getCouleur() {
		return couleurDe;
	}
	
	// Recuperer le nombre de faces d'un dé
	public int getNbFaces() {
		return this.nbFaces;
	}
	
	// Changer le nombre de faces d'un de
	public void setNbFaces(int nouvNbFaces) {
		this.nbFaces = nouvNbFaces;
	}
	
	// Changer la couleur d'un de
	public void setCouleur(Color nouvCouleur) {
		this.couleurDe = nouvCouleur;
	}
}
