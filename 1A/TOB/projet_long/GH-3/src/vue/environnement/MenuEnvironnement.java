package vue.environnement;

import vue.MenuPrincipal;

import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JPanel;
import java.io.File;
import java.io.FileInputStream;
import java.io.ObjectInputStream;

import javax.swing.JFileChooser;
import javax.swing.filechooser.FileSystemView;

import modele.Plateau;


public class MenuEnvironnement {
	
	private JFrame fenetreEnv;
	final private JButton bNouveau = new JButton("Creer Environnement");
	final private JButton bEditer = new JButton("Editer Environnement");
	final private JButton bSupprimer = new JButton("Supprimer Environnement");
	final private JButton bRetour = new JButton("Retour");
	
	//Initialisation explorateur plateau existant
	private String pathPlateau = "vue/Sauvegarde/Map/";	
	JFileChooser choose = new JFileChooser(pathPlateau);
	
	private Plateau plateauModif;
	private File fichierModif;
	
	public MenuEnvironnement() {
		
		this.fenetreEnv = new JFrame("Menu Environnement");
		Container c = this.fenetreEnv.getContentPane();
		JPanel panelBouton = new JPanel();
		panelBouton.setLayout(new BoxLayout(panelBouton, BoxLayout.Y_AXIS));
		panelBouton.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));
		
		//Création bouton Créer environnement
		bNouveau.setPreferredSize(new Dimension(200,75));
		bNouveau.addActionListener(new ActionNouvelEnv());
		bNouveau.setAlignmentX(Component.CENTER_ALIGNMENT);
		
		//Création bouton Editer environnement 
		bEditer.setPreferredSize(new Dimension(200,75));
		bEditer.addActionListener(new ActionEditerEnv());
		bEditer.setAlignmentX(Component.CENTER_ALIGNMENT);
		
		//Création bouton supprimer environnement
		bSupprimer.setPreferredSize(new Dimension(200,75));
		bSupprimer.addActionListener(new ActionDelEnv());
		bSupprimer.setAlignmentX(Component.CENTER_ALIGNMENT);
		
		//Création bouton retour
		bRetour.setPreferredSize(new Dimension(200,50));
		bRetour.addActionListener(new ActionRetour());
		bRetour.setAlignmentX(Component.CENTER_ALIGNMENT);
		
		panelBouton.add(bNouveau);
		panelBouton.add(Box.createVerticalStrut(20));
		panelBouton.add(bEditer);
		panelBouton.add(Box.createVerticalStrut(20));
		panelBouton.add(bSupprimer);
		panelBouton.add(Box.createVerticalStrut(350));
		panelBouton.add(bRetour);
		
		c.add(panelBouton, BorderLayout.WEST);		
		
		this.fenetreEnv.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		this.fenetreEnv.pack();
		this.fenetreEnv.setSize(1024, 640);
		this.fenetreEnv.setLocationRelativeTo(null);
		this.fenetreEnv.setVisible(true);
	}
	
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				new MenuEnvironnement();
			}
		});
	}
	
	private class ActionNouvelEnv implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			fenetreEnv.dispose();
			new ChoixTaille();
		}		
	}
	
	/** Action listener choix du plateau a éditer */
	private class ActionEditerEnv implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Editer un environnement existant");
		
			//Lecture fichier a modifier
			int res = choose.showOpenDialog(null);
			if (res == JFileChooser.APPROVE_OPTION) {
			      fichierModif = choose.getSelectedFile();
			      System.out.println(fichierModif.getAbsolutePath());			      
			}
			try {
				ObjectInputStream flotLecture = new ObjectInputStream(new FileInputStream(fichierModif));
				Object lu = flotLecture.readObject();
				if (lu instanceof Plateau) {
					plateauModif = (Plateau) lu;
				}
				flotLecture.close();
			} catch (Exception d) {
				System.out.println("Annuler" +d.toString());
			}
			
			//Ouverture menu de modification
			if (plateauModif != null) {
				fenetreEnv.dispose();
				new CreerEnvironnement(plateauModif);	
			}					
			//new FenetreEditerEnvironnement();
		}		
	}
	
	/** ActionListener pour supprimer un plateau */
	private class ActionDelEnv implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Supprimer un environnement existant");
			
			//Lecture fichier a modifier
			int res = choose.showOpenDialog(null);
			if (res == JFileChooser.APPROVE_OPTION) {
			      fichierModif = choose.getSelectedFile();
			      System.out.println(fichierModif.getAbsolutePath());			      
			}	
			try {
				ObjectInputStream flotLecture = new ObjectInputStream(new FileInputStream(fichierModif));
				Object lu = flotLecture.readObject();
				if (lu instanceof Plateau) {
					fichierModif.delete();
				}
				flotLecture.close();
			} catch (Exception d) {
				System.out.println("Annuler" +d.toString());
			}			
		}		
	}
	
	private class ActionRetour implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Retour");
			fenetreEnv.dispose();
			new MenuPrincipal();
		}		
	}
}
