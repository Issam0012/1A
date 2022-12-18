package vue.environnement;

import java.awt.Container;
import java.awt.EventQueue;
import java.awt.GridLayout;
import java.awt.Image;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

import javax.swing.*;

import modele.Plateau;

public class ChoixType {
	
	private JFrame fenetreType;
	
	private Plateau plateau;
	
	private JButton boutonAnnuler;
	
	private final JLabel[][] cases = new JLabel[1][4];
	
	public ChoixType(Plateau plateau, JLabel cases, int hauteur, int largeur, int ligne, int colonne) {
		
		this.plateau = plateau;
		
		this.fenetreType = new JFrame("Choix type de case");
		this.fenetreType.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		this.fenetreType.setLocationRelativeTo(null);
		
		Container contenu = this.fenetreType.getContentPane();
		
		JPanel panelImage = new JPanel();
		panelImage.setLayout(new GridLayout(1,4));
		
		this.cases[0][0] = new JLabel(new ImageIcon(new ImageIcon("image/Environnement/field.png").getImage().getScaledInstance(100, 100, Image.SCALE_DEFAULT)));
		this.cases[0][0].addMouseListener(new ActionImage(hauteur, largeur, "image/Environnement/field.png", cases, ligne, colonne));
		
		this.cases[0][1] = new JLabel(new ImageIcon(new ImageIcon("image/Environnement/mountain.png").getImage().getScaledInstance(100, 100, Image.SCALE_DEFAULT)));
		this.cases[0][1].addMouseListener(new ActionImage(hauteur, largeur, "image/Environnement/mountain.png", cases, ligne, colonne));
		
		this.cases[0][2] = new JLabel(new ImageIcon(new ImageIcon("image/Environnement/river.png").getImage().getScaledInstance(100, 100, Image.SCALE_DEFAULT)));
		this.cases[0][2].addMouseListener(new ActionImage(hauteur, largeur, "image/Environnement/river.png", cases, ligne, colonne));
		
		this.cases[0][3] = new JLabel(new ImageIcon(new ImageIcon("image/Environnement/village.png").getImage().getScaledInstance(100, 100, Image.SCALE_DEFAULT)));
		this.cases[0][3].addMouseListener(new ActionImage(hauteur, largeur, "image/Environnement/village.png", cases, ligne, colonne));
		
		panelImage.add(this.cases[0][0]);
		panelImage.add(this.cases[0][1]);
		panelImage.add(this.cases[0][2]);
		panelImage.add(this.cases[0][3]);
		
		contenu.add(panelImage);
		
		this.fenetreType.pack();
		this.fenetreType.setVisible(true);
	}
	
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				new ChoixType(new Plateau(10,10,"test"),new JLabel(), 10, 10, 1, 1);
			}
		});
	}
	
	
	public class ActionImage extends MouseAdapter {		
		private int hauteur;
		private int largeur;
		private int ligne;
		private int colonne;
		private String path;
		private JLabel caseChgt;

		public ActionImage(int hauteur, int largeur, String path, JLabel cases, int ligne, int colonne) {
			this.hauteur = hauteur;
			this.largeur = largeur;
			this.ligne = ligne;
			this.colonne = colonne;
			this.path = path;
			this.caseChgt = cases;
		}

		public void mouseClicked(MouseEvent arg0) {			
			System.out.println("cochage" + path);
			caseChgt.setIcon(new ImageIcon(new ImageIcon(this.path).getImage().getScaledInstance(this.largeur, this.hauteur, Image.SCALE_DEFAULT)));
			plateau.setCase(this.ligne, this.colonne, this.path);
			fenetreType.dispose();
		}		
	}

}
