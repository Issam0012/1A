import java.util.List;

/** Quelques outils (méthodes) sur les listes.  */
public class Outils {

	/** Retourne vrai ssi tous les éléments de la collection respectent le critère. */
	public static <E1, E2 extends E1> boolean tous(
			List<E2> elements,
			Critere<E1> critere)
	{
		boolean respect = true;
		for (int i=0; i<elements.size(); i++) {
		    respect = respect && critere.satisfaitSur(elements.get(i));
		}
		return respect;	// TODO à corriger
	}


	/** Ajouter dans resultat tous les éléments de la source
	 * qui satisfont le critère aGarder.
	 */
	public static <E1, E2 extends E1, E3 extends E2> void filtrer(
			List<E3> source,
			Critere<E2> aGarder,
			List<E1> resultat)
	{
		for (int i=0; i<source.size(); i++) {
		    if (aGarder.satisfaitSur(source.get(i))) {
		        resultat.add(source.get(i));
		    }
		}
		// TODO : à corriger
	}

}
