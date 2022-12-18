package vue.environnement;

import controleur.Partie;
import modele.Plateau;
import vue.MenuPrincipal;
import vue.personnage.ChoixPersonnages;

import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.EventQueue;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import java.io.File;
import java.io.FileInputStream;
import java.io.ObjectInputStream;

import javax.swing.JFileChooser;
import javax.swing.filechooser.FileSystemView;

public class ChoixEnvironnement {
	
	//Initialisation explorateur plateau existant
	private String pathPlateau = "vue/Sauvegarde/Map/";	
	JFileChooser choose = new JFileChooser(pathPlateau);

	/** Fenetre principale */
    private final JFrame fenetreEnv;
    
    /** Controleur de la partie */
    private Partie G = new Partie();
    
    /** Variable choix carte de jeu */
    private Plateau map;
    private File fichierMap;
    private JLabel labelNomCarte;
    private JLabel labelLargeur;
    private JLabel labelHauteur;
    
    /** Bouton de choix carte */
    private JButton bChoixMap = new JButton("Choix carte");
    
    public ChoixEnvironnement() {
    	
        JButton Temporaire = new JButton("suivant");
        this.fenetreEnv = new JFrame("Choix Environnement");
        
        Container c = this.fenetreEnv.getContentPane();
        
        JPanel panelBouton = new JPanel();
        panelBouton.setLayout(new BoxLayout(panelBouton, BoxLayout.Y_AXIS));
        panelBouton.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));
        
        bChoixMap.setPreferredSize(new Dimension(200,50));  
        bChoixMap.addActionListener(new ActionChoixMap());
        bChoixMap.setAlignmentX(Component.CENTER_ALIGNMENT);
        
        JButton bRetour = new JButton("Retour");
        bRetour.setPreferredSize(new Dimension(200,50));
        bRetour.addActionListener(new ActionRetour());
        bRetour.setAlignmentX(Component.CENTER_ALIGNMENT);

        Temporaire.setPreferredSize(new Dimension(200,50));
        Temporaire.addActionListener(new ActionChoixEnv());
        Temporaire.setAlignmentX(Component.CENTER_ALIGNMENT);

        panelBouton.add(Temporaire);
        panelBouton.add(Box.createVerticalStrut(20));
        panelBouton.add(bChoixMap);
        panelBouton.add(Box.createVerticalGlue());
        panelBouton.add(bRetour);
        
        //Panel contenant les informations de la carte selectionné
        JPanel panelInfoMap = new JPanel();
        panelInfoMap.setLayout(new BoxLayout(panelInfoMap, BoxLayout.Y_AXIS));
        
        //Panel contenant le nom de la carte
        JPanel panelNom = new JPanel();
        panelNom.setLayout(new FlowLayout());
        
        //Panel contenant les informations sur la taille de la carte
        JPanel panelTaille = new JPanel();
        panelTaille.setLayout(new BoxLayout(panelTaille, BoxLayout.Y_AXIS));
                
        //Création contenu panel nom
        JLabel labelInfoNom = new JLabel("Nom de la carte : ");
        labelNomCarte = new JLabel("");
        //Ajout contenu au panel
        panelNom.add(labelInfoNom);
        panelNom.add(labelNomCarte);  
        
        //Création contenu panel taille
        JPanel panelLargeur = new JPanel(); //Panel info largeur
        panelLargeur.setLayout(new FlowLayout());
        JLabel labelTitreLargeur = new JLabel("Largeur : ");
        labelLargeur = new JLabel("");
        panelLargeur.add(labelTitreLargeur);
        panelLargeur.add(labelLargeur);
        
        JPanel panelHauteur = new JPanel(); //Panel info hauteur
        panelHauteur.setLayout(new FlowLayout());
        JLabel labelTitreHauteur = new JLabel("Hauteur : ");
        labelHauteur = new JLabel("");
        panelHauteur.add(labelTitreHauteur);
        panelHauteur.add(labelHauteur);
        
        //Ajout au panel taille
        panelTaille.add(panelLargeur);
        panelTaille.add(panelHauteur);
        
        //Ajout au panel taille        
        panelInfoMap.add(panelNom);
        panelInfoMap.add(panelTaille);

        c.add(panelBouton, BorderLayout.WEST);
        c.add(panelInfoMap, BorderLayout.CENTER);

        this.fenetreEnv.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        this.fenetreEnv.pack();
        this.fenetreEnv.setSize(1024, 640);
        this.fenetreEnv.setLocationRelativeTo(null);
        this.fenetreEnv.setVisible(true);
    }

    public static void main(String[] args) {
        EventQueue.invokeLater(new Runnable() {
            public void run() {
                new ChoixEnvironnement();
            }
        });
    }

    //chaque env aura un bouton qui pointe la dessus
    // cet event listener définit l'env courant dans la classe Partie et passe
    // au choix des Personnages
    private class ActionChoixEnv implements ActionListener{
        @Override
        public void actionPerformed(ActionEvent e){
            System.out.println("environnement choisi");
            if (map != null) {
            	 fenetreEnv.dispose();
                 new ChoixPersonnages(map);
			}
            System.out.println("Pas de carte selectionné");           
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
    
    /** Action listener choix du plateau pour jouer */
	private class ActionChoixMap implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Choisir un environnement de jeu");
		
			//Lecture fichier a modifier
			int res = choose.showOpenDialog(null);
			if (res == JFileChooser.APPROVE_OPTION) {
				fichierMap = choose.getSelectedFile();
			      System.out.println(fichierMap.getAbsolutePath());			      
			}
			//Transformation en objet de type Plateau
			try {
				ObjectInputStream flotLecture = new ObjectInputStream(new FileInputStream(fichierMap));
				Object lu = flotLecture.readObject();
				if (lu instanceof Plateau) {
					map = (Plateau) lu;
					labelNomCarte.setText(map.getNom()); 
					labelLargeur.setText(String.valueOf(map.getLargeur())); 
					labelHauteur.setText(String.valueOf(map.getHauteur())); ;
				}
				flotLecture.close();
			} catch (Exception d) {
				System.out.println("Annuler" +d.toString());
			}

		}		
	}
}
