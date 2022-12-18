import java.awt.Color;
import org.junit.*;
import static org.junit.Assert.*;

/**
  * Classe de test des exigeances restantes de la classe Cercle.
  * @author	Issam ALOUANE
  */
public class CercleTest {

	// précision pour les comparaisons réelle
	public final static double EPSILON = 0.001;

	// Les points du sujet
	private Point A, B, C;

	// Les cercles du sujet
	private Cercle C1, C2, C3, C4;

	@Before public void setUp() {
		// Construire les points
		A = new Point(0, 4);
		B = new Point(3, 0);
		C = new Point(1.5, 2);

		// Construire les cercles
		C1 = new Cercle(A, B);
		C2 = new Cercle(A, B, Color.white);
		C3 = Cercle.creerCercle(C, A);
	    C4 = Cercle.creerCercle(C, B);   //C4 devra être la même que C3
	}
	
	/** Vérifier si deux points ont mêmes coordonnées.
	  * @param message un message à afficher en cas d'erreur
	  * @param p1 le premier point
	  * @param p2 le deuxième point
	  */
	static void memesCoordonnees(String message, Point p1, Point p2) {
		assertEquals(message + " (x)", p1.getX(), p2.getX(), EPSILON);
		assertEquals(message + " (y)", p1.getY(), p2.getY(), EPSILON);
	}

	@Test public void testerE12() {
		memesCoordonnees("E12 : Centre de C1 incorrect", C, C1.getCentre());
		assertEquals("E12 : Rayon de C1 incorrect",
				2.5, C1.getRayon(), EPSILON);
		assertEquals(Color.blue, C1.getCouleur());
	}
	
	@Test public void testerE13() {
		memesCoordonnees("E13 : Centre de C2 incorrect", C, C2.getCentre());
		assertEquals("E13 : Rayon de C2 incorrect",
				2.5, C2.getRayon(), EPSILON);
		assertEquals(Color.white, C2.getCouleur());
	}
	
	@Test public void testerE14a() {
		memesCoordonnees("E14a : Centre de C3 incorrect", C, C3.getCentre());
		assertEquals("E14a : Rayon de C3 incorrect",
				2.5, C3.getRayon(), EPSILON);
		assertEquals(Color.blue, C3.getCouleur());
	}
	
	@Test public void testerE14b() {
		memesCoordonnees("E14b : Centre de C4 incorrect", C3.getCentre(), C4.getCentre());
		assertEquals("E14b : Rayon de C4 incorrect",
				C3.getRayon(), C4.getRayon(), EPSILON);
		assertEquals(Color.blue, C4.getCouleur());
	}
	
}
