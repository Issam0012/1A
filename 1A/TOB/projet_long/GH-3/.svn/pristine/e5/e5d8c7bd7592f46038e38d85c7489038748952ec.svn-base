package vue.environnement;

import javax.swing.*;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import modele.*;


public class ChoixTaille {
	
	private JFrame fenetreChoixPlateau;
	
	final private JLabel labelLargeur = new JLabel("Largeur");
	private JLabel labelLargeurChoix;
	final private JLabel labelHauteur = new JLabel("Hauteur");
	private JLabel labelHauteurChoix;
	
	final private JButton boutonAnnuler = new JButton("Annuler");
	final private JButton boutonCreer = new JButton("Créer");
	final private JTextField nomPlateau = new JTextField("Écrire nom plateau ici");
	
	public ChoixTaille() {
		
		this.fenetreChoixPlateau = new JFrame("Choix taille plateau");
		this.fenetreChoixPlateau.setLocationRelativeTo(null);
		this.fenetreChoixPlateau.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		Container contenu = this.fenetreChoixPlateau.getContentPane();		
				
		contenu.setLayout(new BoxLayout(contenu, BoxLayout.Y_AXIS));
		
		//Choix largeur
		JPanel panelLargeur = new JPanel();
		JSlider sliderLargeur = CreerSlider();
		labelLargeurChoix = new JLabel(String.valueOf(0));
		sliderLargeur.addChangeListener(new AjusterValSliderLargeur(sliderLargeur));
		panelLargeur.add(labelLargeur);
		panelLargeur.add(sliderLargeur);
		panelLargeur.add(labelLargeurChoix);
		
		//Choix hauteur
		JPanel panelHauteur = new JPanel();
		JSlider sliderHauteur = CreerSlider();
		labelHauteurChoix = new JLabel(String.valueOf(0));
		sliderHauteur.addChangeListener(new AjusterValSliderHauteur(sliderHauteur));
		panelHauteur.add(labelHauteur);
		panelHauteur.add(sliderHauteur);
		panelHauteur.add(labelHauteurChoix);
		
		//Choix nom du plateau
		JPanel panelNom = new JPanel();
		JLabel titreNom = new JLabel("Nom du plateau : ");
		panelNom.add(titreNom);
		panelNom.add(nomPlateau);
		
		//Boutons de navigation
		JPanel panelBouton = new JPanel();
		panelBouton.add(boutonAnnuler);
		boutonAnnuler.addActionListener(new ActionAnnuler(this.fenetreChoixPlateau));
		panelBouton.add(boutonCreer);
		boutonCreer.addActionListener(new ActionCreer(sliderLargeur, sliderHauteur, fenetreChoixPlateau));
		
		
		contenu.add(panelLargeur);
		contenu.add(panelHauteur);	
		contenu.add(panelNom);
		contenu.add(panelBouton);
		
		this.fenetreChoixPlateau.pack();
		this.fenetreChoixPlateau.setVisible(true);
		
	}

	public static void main(String[] args) {
		new vue.environnement.ChoixTaille();
	}
	
	private JSlider CreerSlider() {
		JSlider slider = new JSlider(JSlider.HORIZONTAL, 0, 50 , 0);		
		slider.setMinorTickSpacing(1);
		slider.setPaintTicks(true);
		return slider;
	}
	
	private class AjusterValSliderHauteur implements ChangeListener{
		
		private JSlider slider;
		
		public AjusterValSliderHauteur(JSlider test) {
			this.slider = test;
		}
		
		@Override
		public void stateChanged(ChangeEvent e) { 
	        System.out.println("Hauteur" + slider.getValue());
	        labelHauteurChoix.setText(String.valueOf(slider.getValue()));
	        fenetreChoixPlateau.pack();
	    } 	
	}
	
	private class AjusterValSliderLargeur implements ChangeListener{
		
		private JSlider slider;
		
		public AjusterValSliderLargeur(JSlider test) {
			this.slider = test;
		}
		
		@Override
		public void stateChanged(ChangeEvent e) { 
	        System.out.println("Largeur : " + slider.getValue());
	        labelLargeurChoix.setText(String.valueOf(slider.getValue()));
	        fenetreChoixPlateau.pack();
	    } 	
	}
	
	private class ActionAnnuler implements ActionListener{
		
		private JFrame fenetre;
		
		public ActionAnnuler(JFrame fenetre) {
			this.fenetre = fenetre;
		}
		
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Annulation creation plateau");
			fenetre.dispose();
			new MenuEnvironnement();
		}		
	}
	
	private class ActionCreer implements ActionListener{
		
		private JSlider largeur;
		private JSlider hauteur;
		private JFrame fenetre;
		
		public ActionCreer(JSlider sliderLargeur, JSlider sliderHauteur, JFrame fenetre) {
			this.largeur = sliderLargeur;
			this.hauteur = sliderHauteur;
			this.fenetre = fenetre;
		}
		
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Création du plateau");
			System.out.println("Largeur : " + largeur.getValue());
			System.out.println("Hauteur : " + hauteur.getValue());
			
			if(largeur.getValue() != 0 && hauteur.getValue() != 0 && nomPlateau.getText() != "") {
				fenetre.dispose();
				Plateau plateauCree = new Plateau(largeur.getValue(),hauteur.getValue(), nomPlateau.getText());
				new CreerEnvironnement(plateauCree);
			} else {
				System.out.println("Impossible de créer un plateau");
			}
			
		}		
	}
	
}
