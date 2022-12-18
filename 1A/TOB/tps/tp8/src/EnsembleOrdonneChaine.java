
public class EnsembleOrdonneChaine extends EnsembleChaine<A> implements EnsembleOrdonne  {
	
	/** Avoir le plus petit élément de l'ensemble. */
	public int minimum() {
		int min = this.cellule.element;
		Cellule c = this.cellule;
		for (int i = 1; i<=capacite; i++) {
			if (c.element < min) {
				min = c.element;
			}
			c = c.suivant;
		}
		return min;
	}
	
}
