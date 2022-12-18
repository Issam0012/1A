package vue.personnage;


import modele.*;



import java.awt.*;
import java.util.List;
import java.awt.event.*;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import javax.swing.*;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

public class EditerPersonnage extends JFrame implements VisuelPersonnageEdit {

	private Personnage personnage;
	
	final private JButton JAnnuler = new JButton("Annuler");
	
	final private JButton JEnregistrer = new JButton("Enregistrer");

	private JFrame fenetreEditionPerso; //fenetre principale

	private JSlider JForce;

	private JSlider JIntel;

	private JSlider JVitesse;

	private JSlider JLuck;
	
	private JSlider JResistance;

	public EditerPersonnage(Personnage personnage) {
		afficherInterface(personnage); 
	}	

	@Override
	public void afficherInterface(Personnage personnage) {
		
		this.personnage = personnage;
		
		this.fenetreEditionPerso = new JFrame("Edition Personnage");		
		this.fenetreEditionPerso.setSize(1024,640);
		this.fenetreEditionPerso.setLocationRelativeTo(null);
		this.fenetreEditionPerso.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		Container contenu = this.fenetreEditionPerso.getContentPane();		
		JPanel panel = new JPanel();
		JPanel panelStats = new JPanel();
		JPanel panelDesc = new JPanel();
		
		// Le grand panel qui va tout contenir
		panel.setLayout(new GridLayout(1,2));
		
		//Construction zone Description
		
		panelDesc.setLayout(new GridLayout(7,1));
		
		/**Creation des labels */
		JLabel imagePerso = new JLabel(new ImageIcon("vue/tux.jpg"));
		JLabel textRace = new JLabel(personnage.getRace().getRace());
		JLabel titreNom = new JLabel("Nom du personnage");
		JLabel textNom = new JLabel(personnage.getNom());
		JLabel titreDesc = new JLabel("Description du personnage");
		JLabel textDesc = new JLabel(personnage.getDescription());		
		
		imagePerso.setMaximumSize(new Dimension(300,200));
		
		textRace.setHorizontalAlignment(JLabel.CENTER);
		textRace.setFont(new Font("Serif", Font.BOLD, 20));
		textRace.setMaximumSize(new Dimension(300,30));
		
		titreNom.setHorizontalAlignment(JLabel.CENTER);
		titreNom.setFont(new Font("Serif", Font.BOLD, 20));
		titreNom.setMaximumSize(new Dimension(300,30));
		
		titreDesc.setHorizontalAlignment(JLabel.CENTER);
		titreDesc.setFont(new Font("Serif", Font.BOLD, 20));
		titreDesc.setMaximumSize(new Dimension(300,30));
		
		textNom.setFont(new Font("Serif", Font.BOLD, 20));
		textNom.setHorizontalAlignment(JLabel.CENTER);
		textNom.setBackground(Color.red);
		textNom.setOpaque(true);
		textNom.setMaximumSize(new Dimension(300,50));
		
		textDesc.setFont(new Font("Serif", Font.BOLD, 20));
		textDesc.setHorizontalAlignment(JLabel.CENTER);
		textDesc.setBackground(Color.red);
		textDesc.setOpaque(true);
		textDesc.setMaximumSize(new Dimension(300,200));

		
		//panelDesc.add(imagePerso);
		JLabel titrePerso = new JLabel("Personnage :");
		titrePerso.setHorizontalAlignment(JLabel.CENTER);
		titrePerso.setFont(new Font("Serif", Font.BOLD, 20));
		panelDesc.add(titrePerso);
		
		panelDesc.add(textRace);
		panelDesc.add(titreNom);
		panelDesc.add(textNom);
		panelDesc.add(titreDesc);
		panelDesc.add(textDesc);
		
		JPanel panelFin = new JPanel();
		panelFin.setLayout(new GridLayout(1,2));
		
		JAnnuler.addActionListener(new AnnulerPersonnage());
		//JAnnuler.setPreferredSize(new Dimension(100,70));
		panelFin.add(JAnnuler);
		
		JEnregistrer.addActionListener(new EnregistrerPersonnage());
		//JAnnuler.setPreferredSize(new Dimension(100,70));
		panelFin.add(JEnregistrer);
		
		panelDesc.add(panelFin);
		
		//Construction de la zone des statistiques du personnage
		
		panelStats.setLayout(new GridLayout(7, 2));
		//panelStats.setBorder(BorderFactory.createEmptyBorder(0, 0, 0, 0));
		
		JLabel textStatForce = new JLabel("Force");
		textStatForce.setHorizontalAlignment(JLabel.CENTER);
		JForce = new JSlider(JSlider.HORIZONTAL, 0, 10 , personnage.getStatistiques().getForce());
		JForce.addChangeListener(new AdjusterForce());
		JForce.setMinorTickSpacing(1);
		JForce.setPaintTicks(true);

		JLabel textStatIntel = new JLabel("Intelligence");
		textStatIntel.setHorizontalAlignment(JLabel.CENTER);
		JIntel = new JSlider(JSlider.HORIZONTAL, 0, 10 , personnage.getStatistiques().getIntelligence());
		JIntel.addChangeListener(new AdjusterIntel());
		JIntel.setMinorTickSpacing(1);
		JIntel.setPaintTicks(true);
		
		JLabel textStatVitesse = new JLabel("Vitesse");
		textStatVitesse.setHorizontalAlignment(JLabel.CENTER);
		JVitesse = new JSlider(JSlider.HORIZONTAL, 0, 10 , personnage.getStatistiques().getVitesse());
		JVitesse.addChangeListener(new AdjusterVitesse());
		JVitesse.setMinorTickSpacing(1);
		JVitesse.setPaintTicks(true);
		
		JLabel textStatLuck = new JLabel("Chance");
		textStatLuck.setHorizontalAlignment(JLabel.CENTER);
		JLuck = new JSlider(JSlider.HORIZONTAL, 0, 10 , personnage.getStatistiques().getChance());
		JLuck.addChangeListener(new AdjusterLuck());
		JLuck.setMinorTickSpacing(1);
		JLuck.setPaintTicks(true);
		
		JLabel textStatRes = new JLabel("Résistance");
		textStatRes.setHorizontalAlignment(JLabel.CENTER);
		JResistance = new JSlider(JSlider.HORIZONTAL, 0, 10 , personnage.getStatistiques().getResistance());
		JResistance.addChangeListener(new AdjusterResistance());
		JResistance.setMinorTickSpacing(1);
		JResistance.setPaintTicks(true);
		
		
		//panelStats.add(Box.createVerticalStrut(100));
		JLabel titreCarac = new JLabel("Caractère");
		titreCarac.setHorizontalAlignment(JLabel.CENTER);
		titreCarac.setFont(new Font("Serif", Font.BOLD, 20));
		panelStats.add(titreCarac);
		
		JLabel titreValeur = new JLabel("Valeur");
		titreValeur.setHorizontalAlignment(JLabel.CENTER);
		titreValeur.setFont(new Font("Serif", Font.BOLD, 20));
		panelStats.add(titreValeur);
		
		panelStats.add(textStatForce);
		panelStats.add(JForce);
		
		panelStats.add(textStatIntel);
		panelStats.add(JIntel);
		
		panelStats.add(textStatVitesse);
		panelStats.add(JVitesse);	
		
		panelStats.add(textStatLuck);
		panelStats.add(JLuck);
		
		panelStats.add(textStatRes);
		panelStats.add(JResistance);
		
		//Ajout des differentes zones a la fenetre
		
		panel.add(panelDesc);
		panel.add(panelStats);
		//contenu.add(panelDesc, BorderLayout.WEST);
		//contenu.add(panelStats, BorderLayout.CENTER);
		contenu.add(panel);
		
		this.fenetreEditionPerso.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		this.fenetreEditionPerso.setVisible(true);		 
	}

	
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				new EditerPersonnage(new Personnage("testnom", new RaceHumain(), "testdescription"));
			}
		});
	}


	private class AdjusterForce implements ChangeListener{
		@Override
		public void stateChanged(ChangeEvent e) { 
	        personnage.getStatistiques().addForce(JForce.getValue()-personnage.getStatistiques().getForce());
	    } 	
	}
	
	private class AdjusterIntel implements ChangeListener{
		@Override
		public void stateChanged(ChangeEvent e) { 
	        personnage.getStatistiques().addIntelligence(JIntel.getValue()-personnage.getStatistiques().getIntelligence());
	    } 	
	}
	
	private class AdjusterVitesse implements ChangeListener{
		@Override
		public void stateChanged(ChangeEvent e) { 
	        personnage.getStatistiques().addVitesse(JVitesse.getValue()-personnage.getStatistiques().getVitesse());
	    } 	
	}
	
	private class AdjusterLuck implements ChangeListener{
		@Override
		public void stateChanged(ChangeEvent e) { 
	        personnage.getStatistiques().addChance(JLuck.getValue()-personnage.getStatistiques().getChance());
	    } 	
	}
	
	private class AdjusterResistance implements ChangeListener{
		@Override
		public void stateChanged(ChangeEvent e) { 
	        personnage.getStatistiques().addResistance(JResistance.getValue()-personnage.getStatistiques().getResistance());
	    } 	
	}
	
	private class AnnulerPersonnage implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			fenetreEditionPerso.dispose();
			new MenuPersonnage();
		}
	}


	private class EnregistrerPersonnage implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			ArrayList<Personnage> personnages = new ArrayList<Personnage>();
			personnages.add(personnage);
			try {
				Path path = Paths.get("vue/Sauvegarde/Nom");
				List<String> Noms = new ArrayList<String>();
				Noms = Files.readAllLines(path);
				Noms.add(personnage.getNom());
				Files.write(path, Noms);
			} catch (IOException e1) {
			}
			try {
				Path path = Paths.get("vue/Sauvegarde/Description");
				List<String> descriptions = new ArrayList<String>();
				descriptions = Files.readAllLines(path);
				descriptions.add(personnage.getDescription());
				Files.write(path, descriptions);
			} catch (IOException e1) {
			}
			try {
				Path path = Paths.get("vue/Sauvegarde/Force");
				List<String> forces = new ArrayList<String>();
				forces = Files.readAllLines(path);
				forces.add(Integer.toString(personnage.getStatistiques().getForce()));
				Files.write(path, forces);
			} catch (IOException e1) {
			}
			try {
				Path path = Paths.get("vue/Sauvegarde/Vitesse");
				List<String> vitesses = new ArrayList<String>();
				vitesses = Files.readAllLines(path);
				vitesses.add(Integer.toString(personnage.getStatistiques().getVitesse()));
				Files.write(path, vitesses);
			} catch (IOException e1) {
			}
			try {
				Path path = Paths.get("vue/Sauvegarde/Intelligence");
				List<String> intelligences = new ArrayList<String>();
				intelligences = Files.readAllLines(path);
				intelligences.add(Integer.toString(personnage.getStatistiques().getIntelligence()));
				Files.write(path, intelligences);
			} catch (IOException e1) {
			}
			try {
				Path path = Paths.get("vue/Sauvegarde/Chance");
				List<String> chances = new ArrayList<String>();
				chances = Files.readAllLines(path);
				chances.add(Integer.toString(personnage.getStatistiques().getChance()));
				Files.write(path, chances);
			} catch (IOException e1) {
			}
			try {
				Path path = Paths.get("vue/Sauvegarde/Resistance");
				List<String> resistances = new ArrayList<String>();
				resistances = Files.readAllLines(path);
				resistances.add(Integer.toString(personnage.getStatistiques().getResistance()));
				Files.write(path, resistances);
			} catch (IOException e1) {
			}
			try {
				Path path = Paths.get("vue/Sauvegarde/Race");
				List<String> races = new ArrayList<String>();
				races = Files.readAllLines(path);
				races.add("Humain");
				Files.write(path, races);
			} catch (IOException e1) {
			}
			fenetreEditionPerso.dispose();
			new MenuPersonnage();
		}
	}
}
