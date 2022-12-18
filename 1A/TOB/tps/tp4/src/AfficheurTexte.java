//Autre realisation de l'interface afficheur

public class AfficheurTexte  {
	
	 public void dessinerCercle(double x , double y , double rayon, java.awt.Color c) {
		System.out.println("Cercle {");
		System.out.println("      centre_x = "+x);
		System.out.println("      centre_y = "+y);
		System.out.println("     rayon = "+rayon);
		System.out.print("      couleur = ");
		System.out.println(c.toString());
		System.out.println("}");
		
		
	}
	 public void dessinerLigne(double x1,double y1,double x2,double y2,java.awt.Color c) {
		System.out.println("Ligne {");
		System.out.println("     x1 = "+x1);
		System.out.println("     y1 = "+y1);
		System.out.println("     x2 = "+x2);
		System.out.println("     y2 = "+y2);
		System.out.print("      couleur = ");
		System.out.println(c.toString());
		System.out.println("}");
		
	}
	 public void dessinerPoint(double x,double y, java.awt.Color c) {
		System.out.println("Point {");
		System.out.println("     x = "+x);
		System.out.println("     y = "+y);
		System.out.print("      couleur = ");
		System.out.println(c.toString());
		System.out.println("}");
	}
	 public void dessinerTexte(double x,double y,java.lang.String texte,java.awt.Color c) {
		System.out.println("Ligne {");
		System.out.println("     x = "+x);
		System.out.println("     y = "+y);
		System.out.println("     valeur = "+texte);
		System.out.print("      couleur = ");
		System.out.println(c.toString());
		System.out.println("}");
	}
}
