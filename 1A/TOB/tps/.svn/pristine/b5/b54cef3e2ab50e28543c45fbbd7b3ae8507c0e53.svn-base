/** Tester le polymorphisme (principe de substitution) et la liaison
 * dynamique.
 * @author	Xavier Crégut
 * @version	1.5
 */
public class TestPolymorphisme {

	/** Méthode principale */
	public static void main(String[] args) {
		// Créer et afficher un point p1
		Point p1 = new Point(3, 4);	// Est-ce autorisé ? Oui Pourquoi ? Construction normal d'un point
		p1.translater(10,10);		// Quel est le translater exécuté ? translater de la classe Point
		System.out.print("p1 = "); p1.afficher (); System.out.println ();
										// Qu'est ce qui est affiché ? p1 = (13.0,14.0)

		// Créer et afficher un point nommé pn1
		PointNomme pn1 = new PointNomme (30, 40, "PN1");
										// Est-ce autorisé ? Oui Pourquoi ? Construction normal d'un point nommé
		pn1.translater (10,10);		// Quel est le translater exécuté ? translater de la classe Point
		System.out.print ("pn1 = "); pn1.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ? pn1 = PN1:(40.0,50.0)

		// Définir une poignée sur un point
		Point q;

		// Attacher un point à q et l'afficher
		q = p1;				// Est-ce autorisé ? Oui Pourquoi ? ils sont du même type
		System.out.println ("> q = p1;");
		System.out.print ("q = "); q.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ? q = (13.0,14.0)

		// Attacher un point nommé à q et l'afficher
		q = pn1;			// Est-ce autorisé ? Oui Pourquoi ? car Pointnommé hérite Point
		System.out.println ("> q = pn1;");
		System.out.print ("q = "); q.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ? q = PN1:(40.0,50.0)

		// Définir une poignée sur un point nommé
		PointNomme qn;

		// Attacher un point à q et l'afficher
		//qn = p1;			// Est-ce autorisé ? non Pourquoi ? PointNomme n'hérite pas Point
		//System.out.println ("> qn = p1;");
		//System.out.print ("qn = "); qn.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ? erreur

		// Attacher un point nommé à qn et l'afficher
		qn = pn1;			// Est-ce autorisé ? Oui Pourquoi ? même type
		System.out.println ("> qn = pn1;");
		System.out.print ("qn = "); qn.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ? qn = PN1:(30,40)

		double d1 = p1.distance (pn1);	// Est-ce autorisé ? Oui Pourquoi ? PointNomme hérite Point
		System.out.println ("distance = " + d1);

		double d2 = pn1.distance (p1);	// Est-ce autorisé ? Oui Pourquoi ? PointNomme hérite Point
		System.out.println ("distance = " + d2);

		double d3 = pn1.distance (pn1);	// Est-ce autorisé ? Oui Pourquoi ? même type (point  nommé)
		System.out.println ("distance = " + d3);

		//System.out.println ("> qn = q;");
		//qn = q;				// Est-ce autorisé ? Non Pourquoi ? PointNomme hérite Point
		//System.out.print ("qn = "); qn.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ? erreur

		System.out.println ("> qn = (PointNomme) q;");
		qn = (PointNomme) q;		// Est-ce autorisé ? oui Pourquoi ? q est attaché à un point nommé
		System.out.print ("qn = "); qn.afficher(); System.out.println ();

		//System.out.println ("> qn = (PointNomme) p1;");
		//qn = (PointNomme) p1;		// Est-ce autorisé ? non Pourquoi ? p1 est attaché à un objet de type Point
		//System.out.print ("qn = "); qn.afficher(); System.out.println ();
	}

}
