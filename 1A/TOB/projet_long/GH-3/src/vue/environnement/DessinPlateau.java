package vue.environnement;

import modele.Plateau;
import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.geom.Rectangle2D;

import javax.swing.JComponent;
import javax.swing.JPanel;


/*
 * Classe qui defini un plateau (pour le moment sera une grille à dessin avec un 
 * nombre aleatoire de cases colorees) qui servira d'exemple
 */
public class DessinPlateau extends JPanel {
	
	private Plateau plateau;	
	
	public DessinPlateau(Plateau plateau) {
		this.plateau = plateau;
	}
	
	protected void paintComponent(Graphics g) {
		Graphics2D g2 = (Graphics2D) g;
		
		//Les cases :
		int case_dim = 37;
		boolean suivant = true;
		for(int i = 0; i<this.plateau.getHauteur(); i++) { //Nombre de ligne
			for(int j = 0; j<this.plateau.getLargeur(); j++) { //Nombre de colonne
				if (suivant) {
					g2.setPaint(Color.GRAY);
				} else {
					g2.setPaint(Color.WHITE);
				}
				g2.fill(new Rectangle2D.Double((j+1)*case_dim, (i+1)*case_dim, case_dim, case_dim));
				suivant = !suivant;
			}
			suivant = !suivant;
		}
		
		g2.setPaint(Color.BLACK);
		g2.setStroke(new BasicStroke(2));		
		
	}

}
