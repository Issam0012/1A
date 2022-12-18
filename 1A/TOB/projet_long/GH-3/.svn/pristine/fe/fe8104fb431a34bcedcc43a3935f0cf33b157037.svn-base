package vue.jeu;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.EventQueue;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.Image;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

import javax.swing.BoxLayout;
import javax.swing.ButtonGroup;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JTabbedPane;
import javax.swing.JTextField;

import controleur.Partie;
import controleur.deplacement;
import modele.Personnage;
import modele.Plateau;
import modele.RaceHumain;
import vue.MenuPrincipal;
import vue.environnement.DessinPlateau;

public class Jeu {
	
	private JFrame fenetrePrincipale; //fenetre de jeu
	
	private Partie partie;
	
	private Plateau plateau; //Plateau de jeu
	
	private JButton boutonQuitter = new JButton("Quitter"); //Bouton quitter la partie
	private JButton boutonDe = new JButton("Lancer de dé");
	private ButtonGroup groupePerso = new ButtonGroup();
	
	private JTextField champFaceDe = new JTextField("nombre de face ?");
	
	private final JLabel[][] cases; //Cases du jeu
	
	/** Dimension cases plateau */
	private int hauteurImg;
	private int largeurImg;
	
	public Jeu(Plateau plateau, ArrayList<Personnage> ListePerso) {
		
		Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
		Dimension dimPanelMJ = new Dimension(new Dimension((int) (screenSize.getWidth()/6), (int) screenSize.getHeight()));
		
		/** Initialisation utilisation plateau */
		this.plateau = plateau; //Recuperation poignée sur plateau
		this.largeurImg = (int) (screenSize.getWidth()-screenSize.getWidth()/6)/plateau.getLargeur();
		this.hauteurImg = (int) (screenSize.getHeight())/plateau.getHauteur();
		
		this.cases = new JLabel[this.plateau.getHauteur()][this.plateau.getLargeur()];
		
		//Création de la fenetre principale
		fenetrePrincipale = new JFrame("Jeu");
		
		//Parametres de la fenetre
		fenetrePrincipale.setSize(screenSize);
		fenetrePrincipale.setLocationRelativeTo(null);
		fenetrePrincipale.setVisible(true);
		fenetrePrincipale.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		//fenetrePrincipale.setExtendedState(JFrame.MAXIMIZED_BOTH);
		fenetrePrincipale.setResizable(false);
		
		//Création du container pour le contenu
		Container contenu = this.fenetrePrincipale.getContentPane();
		
		//Création des JPanel principaux
		JPanel panelMJ = new JPanel();
		panelMJ.setPreferredSize(dimPanelMJ);
		//panelMJ.setBackground(Color.red);
		JPanel panelPlateau = new JPanel();
		//panelPlateau.setBackground(Color.blue);
		// Ecouter le clavier pour le deplacer des personnages
		panelPlateau.addKeyListener(new deplacement(this.partie));
		panelPlateau.setFocusable(true);
		
		//Gestion panelMJ
		JTabbedPane tabOnglets = new JTabbedPane(); //Gestionnaire d'onglet
		tabOnglets.setPreferredSize(dimPanelMJ);
		JPanel ongletPersonnage = new JPanel(); //onglet equipement de tete
		ongletPersonnage.setPreferredSize(dimPanelMJ);
		JPanel ongletDe = new JPanel(); //onglet equipement de tete
		ongletDe.setPreferredSize(dimPanelMJ);
		
		//Ajout onglets
		tabOnglets.add("Personnage", ongletPersonnage);
		//tabOnglets.add("Dés", ongletDe);
		
		//Gestion onglet personnage
		//ongletPersonnage.setLayout(new BoxLayout(ongletPersonnage, BoxLayout.Y_AXIS));
		boutonQuitter.addActionListener(new ActionQuitter());
		for(int i = 0; i<ListePerso.size(); i++) {
			JPanel panelNom = new JPanel();
			panelNom.setLayout(new FlowLayout());
			JRadioButton boutonCoche = new JRadioButton();
			groupePerso.add(boutonCoche);
			String nom = ListePerso.get(i).getNom();
			boutonCoche.addActionListener(new RadioButtonListener(nom));
			JLabel labelNom = new JLabel(nom);
			labelNom.setFont(new Font("Serif", Font.BOLD, 20));
			panelNom.add(labelNom);
			panelNom.add(boutonCoche);
			panelNom.setPreferredSize(new Dimension((int) (screenSize.getWidth()/6), 45));
			ongletPersonnage.add(panelNom);
			System.out.println(nom);
		}
		ongletPersonnage.add(boutonQuitter, BorderLayout.SOUTH);
		
		//Gestion onglet De
		//ongletDe.setLayout(new BoxLayout(ongletDe, BoxLayout.Y_AXIS));
		JPanel panelNbrFace = new JPanel();
		champFaceDe.setPreferredSize(new Dimension(100, 20));
		panelNbrFace.add(champFaceDe);
		panelNbrFace.setPreferredSize(new Dimension((int) (screenSize.getWidth()/6), 45));
		ongletDe.add(panelNbrFace);
		ongletDe.add(boutonDe);
		
		//Ajout onglet panelMJ
		panelMJ.add(tabOnglets);
		
		//Affichage plateau
        panelPlateau.setLayout(new GridLayout(this.plateau.getLargeur(),this.plateau.getHauteur()));
        
        //Création JLabel affichage images
        for(int i = 0; i<this.plateau.getHauteur(); i++) {
        	for(int j = 0; j<this.plateau.getLargeur(); j++) {
        		String pathList = this.plateau.getPath(i, j);
        		this.cases[i][j] = new JLabel(new ImageIcon(new ImageIcon(pathList).getImage().getScaledInstance(  largeurImg, hauteurImg, Image.SCALE_DEFAULT)));
        		panelPlateau.add(this.cases[i][j]);
        	}
        }
        
        contenu.add(panelPlateau);
		
		//Ajout des panels au container de contenu
		contenu.add(panelMJ, BorderLayout.WEST);
		contenu.add(panelPlateau);
	}
	
	public static void main(String args[]) {
		ArrayList<Personnage> ListePerso = new ArrayList<Personnage>();
		ListePerso.add(new Personnage("Perso test 1", new RaceHumain(), "description de test 1"));
		ListePerso.add(new Personnage("Perso test 2", new RaceHumain(), "description de test 2"));
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				new Jeu(new Plateau(10,10,"test"), ListePerso);
			}
		});
	}
	
	//Les listeners
	
	private class ActionQuitter implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Quitter");
			fenetrePrincipale.dispose();
			new MenuPrincipal();
		}		
	}
	
	//Listener radioButton
	private class RadioButtonListener implements ActionListener {		
		private String nomPerso;
		
		public RadioButtonListener(String nomPerso) {
			this.nomPerso = nomPerso;
		}
		
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Personnage qui peut bouger : " + this.nomPerso);
		}		
	}
	
}
