

public class EnsembleChaine<A> implements Ensemble<A> {
	
	protected Cellule<A> cellule;
	protected int capacite;
	
	/** Le constructeur de cet ensemble.
	 * @param x l'élément à ajouter */
	public EnsembleChaine() {
		this.cellule = null;
		this.capacite = 0;
	}
	
	
	/** Obtenir le nombre d'éléments dans l'ensemble.
	 * @return nombre d'éléments dans l'ensemble.  */
	/*@ pure helper @*/ public int cardinal() {
		return this.capacite;
	}
	
	/** Savoir si l'ensemble est vide.
	 * @return Est-ce que l'ensemble est vide ? */
	/*@ pure helper @*/ public boolean estVide() {
		return (this.capacite == 0);
	}
	
	/** Savoir si un élément est présent dans l'ensemble.
	 * @param x l'élément cherché
	 * @return x est dans l'ensemble */
	/*@ pure helper @*/ public boolean contient(A x) {
		Cellule<A> c = this.cellule;
		Boolean contient = false;
		for (int i = 1; i<=capacite; i++) {
			if (c.element == x) {
				contient = true;
			}
			c = c.suivant;
		}
		return contient;
	}

	/** Ajouter un élément dans l'ensemble.
	 * @param x l'élément à ajouter */
	//@ ensures contient(x);        // élément ajouté
	public void ajouter(A x) {
		if ( ! this.contient(x)) {
		this.cellule = new Cellule<A>(x, this.cellule);
		this.capacite = this.capacite + 1;
		}
	}

	/** Enlever un élément de l'ensemble.
	  * @param x l'élément à supprimer */
	//@ ensures ! contient(x);      // élément supprimé
	public void supprimer(A x) {
		Cellule<A> c = this.cellule;
		this.cellule = null;
		for (int i = 1; i<=capacite; i++) {
			if (c.element != x) {
				this.cellule = new Cellule<A>(c.element, this.cellule);
			} else {
				this.capacite = this.capacite - 1;
			}
			c = c.suivant;
		}
	}
	
}
