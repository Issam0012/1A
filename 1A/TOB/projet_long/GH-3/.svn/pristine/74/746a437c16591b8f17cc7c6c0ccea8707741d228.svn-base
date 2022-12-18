package modele;

import java.util.List;
import java.io.Serializable;
import java.util.ArrayList;

public class Plateau implements Serializable{
	
	private int largeur;
	private int hauteur;
	private String nom;
	private List<List<Object>> plateau;
	
	/** Le constructeur */
	public Plateau(int largeur, int hauteur, String nom) {
		this.largeur = largeur;
		this.hauteur = hauteur;
		this.nom = nom;
		this.plateau = new ArrayList<>();
		//Création plateau
		for (int i=0; i<hauteur; i++) {
			ArrayList<Object> ligne = new ArrayList<>();
			for (int j=0; j<largeur; j++) {
				ligne.add("image/tux.png");
			}
			this.plateau.add(ligne);
		}
	}
	
	/**
	 * Recuperer le nom du plateau
	 * @return nom
	 */
	public String getNom() {
		return nom;
	}

	/**
	 * Modifier une case du plateau
	 * @param ligne
	 * @param colonne
	 * @param path chemin de l'image
	 */
	public void setCase(int ligne, int colonne, String path) {
		List<Object> ligneModif = this.plateau.get(ligne);
		ligneModif.set(colonne, path);
	}
	
	/**
	 * Recuperer le plateau
	 * @return
	 */
	public List<List<Object>> getPlateau() {
		return plateau;
	}
	
	/**
	 * Recuperer le chemin de l'image associé a la case
	 * @param ligne
	 * @param colonne
	 * @return path
	 */
	public String getPath(int ligne, int colonne) {
		List<Object> ligneModif = this.plateau.get(ligne);
		return (String) ligneModif.get(colonne);
	}

	/**
	 * Choisir la taille du plateau
	 * @param largeur
	 * @param hauteur
	 */
	public void setTaille(int largeur, int hauteur) {
		this.largeur = largeur;
		this.hauteur = hauteur;
	}

	/**
	 * Recuperer la largeur du plateau
	 * @return largeur
	 */
	public int getLargeur() {
		return largeur;
	}

	/**
	 * Choisir la largeur du plateau
	 * @param largeur
	 */
	public void setLargeur(int largeur) {
		this.largeur = largeur;
	}

	/**
	 * Recuperer la hauteur du plateau
	 * @return hauteur
	 */
	public int getHauteur() {
		return hauteur;
	}

	/**
	 * Choisir la hauteur du plateau
	 * @param hauteur
	 */
	public void setHauteur(int hauteur) {
		this.hauteur = hauteur;
	}

}
