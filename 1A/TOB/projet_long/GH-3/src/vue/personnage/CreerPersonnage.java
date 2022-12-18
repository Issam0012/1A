package vue.personnage;

import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.*;

import modele.Personnage;
import modele.Race;
import modele.RaceHumain;


public class CreerPersonnage {
	
	private JFrame fenetreEditPerso;
	
	final private JLabel JNom = new JLabel("Nom");
	
	final private JTextField nom = new JTextField(25);
	
	final private JLabel JRace = new JLabel("Race");
	
	final private JCheckBox JHumain = new JCheckBox("Humain");
	
	//final private JCheckBox JAutre = new JCheckBox("Autre");
	
	final private JLabel JDescription = new JLabel("Description");
	
	final private JTextField description = new JTextField(25);
	
	final private JButton JAnnuler = new JButton("Annuler");
	
	final private JButton JSuivant = new JButton("Suivant");
	
	Personnage personnage;
	
	public CreerPersonnage() {
		
		this.fenetreEditPerso = new JFrame("Menu création personnages");

		Container contenu = this.fenetreEditPerso.getContentPane();
		
		contenu.setLayout(new BorderLayout());
		
		JPanel panel = new JPanel(new GridLayout(4,2));
		
		JNom.setHorizontalAlignment(JLabel.CENTER);
		panel.add(JNom);
		
		JPanel panelNom = new JPanel();
		panelNom.setLayout(new FlowLayout());
		nom.setPreferredSize(new Dimension(150,100));
		panelNom.add(nom);
		panel.add(panelNom);
		
		JRace.setHorizontalAlignment(JLabel.CENTER);
		panel.add(JRace);
		
		JPanel Races = new JPanel(new GridLayout(2,1));
		JHumain.setHorizontalAlignment(JLabel.CENTER);
		Races.add(JHumain);
		
		//JAutre.setHorizontalAlignment(JLabel.CENTER);
		//Races.add(JAutre);
		
		panel.add(Races);
		
		JDescription.setHorizontalAlignment(JLabel.CENTER);
		panel.add(JDescription);
		
		JPanel panelDescription = new JPanel();
		panelDescription.setLayout(new FlowLayout());
		description.setPreferredSize(new Dimension(150,100));
		panelDescription.add(description);
		panel.add(panelDescription);
		
		JPanel panelFin = new JPanel();
		panelFin.setLayout(new FlowLayout());
		JAnnuler.addActionListener(new AnnulerPersonnage());
		JAnnuler.setPreferredSize(new Dimension(100,70));
		panelFin.add(JAnnuler);
		panel.add(panelFin);
		
		JPanel panelStats = new JPanel();
		panelStats.setLayout(new FlowLayout());
		JSuivant.addActionListener(new Creer());
		JSuivant.setPreferredSize(new Dimension(100,70));
		panelStats.add(JSuivant);
		panel.add(panelStats);
		
		contenu.add(panel);
		
		this.fenetreEditPerso.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		this.fenetreEditPerso.pack();
		this.fenetreEditPerso.setSize(1024, 640);
		this.fenetreEditPerso.setLocationRelativeTo(null);
		this.fenetreEditPerso.setVisible(true);
	}
	
	private class Creer implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			try {
				String nomPersonnage = nom.getText();	
				String descriptionPersonnage = description.getText();
				Race racePersonnage = null;
				if (JHumain.isSelected()) {
					racePersonnage = new RaceHumain();
				}
				personnage = new Personnage(nomPersonnage, racePersonnage, descriptionPersonnage);
				fenetreEditPerso.dispose();
				new EditerPersonnage(personnage);
			} catch (NullPointerException f) {
				JFrame erreur = new JFrame("Erreur");
				JLabel messageErreur = new JLabel("Entrée Invalide, Réessayez");
				messageErreur.setHorizontalAlignment(JLabel.CENTER);
				erreur.add(messageErreur);
				erreur.pack();
				erreur.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
				erreur.setSize(250, 100);
				erreur.setLocationRelativeTo(null);
				erreur.setVisible(true);
			}
		}
	}
	
	private class AnnulerPersonnage implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			fenetreEditPerso.dispose();
			new MenuPersonnage();
		}
	}
	
	public static void main(String[] args) {
		new vue.personnage.CreerPersonnage();
	}
}
