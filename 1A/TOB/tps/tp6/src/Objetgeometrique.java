
abstract public class Objetgeometrique {

	private java.awt.Color couleur; // couleur de l’objet

	/** Construire un objet géométrique.
	* @param c la couleur de l’objet géométrique */
	public Objetgeometrique(java.awt.Color c) { this.couleur = c; }

	/** Obtenir la couleur de cet objet.
	* @return la couleur de cet objet */
	public java.awt.Color getCouleur() { return this.couleur; }

	/** Changer la couleur de cet objet.
	* @param c nouvelle couleur */
	public void setCouleur(java.awt.Color c) { this.couleur = c; }
	
	/** Afficher sur le terminal les caractéristiques de l’objet. */
	abstract public void afficher();
	
	/** Translater l’objet géométrique.
	* @param dx déplacement en X
	* @param dy déplacement en Y */
	abstract public void translater(double dx, double dy);
	
	/** Le dessin d'un objet géométrique */
	abstract public void dessiner (afficheur.Afficheur afficheur);
}
