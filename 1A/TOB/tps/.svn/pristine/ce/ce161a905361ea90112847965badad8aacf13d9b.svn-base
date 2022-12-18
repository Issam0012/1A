import java.awt.Color;
import org.junit.*;
import static org.junit.Assert.*;

/**
  * Classe de test complémentaire de la classe Cercle.
  * @author	Issam ALOUANE
  */
public class ComplementsCercleTest {

	// précision pour les comparaisons réelle
	public final static double EPSILON = 0.001;

	// Les points du sujet
	private Point A, B, C, D, E;

	// Les cercles du sujet
	private Cercle C1, C2;

	@Before public void setUp() {
		// Construire les points
		A = new Point(1, 2);
		B = new Point(2, 1);
		C = new Point(4, 1);

		// Construire les cercles
		C1 = new Cercle(A, 5);
	}
	
	/** Vérifier si deux points ont mêmes coordonnées.
	  * @param message un message à afficher en cas d'erreur
	  * @param point1 le premier point
	  * @param point2 le deuxième point
	  */
	static void memesCoordonnees(String message, Point point1, Point point2) {
		assertEquals(message + " (x)", point1.getX(), point2.getX(), EPSILON);
		assertEquals(message + " (y)", point1.getY(), point2.getY(), EPSILON);
	}

    @Test public void testerContient() {
		assertTrue("contienta", C1.contient(B));
		assertTrue("contienta", C1.contient(C));
	}
	
	@Test public void testerTranslater() {
		C1.translater(100, 200);
		memesCoordonnees("translation", new Point(101, 202), C1.getCentre());
		assertEquals(" (y)", C1.getRayon(), 5, EPSILON);
		assertFalse("contientb", C1.contient(B));
		assertFalse("contientb", C1.contient(C));
	}

}
