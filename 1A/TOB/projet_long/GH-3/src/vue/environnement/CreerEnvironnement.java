package vue.environnement;

import modele.Plateau;
import java.io.*;
import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.EventQueue;
import java.awt.GridLayout;
import java.awt.Image;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.io.Serializable;

import javax.swing.*;


/**
 * Fenetre de creation d'environnement de jeu
 * 
 * @version 1.0
 */
public class CreerEnvironnement extends JFrame{
	
	private Plateau plateau; //Plateau
	
	private JFrame fenetre; //fenetre principale
	
	private File fichier; //Fichier de sauvegarde
	
	/** Dimension cases plateau */
	private int hauteurImg;
	private int largeurImg;
	
	/** Cases du jeu */
	private final JLabel[][] cases;
	
	public CreerEnvironnement(Plateau plateau) {
		
		//Création du fichier de sauvegarde
		fichier = new File("vue/Sauvegarde/Map/" + plateau.getNom());
		
		//Initialisation taille images
		this.plateau = plateau;
		this.largeurImg = (830-200)/this.plateau.getLargeur();
		this.hauteurImg =  655/this.plateau.getHauteur();
		
		fenetre = new JFrame("Création plateau");
		
		this.cases = new JLabel[this.plateau.getHauteur()][this.plateau.getLargeur()];
		
		//Definition fenetre principale
		fenetre.setSize(830, 655); //Taille
		fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); //Action fermeture
		fenetre.setLocationRelativeTo(null); //Position a l'écran
		fenetre.setVisible(true); //Affichage
		
		Container c = fenetre.getContentPane();
		
		//Menu :
		JButton bFond = new JButton("Fond");
		bFond.setPreferredSize(new Dimension(100,40));
		bFond.addActionListener(new ActionChangerFond());
		bFond.setAlignmentX(Component.CENTER_ALIGNMENT);
		
		JButton bObjets = new JButton("Objets");
		bObjets.setSize(new Dimension(200,40));
		bObjets.addActionListener(new ActionChoisirObjet());
		bObjets.setAlignmentX(Component.CENTER_ALIGNMENT);
		
		JButton bFormes = new JButton("Formes");
		bFormes.setPreferredSize(new Dimension(200,40));
		bFormes.addActionListener(new ActionChoisirForme());
		bFormes.setAlignmentX(Component.CENTER_ALIGNMENT);
		
		JButton bNotes = new JButton("Notes");
		bNotes.setPreferredSize(new Dimension(200,40));
		bNotes.addActionListener(new ActionEcrireNotes());
		bNotes.setAlignmentX(Component.CENTER_ALIGNMENT);
		
		JButton bImporter = new JButton("Importer");
		bImporter.setPreferredSize(new Dimension(200,40));
		bImporter.addActionListener(new ActionImporterSon());
		bImporter.setAlignmentX(Component.CENTER_ALIGNMENT);
		
		JButton bSauv = new JButton("Sauvegarder");
		bSauv.setPreferredSize(new Dimension(200,40));
		bSauv.addActionListener(new ActionSauvegarder());
		bSauv.setAlignmentX(Component.CENTER_ALIGNMENT);
		
		JButton bFermer = new JButton("Fermer");
		bFermer.setPreferredSize(new Dimension(200,40));
		bFermer.addActionListener(new ActionFermer());
		bFermer.setAlignmentX(Component.CENTER_ALIGNMENT);		
		
		Box boxGrille = Box.createHorizontalBox();
		JLabel lGrille = new JLabel("Grille : ");
		JTextField tGrille_l = new JTextField();
		JTextField tGrille_c = new JTextField();
		boxGrille.add(lGrille);
		boxGrille.add(tGrille_c);
		boxGrille.add(tGrille_l);
		
		Box boxHaut = Box.createVerticalBox();
		boxHaut.add(Box.createVerticalStrut(5));
		boxHaut.add(bFond);
		boxHaut.add(Box.createVerticalStrut(10));
		boxHaut.add(bObjets);
		boxHaut.add(Box.createVerticalStrut(10));
		boxHaut.add(bFormes);
		boxHaut.add(Box.createVerticalStrut(10));
		boxHaut.add(bNotes);
		boxHaut.add(Box.createVerticalStrut(10));
		boxHaut.add(boxGrille);
		boxHaut.setBorder(BorderFactory.createTitledBorder("Ajouter"));
		
		Box boxSon = Box.createVerticalBox();
		boxSon.add(Box.createVerticalStrut(5));
		boxSon.add(bImporter);
		boxSon.setBorder(BorderFactory.createTitledBorder("Son"));
		
		Box box = Box.createVerticalBox();
		box.add(Box.createVerticalStrut(20));
		box.add(boxHaut);
		box.add(Box.createVerticalStrut(50));
		box.add(boxSon);
		box.add(Box.createVerticalStrut(200));
		box.add(bSauv);
		box.add(Box.createVerticalStrut(10));
		box.add(bFermer);
		box.setBorder(BorderFactory.createTitledBorder("Menu Environnement"));
		
        c.add(box, BorderLayout.WEST);        
        
        // Plateau :
        JPanel panelPlateau = new JPanel();
        panelPlateau.setLayout(new GridLayout(this.plateau.getLargeur(),this.plateau.getHauteur()));
        
        //Création JLabel affichage images
        for(int i = 0; i<this.plateau.getHauteur(); i++) {
        	for(int j = 0; j<this.plateau.getLargeur(); j++) {
        		String pathList = this.plateau.getPath(i, j);
        		this.cases[i][j] = new JLabel(new ImageIcon(new ImageIcon(pathList).getImage().getScaledInstance( this.hauteurImg, this.largeurImg, Image.SCALE_DEFAULT)));
        		panelPlateau.add(this.cases[i][j]);
        		this.cases[i][j].addMouseListener(new ActionImage(i, j, largeurImg, hauteurImg, this.cases[i][j]));
        	}
        }
        
        // Ajout images
        DessinPlateau plt = new DessinPlateau(this.plateau);
        c.add(panelPlateau);       
        
        fenetre.setVisible(true);        
	}
	
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				new CreerEnvironnement(new Plateau(10,10,"test"));
			}
		});
	}
	
	//Listeners
	
	private class ActionChangerFond implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Changer le fond");
		}		
	}
	
	private class ActionChoisirObjet implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Choisir objet à placer dans le plateau");
		}		
	}
	
	private class ActionChoisirForme implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Choisir une forme pour le plateau");
		}
	}
	
	private class ActionImporterSon implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Importer un son");
		}		
	}
	
	private class ActionEcrireNotes implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Ecrire des notes");
		}		
	}
	
	private class ActionSauvegarder implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			
			if (fichier.exists()) {
				System.out.println("Le fichier existe deja");
			} else {
				System.out.println("Le fichier n'existe pas");
			}
			
			try {
				ObjectOutputStream flotEcriture = new ObjectOutputStream(new FileOutputStream(fichier));
				flotEcriture.writeObject(plateau);
				flotEcriture.close();
			} catch (IOException f) {
				System.out.println(" erreur :" + f.toString());
			}
			System.out.println("Sauvegarder environnement");
		}		
	}
	
	private class ActionFermer implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Fermer");
			fenetre.dispose();
			new MenuEnvironnement();
		}		
	}
	
	/** Listener cochage images pour choixi image */
	public class ActionImage extends MouseAdapter {
		
		private int i;
		private int j;
		private int largeur;
		private int hauteur;
		private JLabel casesChgt;
		
		public ActionImage(int i, int j, int largeur, int hauteur, JLabel caseChgt) {
			this.i = i;
			this.j = j;
			this.largeur = largeur;
			this.hauteur = hauteur;
			this.casesChgt = caseChgt;
		}
		
		public void mouseClicked(MouseEvent arg0) {			
			System.out.println("cochage" + i + ", " + j);	
			new ChoixType(plateau, this.casesChgt, hauteur, largeur, i, j);
		}
		
	}
}
