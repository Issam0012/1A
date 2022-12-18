/**mini-projet
 * Un cercle est une courbe plane fermée constituée des points situés à égale 
 distance d’un point nommé centre. La valeur de cette distance est appelée 
 rayon du cercle. On appelle diamètre la distance entre deux points 
 diamétralement opposés. La valeur du diamètre est donc le double de
 la valeur du rayon. On va modéliser un cercle à l'aide de son centre et de son
 rayon et de sa couleur. On aura aussi la possibilité de construire un cercle
 avec d'autres moyens. Le cercle peut être translaté et affiché. On peut avoir
 et modifier ses paramètres par des méthodes principales
 * @author ALOUANE Issam
 */

import java.awt.Color;

public class Cercle implements Mesurable2D {

    private Point centre;
    private double rayon;
    private Color couleur;
    

    public final static double PI = Math.PI;


	/** Construire un cercle à partir de son centre et de son rayon.
	 * @param centreCercle le centre du cercle
	 * @param rayonCercle le rayon du cercle
	 */
	public Cercle(Point centreCercle, double rayonCercle) {
	
	    assert centreCercle!=null && rayonCercle>0;
	    
		this.rayon = rayonCercle;
        this.centre = new Point (centreCercle.getX(),centreCercle.getY());
		this.setCouleur(Color.blue);
	}
	
	
	/** Construire un cercle à partir de deux points diamétralement opposés.
	 * @param point1 le premier point
	 * @param point2 le deuxième point
	 */
	public Cercle(Point point1, Point point2) {
	
	    assert point1!=null && point2!=null;
	    assert point1.getX() != point2.getX() || point1.getY() != point2.getY();
	    
		double cx = (point1.getX()+point2.getX())/2.0;
		double cy = (point1.getY()+point2.getY())/2.0;
		
		this.rayon = point1.distance(point2)/2.0;
		this.centre = new Point(cx, cy);
		this.setCouleur(Color.blue);
	}
	
	
	/** Construire un cercle à partir de deux points diamétralement opposés et de sa couleur.
	 * @param point1 le premier point
	 * @param point2 le deuxième point
	 * @param couleurCercle la couleur du cercle
	 */
	public Cercle(Point point1, Point point2, Color couleurCercle) {
	
	    this(point1, point2);
	
	    assert couleurCercle!=null;
	    
	    this.setCouleur(couleurCercle);
	}
	
	
	/** Construire un cercle à partir de son centre et d'un point de sa circonférence.
	 * @param centreCercle le centre du cercle
	 * @param point le point qui appartient au cercle
	* @return le cercle créé
	 */
	public static Cercle creerCercle(Point centreCercle, Point point) {
	
	    assert centreCercle!=null && point!=null;
	    assert centreCercle.getX() != point.getX() || centreCercle.getY() != point.getY();
	    
	    return new Cercle(centreCercle, centreCercle.distance(point));
	}
	
	
	/** Translater le cercle.
	* @param dx déplacement du centre suivant l'axe des X
	* @param dy déplacement du centre suivant l'axe des Y
	*/
	public void translater(double dx, double dy) {
	
		this.centre.translater(dx,dy);
	}
	
	
	/** obtenir le centre d'un cercle.
	* @return le centre du cercle
	*/
	public Point getCentre() {
	    
	    double x = this.centre.getX();
	    double y = this.centre.getY();
	    
        return new Point(x, y);
	}
	
	
	/** obtenir le rayon d'un cercle.
	* @return le rayon du cercle
	*/
	public double getRayon() {
	    return this.rayon;
	}
	
	
	/** obtenir le diamètre d'un cercle.
	* @return le diamètre du cercle
	*/
	public double getDiametre() {
	    return 2.0 * this.rayon;
	}
	
	
	/** Savoir si un point est à l'intérieur d'un cercle ou pas.
	* @param A le point à tester
	*/
	public boolean contient(Point point) {
	
	    assert point!=null;
	    
		return (this.centre.distance(point) <= this.rayon);
	}
	
	
	/** obtenir le périmètre d'un cercle.
	* @return le perimètre du cercle
	*/
	public double perimetre() {
	    return 2.0 * PI * this.rayon;
	}
	
	
	/** obtenir la surface d'un cercle.
	* @return la surface du cercle
	*/
	public double aire() {
	    return PI * this.rayon * this.rayon;
	}
	
	
	/** Obtenir la couleur du cercle.
	 * @return la couleur du cercle
	 */
	public Color getCouleur() {
		return this.couleur;
	}


	/** Changer la couleur du cercle.
	  * @param nouvelleCouleur la nouvelle couleur
	  */
	public void setCouleur(Color nouvelleCouleur) {
	
	    assert nouvelleCouleur!=null;
	    
		this.couleur = nouvelleCouleur;
	}
	
	
	/**Redéfinition de la méthode toString pour achever l'affichage demandé.
     *@return chaine de caractère, qui montre la cercle sous la forme demandée.
     */
	public String toString() {
		return "C" + this.rayon + "@" + this.centre;
	}
	
	
	/** Afficher le cercle. */
	public void afficher(){
        System.out.print(this);
    }
	
	
	/** Changer le rayon du cercle.
	  * @param nouveauRayon le nouveau rayon
	  */
	public void setRayon(double nouveauRayon) {
	
	    assert nouveauRayon>0;
	    
		this.rayon = nouveauRayon;
	}
	
	
	/** Changer le diamètre du cercle.
	  * @param nouveauDiametre le nouveau diamètre
	  */
	public void setDiametre(double nouveauDiametre) {
	
	    assert nouveauDiametre>0;   
	    
		this.setRayon(nouveauDiametre / 2.0);
	}

}
