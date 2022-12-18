

public class Cellule<A> {

	public A element;
	public Cellule<A> suivant;
	
	/** Le constructeur de cet ensemble.
	 * @param x l'élément à ajouter */
	//@ ensures contient(x);        // élément ajouté
	public Cellule(A x, Cellule<A> c) {
		this.element = x;
		this.suivant = c;
	}

}
