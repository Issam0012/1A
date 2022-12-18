package modele;

public class Position {

	//Attributs
	private int x;
	private int y;
	
	/** Le constructeur */
	public Position(int x, int y) {
		this.x = x;
		this.y = y;
	}
	
	/**
	 * Modifier position abscisse
	 * @param nouveauX
	 */
	public void setX(int nouveauX) {
		this.x = nouveauX;
	}
	
	/**
	 * Modifier position ordonnée
	 * @param nouveauY
	 */
	public void setY(int nouveauY) {
		this.y = nouveauY;
	}
	
	/**
	 * Permet de recuperer la position en abscisse
	 * @return x, abscisse
	 */
	public int getX() {
		return this.x;
	}
	
	/**
	 * Permet de recuperer la position en ordonée
	 * @return y, ordonnée
	 */
	public int getY() {
		return this.y;
	}
	
}
