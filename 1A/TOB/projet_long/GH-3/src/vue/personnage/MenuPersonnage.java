package vue.personnage;
import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.EventQueue;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import javax.swing.*;

import modele.EquipableArme;
import modele.EquipableArmure;
import modele.EquipableBottes;
import modele.EquipableTete;
import modele.Personnage;
import modele.Race;
import modele.RaceHumain;
import modele.Statistiques;
import vue.MenuPrincipal;

public class MenuPersonnage {

	
	private JFrame fenetreAjoutPerso;
	
	private JFrame Fmenu = new JFrame("Menu Personnage");
	
	private final JButton boutonAjouter = new JButton("Nouveau");
	
	private final JButton boutonRetour = new JButton("Retour");
	
	JMenu menuPerso = new JMenu();
	
	JMenuItem supprimer = new JMenuItem("Supprimer");
	
	public MenuPersonnage() {
		
		this.fenetreAjoutPerso = new JFrame("Personnages");
		
		Container contenu = this.fenetreAjoutPerso.getContentPane();
		
		JPanel panelBouton = new JPanel();
		
		panelBouton.setLayout(new BoxLayout(panelBouton, BoxLayout.Y_AXIS));
		//bordure jolie
		panelBouton.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));
		
		boutonAjouter.setPreferredSize(new Dimension(150,50));
		boutonAjouter.addActionListener(new ActionNouveauPerso());
		boutonAjouter.setAlignmentX(Component.CENTER_ALIGNMENT);
		
		boutonRetour.setPreferredSize(new Dimension(150,50));
		boutonRetour.addActionListener(new ActionRetour());
		boutonRetour.setAlignmentX(Component.CENTER_ALIGNMENT);
		
		panelBouton.add(boutonAjouter);
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
			personnage.getStatistiques().addForce(Integer.parseInt(forces.get(i))-personnage.getStatistiques().getForce());
			personnage.getStatistiques().addIntelligence(Integer.parseInt(intelligences.get(i))-personnage.getStatistiques().getIntelligence());
			personnage.getStatistiques().addVitesse(Integer.parseInt(vitesses.get(i))-personnage.getStatistiques().getVitesse());
			personnage.getStatistiques().addChance(Integer.parseInt(chances.get(i))-personnage.getStatistiques().getChance());
			personnage.getStatistiques().addResistance(Integer.parseInt(resistances.get(i))-personnage.getStatistiques().getResistance());
			
			//Equiper(personnage,i);
			
			JPanel panelPerso = new PanelPerso(personnage);
			panelPerso.addMouseListener(new MenuPerso(personnage));
			panelPersos.add(panelPerso);
		}
		
		this.fenetreAjoutPerso.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
			
		this.fenetreAjoutPerso.pack();
		this.fenetreAjoutPerso.setSize(1024, 640);
		this.fenetreAjoutPerso.setLocationRelativeTo(null);
		this.fenetreAjoutPerso.setVisible(true);
		
	}
	
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				new MenuPersonnage();
			}
		});
	}
	
	
	private class ActionRetour implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Retour");
			fenetreAjoutPerso.dispose();
			new MenuPrincipal();
		}		
	}
	
	private class ActionNouveauPerso implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			fenetreAjoutPerso.dispose();
			new CreerPersonnage();
		}		
	}

	private class MenuPerso extends MouseAdapter {
		
		private Personnage personnage;
		
		public MenuPerso(Personnage personnage) {
			this.personnage = personnage;
		}
		
		@Override
		public void mouseClicked(MouseEvent e) {
			Container content = Fmenu.getContentPane();
			JPanel panel = new JPanel();
			panel.setLayout(new GridLayout(3,1));
			JLabel nom = new JLabel(personnage.getNom());
			nom.setHorizontalAlignment(JLabel.CENTER);
			panel.add(nom);
			
			JButton JEquiper = new JButton("Équiper");
			JButton JSupprimer = new JButton("Supprimer");
			JEquiper.addActionListener(new EquiperPerso(personnage));
			JSupprimer.addActionListener(new SupprimerPerso(personnage));
			panel.add(JEquiper);
			panel.add(JSupprimer);
			
			content.add(panel);
			
			Fmenu.pack();
			Fmenu.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
			Fmenu.setSize(200, 400);
			Fmenu.setLocationRelativeTo(null);
			Fmenu.setVisible(true);
		}		
	}
	
	private class EquiperPerso implements ActionListener {
		
		Personnage personnage;
		
		public EquiperPerso(Personnage personnage) {
			this.personnage = personnage;
		}
		
		@Override
		public void actionPerformed(ActionEvent e) {
			Fmenu.dispose();
			fenetreAjoutPerso.dispose();
			new EquiperPersonnage(personnage);
		}
	}
	
	private class SupprimerPerso implements ActionListener {
		
		private Personnage personnage;
		
		public SupprimerPerso(Personnage personnage) {
			this.personnage = personnage;
		}
		
		private void SupprimerEquipement(String equipement) {
			int indice = 0;

			try {
				Path pathNom = Paths.get("vue/Sauvegarde/" + equipement + "/Nom");
				List<String> Noms = new ArrayList<String>();
				Noms = Files.readAllLines(pathNom);
				indice = Noms.indexOf(personnage.getNom());
				Noms.remove(personnage.getNom());
				Files.write(pathNom, Noms);
			} catch (IOException f) {
			}
			
			try {
				Path path = Paths.get("vue/Sauvegarde/" + equipement + "Description");
				List<String> descriptions = new ArrayList<String>();
				descriptions = Files.readAllLines(path);
				descriptions.remove(personnage.getDescription());
				Files.write(path, descriptions);
			} catch (IOException e1) {
			}
			try {
				Path path = Paths.get("vue/Sauvegarde/" + equipement + "Force");
				List<String> forces = new ArrayList<String>();
				forces = Files.readAllLines(path);
				forces.remove(Integer.toString(personnage.getStatistiques().getForce()));
				Files.write(path, forces);
			} catch (IOException e1) {
			}
			try {
				Path path = Paths.get("vue/Sauvegarde/" + equipement + "Vitesse");
				List<String> vitesses = new ArrayList<String>();
				vitesses = Files.readAllLines(path);
				vitesses.remove(Integer.toString(personnage.getStatistiques().getVitesse()));
				Files.write(path, vitesses);
			} catch (IOException e1) {
			}
			try {
				Path path = Paths.get("vue/Sauvegarde/" + equipement + "Intelligence");
				List<String> intelligences = new ArrayList<String>();
				intelligences = Files.readAllLines(path);
				intelligences.remove(Integer.toString(personnage.getStatistiques().getIntelligence()));
				Files.write(path, intelligences);
			} catch (IOException e1) {
			}
			try {
				Path path = Paths.get("vue/Sauvegarde/" + equipement + "Chance");
				List<String> chances = new ArrayList<String>();
				chances = Files.readAllLines(path);
				chances.remove(Integer.toString(personnage.getStatistiques().getChance()));
				Files.write(path, chances);
			} catch (IOException e1) {
			}
			try {
				Path path = Paths.get("vue/Sauvegarde/" + equipement + "Resistance");
				List<String> resistances = new ArrayList<String>();
				resistances = Files.readAllLines(path);
				resistances.remove(Integer.toString(personnage.getStatistiques().getResistance()));
				Files.write(path, resistances);
			} catch (IOException e1) {
			}
			try {
				Path path = Paths.get("vue/Sauvegarde/" + equipement + "Race");
				List<String> races = new ArrayList<String>();
				races = Files.readAllLines(path);
				races.remove(indice);
				Files.write(path, races);
			} catch (IOException e1) {
			}
		}
		
		@Override
		public void actionPerformed(ActionEvent e) {
			int indice = 0;

			try {
				Path pathNom = Paths.get("vue/Sauvegarde/Nom");
				List<String> Noms = new ArrayList<String>();
				Noms = Files.readAllLines(pathNom);
				indice = Noms.indexOf(personnage.getNom());
				Noms.remove(personnage.getNom());
				Files.write(pathNom, Noms);
			} catch (IOException f) {
			}
			
			try {
				Path path = Paths.get("vue/Sauvegarde/Description");
				List<String> descriptions = new ArrayList<String>();
				descriptions = Files.readAllLines(path);
				descriptions.remove(personnage.getDescription());
				Files.write(path, descriptions);
			} catch (IOException e1) {
			}
			try {
				Path path = Paths.get("vue/Sauvegarde/Force");
				List<String> forces = new ArrayList<String>();
				forces = Files.readAllLines(path);
				forces.remove(Integer.toString(personnage.getStatistiques().getForce()));
				Files.write(path, forces);
			} catch (IOException e1) {
			}
			try {
				Path path = Paths.get("vue/Sauvegarde/Vitesse");
				List<String> vitesses = new ArrayList<String>();
				vitesses = Files.readAllLines(path);
				vitesses.remove(Integer.toString(personnage.getStatistiques().getVitesse()));
				Files.write(path, vitesses);
			} catch (IOException e1) {
			}
			try {
				Path path = Paths.get("vue/Sauvegarde/Intelligence");
				List<String> intelligences = new ArrayList<String>();
				intelligences = Files.readAllLines(path);
				intelligences.remove(Integer.toString(personnage.getStatistiques().getIntelligence()));
				Files.write(path, intelligences);
			} catch (IOException e1) {
			}
			try {
				Path path = Paths.get("vue/Sauvegarde/Chance");
				List<String> chances = new ArrayList<String>();
				chances = Files.readAllLines(path);
				chances.remove(Integer.toString(personnage.getStatistiques().getChance()));
				Files.write(path, chances);
			} catch (IOException e1) {
			}
			try {
				Path path = Paths.get("vue/Sauvegarde/Resistance");
				List<String> resistances = new ArrayList<String>();
				resistances = Files.readAllLines(path);
				resistances.remove(Integer.toString(personnage.getStatistiques().getResistance()));
				Files.write(path, resistances);
			} catch (IOException e1) {
			}
			try {
				Path path = Paths.get("vue/Sauvegarde/Race");
				List<String> races = new ArrayList<String>();
				races = Files.readAllLines(path);
				races.remove(indice);
				Files.write(path, races);
			} catch (IOException e1) {
			}
			SupprimerEquipement("Tete");
			SupprimerEquipement("Arme");
			SupprimerEquipement("Armure");
			SupprimerEquipement("Bottes");
			Fmenu.dispose();
			fenetreAjoutPerso.dispose();
			new MenuPersonnage();
		}
	}

	public void Equiper(Personnage personnage, int i) {
		
		List<String> nomsEqu = new ArrayList<String>();
		List<String> descEqu = new ArrayList<String>();
		List<String> forcesEqu = new ArrayList<String>();
		List<String> intelligencesEqu = new ArrayList<String>();
		List<String> vitessesEqu = new ArrayList<String>();
		List<String> chancesEqu = new ArrayList<String>();
		List<String> resistancesEqu = new ArrayList<String>();
		
		
		try {
			Path pathNoms= Paths.get("vue/Sauvegarde/Tete/Nom");
			nomsEqu = Files.readAllLines(pathNoms);
			
			Path pathDesc= Paths.get("vue/Sauvegarde/Tete/Description");
			descEqu = Files.readAllLines(pathDesc);
			
			Path pathForce= Paths.get("vue/Sauvegarde/Tete/Force");
			forcesEqu = Files.readAllLines(pathForce);
			
			Path pathIntel = Paths.get("vue/Sauvegarde/Tete/Intelligence");
			intelligencesEqu = Files.readAllLines(pathIntel);
			
			Path pathVitesse = Paths.get("vue/Sauvegarde/Tete/Vitesse");
			vitessesEqu = Files.readAllLines(pathVitesse);
			
			Path pathChance = Paths.get("vue/Sauvegarde/Tete/Chance");
			chancesEqu = Files.readAllLines(pathChance);
			
			Path pathRes = Paths.get("vue/Sauvegarde/Tete/Resistance");
			resistancesEqu = Files.readAllLines(pathRes);
		} catch (IOException e) {
		}
		
		if (nomsEqu.size() != 0) {
			EquipableTete newTete = new EquipableTete(nomsEqu.get(i), descEqu.get(i),
					new Statistiques(Integer.parseInt(forcesEqu.get(i)), Integer.parseInt(intelligencesEqu.get(i)), 
							Integer.parseInt(vitessesEqu.get(i)), Integer.parseInt(chancesEqu.get(i)), Integer.parseInt(resistancesEqu.get(i))));
			personnage.getEquipement().echangerEquipementTete(newTete);
		}

		
		
		try {
			Path pathNoms= Paths.get("vue/Sauvegarde/Bottes/Nom");
			nomsEqu = Files.readAllLines(pathNoms);
			
			Path pathDesc= Paths.get("vue/Sauvegarde/Bottes/Description");
			descEqu = Files.readAllLines(pathDesc);
			
			Path pathForce= Paths.get("vue/Sauvegarde/Bottes/Force");
			forcesEqu = Files.readAllLines(pathForce);
			
			Path pathIntel = Paths.get("vue/Sauvegarde/Bottes/Intelligence");
			intelligencesEqu = Files.readAllLines(pathIntel);
			
			Path pathVitesse = Paths.get("vue/Sauvegarde/Bottes/Vitesse");
			vitessesEqu = Files.readAllLines(pathVitesse);
			
			Path pathChance = Paths.get("vue/Sauvegarde/Bottes/Chance");
			chancesEqu = Files.readAllLines(pathChance);
			
			Path pathRes = Paths.get("vue/Sauvegarde/Bottes/Resistance");
			resistancesEqu = Files.readAllLines(pathRes);
		} catch (IOException e) {
		}
		if (nomsEqu.size() != 0) {
			EquipableBottes newBottes = new EquipableBottes(nomsEqu.get(i), descEqu.get(i),
					new Statistiques(Integer.parseInt(forcesEqu.get(i)), Integer.parseInt(intelligencesEqu.get(i)), 
							Integer.parseInt(vitessesEqu.get(i)), Integer.parseInt(chancesEqu.get(i)), Integer.parseInt(resistancesEqu.get(i))));
			personnage.getEquipement().echangerEquipementBottes(newBottes);
		}
			

		try {
			Path pathNoms= Paths.get("vue/Sauvegarde/Arme/Nom");
			nomsEqu = Files.readAllLines(pathNoms);
			
			Path pathDesc= Paths.get("vue/Sauvegarde/Arme/Description");
			descEqu = Files.readAllLines(pathDesc);
			
			Path pathForce= Paths.get("vue/Sauvegarde/Arme/Force");
			forcesEqu = Files.readAllLines(pathForce);
			
			Path pathIntel = Paths.get("vue/Sauvegarde/Arme/Intelligence");
			intelligencesEqu = Files.readAllLines(pathIntel);
			
			Path pathVitesse = Paths.get("vue/Sauvegarde/Arme/Vitesse");
			vitessesEqu = Files.readAllLines(pathVitesse);
			
			Path pathChance = Paths.get("vue/Sauvegarde/Arme/Chance");
			chancesEqu = Files.readAllLines(pathChance);
			
			Path pathRes = Paths.get("vue/Sauvegarde/Arme/Resistance");
			resistancesEqu = Files.readAllLines(pathRes);
		} catch (IOException e) {
		}
		if (nomsEqu.size() != 0) {
			EquipableArme newArme = new EquipableArme(nomsEqu.get(i), descEqu.get(i),
					new Statistiques(Integer.parseInt(forcesEqu.get(i)), Integer.parseInt(intelligencesEqu.get(i)), 
							Integer.parseInt(vitessesEqu.get(i)), Integer.parseInt(chancesEqu.get(i)), Integer.parseInt(resistancesEqu.get(i))));
			personnage.getEquipement().echangerEquipementArme(newArme);
		}
			

		try {
			Path pathNoms= Paths.get("vue/Sauvegarde/Armure/Nom");
			nomsEqu = Files.readAllLines(pathNoms);
			
			Path pathDesc= Paths.get("vue/Sauvegarde/Armure/Description");
			descEqu = Files.readAllLines(pathDesc);
			
			Path pathForce= Paths.get("vue/Sauvegarde/Armure/Force");
			forcesEqu = Files.readAllLines(pathForce);
			
			Path pathIntel = Paths.get("vue/Sauvegarde/Armure/Intelligence");
			intelligencesEqu = Files.readAllLines(pathIntel);
			
			Path pathVitesse = Paths.get("vue/Sauvegarde/Armure/Vitesse");
			vitessesEqu = Files.readAllLines(pathVitesse);
			
			Path pathChance = Paths.get("vue/Sauvegarde/Armure/Chance");
			chancesEqu = Files.readAllLines(pathChance);
			
			Path pathRes = Paths.get("vue/Sauvegarde/Armure/Resistance");
			resistancesEqu = Files.readAllLines(pathRes);
		} catch (IOException e) {
		}
		if (nomsEqu.size() != 0) {	
			EquipableArmure newArmure = new EquipableArmure(nomsEqu.get(i), descEqu.get(i),
					new Statistiques(Integer.parseInt(forcesEqu.get(i)), Integer.parseInt(intelligencesEqu.get(i)), 
							Integer.parseInt(vitessesEqu.get(i)), Integer.parseInt(chancesEqu.get(i)), Integer.parseInt(resistancesEqu.get(i))));
			personnage.getEquipement().echangerEquipementArmure(newArmure);
		}
	}
}
