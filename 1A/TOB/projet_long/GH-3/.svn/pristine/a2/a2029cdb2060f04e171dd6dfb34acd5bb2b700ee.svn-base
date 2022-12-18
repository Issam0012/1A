package vue.personnage;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.EventQueue;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.swing.*;

import controleur.Partie;
import modele.Personnage;
import modele.Plateau;
import modele.Race;
import modele.RaceHumain;
import vue.MenuPrincipal;
import vue.environnement.ChoixEnvironnement;
import vue.jeu.Jeu;

public class ChoixPersonnages{


    private JFrame fenetreChoixPerso;

    private JFrame Fmenu = new JFrame("Menu Personnage");

    private Plateau plateauJeu;

    private ArrayList<Personnage> ListePerso = new ArrayList<Personnage>();

    public ChoixPersonnages(Plateau plateauJeu) {
    	
    	this.plateauJeu = plateauJeu;

        this.fenetreChoixPerso = new JFrame(" Choix Personnages");

        Container contenu = this.fenetreChoixPerso.getContentPane();

        JPanel panelBouton = new JPanel();

        panelBouton.setLayout(new BoxLayout(panelBouton, BoxLayout.Y_AXIS));
        //bordure jolie
        panelBouton.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));

        JButton boutonValider = new JButton("Valider");
        boutonValider.setPreferredSize(new Dimension(150,50));
        boutonValider.addActionListener(new ActionValider());
        boutonValider.setAlignmentX(Component.CENTER_ALIGNMENT);

        panelBouton.add(boutonValider);

        JButton boutonRetour = new JButton("Retour");
        boutonRetour.setPreferredSize(new Dimension(150,50));
        boutonRetour.addActionListener(new ActionRetour());
        boutonRetour.setAlignmentX(Component.CENTER_ALIGNMENT);

        panelBouton.add(Box.createVerticalGlue());
        panelBouton.add(boutonRetour);

        contenu.add(panelBouton, BorderLayout.WEST);

        // grille persos

        JPanel panelPersos = new JPanel();
        panelPersos.setLayout(new FlowLayout());
        //panelPersos.setSize(700, 500);

        contenu.add(panelPersos, BorderLayout.CENTER);

        List<String> Noms = new ArrayList<String>();
        List<String> descriptions = new ArrayList<String>();
        List<String> forces = new ArrayList<String>();
        List<String> intelligences = new ArrayList<String>();
        List<String> vitesses = new ArrayList<String>();
        List<String> chances = new ArrayList<String>();
        List<String> resistances = new ArrayList<String>();
        List<String> races = new ArrayList<String>();
        System.out.println(System.getProperty("user.dir"));
        try {
            Path pathNom = Paths.get("vue/Sauvegarde/Nom");
            Noms = Files.readAllLines(pathNom);

            Path pathDescription = Paths.get("vue/Sauvegarde/Description");
            descriptions = Files.readAllLines(pathDescription);

            Path pathForce= Paths.get("vue/Sauvegarde/Force");
            forces = Files.readAllLines(pathForce);

            Path pathIntel = Paths.get("vue/Sauvegarde/Intelligence");
            intelligences = Files.readAllLines(pathIntel);

            Path pathVitesse = Paths.get("vue/Sauvegarde/Vitesse");
            vitesses = Files.readAllLines(pathVitesse);

            Path pathChance = Paths.get("vue/Sauvegarde/Chance");
            chances = Files.readAllLines(pathChance);

            Path pathRes = Paths.get("vue/Sauvegarde/Resistance");
            resistances = Files.readAllLines(pathRes);

            Path pathRace = Paths.get("vue/Sauvegarde/Race");
            races = Files.readAllLines(pathRace);
        } catch (IOException e) {
        }

        for (int i=0; i<Noms.size(); i++) {
            Race race = null;
            if (races.get(i).equals("Humain")) {
                race = new RaceHumain();
            }

            Personnage personnage = new Personnage(Noms.get(i), race, descriptions.get(i));
            JPanel panelPerso =new PanelPerso(personnage);
            panelPerso.addMouseListener(new MouseListener());
            panelPersos.add(panelPerso);
        }

        this.fenetreChoixPerso.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        this.fenetreChoixPerso.pack();
        this.fenetreChoixPerso.setSize(1024, 640);
        this.fenetreChoixPerso.setLocationRelativeTo(null);
        this.fenetreChoixPerso.setVisible(true);

    }

    public static void main(String[] args) {
        EventQueue.invokeLater(new Runnable() {
            public void run() {
                new ChoixPersonnages(new Plateau(10,10,"test"));
            }
        });
    }

    private class MouseListener extends MouseAdapter{
        @Override
        public void mouseClicked(MouseEvent e) {
            System.out.println("Clic Perso");
            PanelPerso sourceClic = (PanelPerso) e.getSource();
            Personnage PersoClic = sourceClic.getPersonnage();
            if (!ListePerso.remove(PersoClic)){
                ListePerso.add(PersoClic);
                sourceClic.setBorder(BorderFactory.createLineBorder(Color.red));
            }
            else{
                sourceClic.setBorder(BorderFactory.createLineBorder(Color.black));
            }

        }
    }


    private class ActionRetour implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            System.out.println("Retour");
            fenetreChoixPerso.dispose();
            new ChoixEnvironnement();
        }
    }
    private class ActionValider implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {

            System.out.println("Valider");
            if (ListePerso.size()<2){
                JFrame erreur = new JFrame("Erreur");
                JLabel messageErreur = new JLabel("Vous devez sélectionner au moins 2 personnages pour continuer. Veuillez réessayer");
                messageErreur.setHorizontalAlignment(JLabel.CENTER);
                erreur.add(messageErreur);
                erreur.pack();
                erreur.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
                erreur.setSize(500, 100);
                erreur.setLocationRelativeTo(null);
                erreur.setVisible(true);
            }
            else{
                fenetreChoixPerso.dispose();
                System.out.println("lancement du jeu (retour au menu pour l'instant). les persos choisis sont:");
                for(Personnage i : ListePerso){
                    System.out.println(i.getNom());
                }
                //new MenuPrincipal();
            new Jeu(plateauJeu, ListePerso);
            }
        }
    }

}
