import afficheur.Ecran;
import java.util.*;

/** Construire le schéma proposé dans le sujet de TP avec une liste,
  *
  * @author	Issam Alouane
  */
public class SchemaListe {

	public static void main(String[] args) {
		// La création du liste du point
		List<Point> schema_point = new ArrayList<Point>();
		
		// La création du liste du segment
		List<Segment> schema_seg = new ArrayList<Segment>();
		
		// La création des points et des segments
		Point p1 = new PointNomme(3, 2, "A");
		Point p2 = new PointNomme(6, 9, "S");
		Point p3 = new Point(11, 4);
		Segment s12 = new Segment(p1, p2);
		Segment s23 = new Segment(p2, p3);
		Segment s31 = new Segment(p3, p1);
		
		// L'ajout de ces éléments dans les listes
		schema_point.add(p1);
		schema_point.add(p2);
		schema_point.add(p3);
		schema_seg.add(s12);
		schema_seg.add(s23);
		schema_seg.add(s31);
		
		// Créer l'écran d'affichage
		Ecran ecran = new Ecran("SchemaListe", 600, 400, 20);
		ecran.dessinerAxes();
		
		// Afficher le schéma
		schema_point.forEach(e -> e.dessiner(ecran));
		schema_seg.forEach(e -> e.dessiner(ecran));
		
	}
}
