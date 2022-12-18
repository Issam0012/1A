import javax.swing.*;
import java.awt.*;
import javax.swing.event.*;
import java.awt.event.*;
import java.util.*;

/** Programmation d'un jeu de Morpion avec une interface graphique Swing.
  *
  * REMARQUE : Dans cette solution, le patron MVC n'a pas été appliqué !
  * On a un modèle (?), une vue et un contrôleur qui sont fortement liés.
  *
  * @author	Xavier Crégut
  * @version	$Revision: 1.4 $
  */

public class MorpionSwing {

	// les images à utiliser en fonction de l'état du jeu.
	private static final Map<ModeleMorpion.Etat, ImageIcon> images
		= new HashMap<ModeleMorpion.Etat, ImageIcon>();
	static {
		images.put(ModeleMorpion.Etat.VIDE, new ImageIcon("blanc.jpg"));
		images.put(ModeleMorpion.Etat.CROIX, new ImageIcon("croix.jpg"));
		images.put(ModeleMorpion.Etat.ROND, new ImageIcon("rond.jpg"));
	}

// Choix de réalisation :
// ----------------------
//
//  Les attributs correspondant à la structure fixe de l'IHM sont définis
//	« final static » pour montrer que leur valeur ne pourra pas changer au
//	cours de l'exécution.  Ils sont donc initialisés sans attendre
//  l'exécution du constructeur !

	private ModeleMorpion modele;	// le modèle du jeu de Morpion

//  Les éléments de la vue (IHM)
//  ----------------------------

	/** Fenêtre principale */
	private JFrame fenetre;

	/** Bouton pour quitter */
	private final JButton boutonQuitter = new JButton("Q");

	/** Bouton pour commencer une nouvelle partie */
	private final JButton boutonNouvellePartie = new JButton("N");

	/** Cases du jeu */
	private final JLabel[][] cases = new JLabel[3][3];

	/** Zone qui indique le joueur qui doit jouer */
	private final JLabel joueur = new JLabel();


// Le constructeur
// ---------------

	/** Construire le jeu de morpion */
	public MorpionSwing() {
		this(new ModeleMorpionSimple());
	}

	/** Construire le jeu de morpion */
	public MorpionSwing(ModeleMorpion modele) {
		// Initialiser le modèle
		this.modele = modele;

		// Créer les cases du Morpion
		for (int i = 0; i < this.cases.length; i++) {
			for (int j = 0; j < this.cases[i].length; j++) {
				this.cases[i][j] = new JLabel();
			}
		}

		// Initialiser le jeu
		this.recommencer();

		// Construire la vue (présentation)
		//	Définir la fenêtre principale
		this.fenetre = new JFrame("Morpion");
		this.fenetre.setLocation(100, 200);

		// Construire le contrôleur (gestion des événements)
		this.fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		// Ma partie
		java.awt.Container contenu = fenetre.getContentPane();
		contenu.setLayout(new java.awt.GridLayout(4,3));
		
		// Le grand menu
		JMenuBar jmenu = new JMenuBar();
		contenu.add(jmenu);
		
	    JMenu fichier = new JMenu("JEU");
	    jmenu.add(fichier);
	    
	    JMenuItem JNV = new JMenuItem("Nouvelle Partie");
		fichier.add(JNV);
		JNV.addActionListener(new ActionNouvellePartie());
		
	    JMenuItem JQuitter = new JMenuItem("Quitter");
		fichier.add(JQuitter);
		JQuitter.addActionListener(new ActionQuitter());
		
		this.fenetre.setJMenuBar(jmenu);
		
		for (int i = 0; i < this.cases.length; i++) {
			for (int j = 0; j < this.cases[i].length; j++) {
				contenu.add(this.cases[i][j]);
				this.cases[i][j].addMouseListener(new Click(i,j));
			}
		}
		
		contenu.add(boutonNouvellePartie);
		JLabel vide = new JLabel();
		vide.setIcon(images.get(ModeleMorpion.Etat.VIDE));
		contenu.add(vide);
		contenu.add(boutonQuitter);
		this.boutonQuitter.addActionListener(new ActionQuitter());
		this.boutonNouvellePartie.addActionListener(new ActionNouvellePartie());
		
		this.fenetre.pack();			// redimmensionner la fenêtre
		this.fenetre.setVisible(true);	// l'afficher
		
		
	}
	
	public class Click extends MouseAdapter {
		
		int i;
		int j;
		
		public Click(int i, int j) {
			this.i = i;
			this.j = j;
		}
		@Override
		public void mouseClicked(MouseEvent e) {
		    try {
		        modele.cocher(i,j);
			    cases[i][j].setIcon(images.get(modele.getValeur(i, j)));
			} catch (CaseOccupeeException f) {
			}
		}
	}
	
	public class ActionQuitter implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent evt) {
		    System.exit(0);
		}
	}
	
	public class ActionNouvellePartie implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent evt) {
			recommencer();
		}
	}
	
// Quelques réactions aux interactions de l'utilisateur
// ----------------------------------------------------

	/** Recommencer une nouvelle partie. */
	public void recommencer() {
		this.modele.recommencer();

		// Vider les cases
		for (int i = 0; i < this.cases.length; i++) {
			for (int j = 0; j < this.cases[i].length; j++) {
				this.cases[i][j].setIcon(images.get(this.modele.getValeur(i, j)));
			}
		}

		// Mettre à jour le joueur
		joueur.setIcon(images.get(modele.getJoueur()));
	}



// La méthode principale
// ---------------------

	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				new MorpionSwing();
			}
		});
	}

}
