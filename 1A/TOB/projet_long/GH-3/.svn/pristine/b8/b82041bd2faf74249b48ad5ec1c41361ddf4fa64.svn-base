package vue.personnage;

import modele.*;

import java.awt.*;
import java.awt.event.*;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import javax.swing.*;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

public class EquiperPersonnage extends JFrame {
	
	private Personnage personnage;
	
	private EquipableTete nouveauTete;
	private EquipableArme nouveauArme;
	private EquipableArmure nouveauArmure;
	private EquipableBottes nouveauBottes;
	
	private JFrame fenetreEquiper; //fenetre princiaple
		
	final private JButton boutonTete = new JButton("Creer equipement de tete");
	final private JButton boutonArme = new JButton("Creer arme");
	final private JButton boutonArmure = new JButton("Creer armure");
	final private JButton boutonBottes = new JButton("Creer bottes");
	
	final private JButton boutonTerminer = new JButton("Terminer");
	final private JButton boutonAnnuler = new JButton("Annuler");
	
	public EquiperPersonnage(Personnage personnage) {
		afficherInterface(personnage);
	}	

	public void afficherInterface(Personnage personnage) {
		
		this.personnage = personnage;
		
		this.fenetreEquiper = new JFrame("Equiper personnage");
		this.fenetreEquiper.setSize(1024,640);
		this.fenetreEquiper.setLocationRelativeTo(null);
		this.fenetreEquiper.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		Container contenu = this.fenetreEquiper.getContentPane();
		JTabbedPane tabOnglets = new JTabbedPane(); //Gestionnaire d'onglet
		
		JPanel ongletGeneral = new JPanel(); //onglet equipement de tete
		JPanel ongletTete = new JPanel(); //onglet equipement de tete
		JPanel ongletArme = new JPanel(); //onglet equipement arme
		JPanel ongletArmure = new JPanel(); //onglet equipement d'armure
		JPanel ongletBottes = new JPanel(); //onglet equipement de bottes		
		
		//Ajout onglets
		tabOnglets.add("General", ongletGeneral);
		tabOnglets.add("Arme", ongletArme);
		tabOnglets.add("Tete", ongletTete);
		tabOnglets.add("Armure", ongletArmure);
		tabOnglets.add("Bottes", ongletBottes);
		
		//Edition onglet general		
		ongletGeneral.setLayout(new BoxLayout(ongletGeneral, BoxLayout.Y_AXIS));
		
		JLabel titreGeneral = new JLabel("Statistiques général equipement");
		titreGeneral.setFont(new Font("Arial", Font.BOLD, 20));		
		
		JPanel panelTitre = new JPanel();
		panelTitre.setLayout(new FlowLayout());
		panelTitre.add(titreGeneral);
		
		JPanel panelForceGeneral = CreerPanelStat("Force", personnage.getEquipement().getStatsEquipement().getForce());
		JPanel panelIntelGeneral = CreerPanelStat("Intelligence", personnage.getEquipement().getStatsEquipement().getIntelligence());
		JPanel panelVitesseGeneral = CreerPanelStat("Vitesse", personnage.getEquipement().getStatsEquipement().getVitesse());
		JPanel panelLuckGeneral = CreerPanelStat("Chance", personnage.getEquipement().getStatsEquipement().getChance());
		JPanel panelResGeneral = CreerPanelStat("Resistance", personnage.getEquipement().getStatsEquipement().getResistance());
		
		JPanel panelBouton = new JPanel();
		panelBouton.setLayout(new FlowLayout());
		boutonTerminer.addActionListener(new ActionTerminer());
		boutonTerminer.setPreferredSize(new Dimension(100,50));
		panelBouton.add(boutonTerminer);
		boutonAnnuler.addActionListener(new ActionAnnuler());
		boutonAnnuler.setPreferredSize(new Dimension(100,50));
		panelBouton.add(boutonAnnuler);
		
		//Ajout differents panel a l'onglet general
		ongletGeneral.add(panelTitre);
		ongletGeneral.add(panelForceGeneral);	
		ongletGeneral.add(panelIntelGeneral);
		ongletGeneral.add(panelVitesseGeneral);
		ongletGeneral.add(panelLuckGeneral);
		ongletGeneral.add(panelResGeneral);
		ongletGeneral.add(panelBouton);		
		
		//Onglet Arme		
		ongletArme.setLayout(new BoxLayout(ongletArme, BoxLayout.X_AXIS));
		
		JPanel armeActuelle = CreerPanelEquipementActuel(personnage.getEquipement().getArme());
		JPanel armeNouveau = CreerPanelNouveauEquipement(boutonTete);
		ongletArme.add(armeActuelle, BorderLayout.WEST);
		ongletArme.add(armeNouveau, BorderLayout.EAST);
		
		//Onglet Tete
		ongletTete.setLayout(new BoxLayout(ongletTete, BoxLayout.X_AXIS));
		
		JPanel teteActuelle = CreerPanelEquipementActuel(personnage.getEquipement().getTete());
		JPanel teteNouveau = CreerPanelNouveauEquipement(boutonArme);
		ongletTete.add(teteActuelle, BorderLayout.WEST);
		ongletTete.add(teteNouveau, BorderLayout.EAST);
		
		//Onglet Armure
		ongletArmure.setLayout(new BoxLayout(ongletArmure, BoxLayout.X_AXIS));
		
		JPanel armureActuelle = CreerPanelEquipementActuel(personnage.getEquipement().getArmure());
		JPanel armureNouveau = CreerPanelNouveauEquipement(boutonArmure);
		ongletArmure.add(armureActuelle, BorderLayout.WEST);
		ongletArmure.add(armureNouveau, BorderLayout.EAST);
		
		//Onglet Bottes
		ongletBottes.setLayout(new BoxLayout(ongletBottes, BoxLayout.X_AXIS));
		
		JPanel bottesActuelle = CreerPanelEquipementActuel(personnage.getEquipement().getBottes());
		JPanel bottesNouveau = CreerPanelNouveauEquipement(boutonBottes);
		ongletBottes.add(bottesActuelle, BorderLayout.WEST);
		ongletBottes.add(bottesNouveau, BorderLayout.EAST);
		
		
		//Ajout onglet a la fenetre principale
		contenu.add(tabOnglets, BorderLayout.CENTER);
		
		this.fenetreEquiper.setVisible(true);		 

	}
	
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				new EquiperPersonnage(new Personnage("testnom", new RaceHumain(), "testdescription"));
			}
		});
	}
	
	private JPanel CreerPanelStat(String nomStat, int stat) {
		JPanel panelCreer = new JPanel();
		panelCreer.setLayout(new FlowLayout());
		JLabel labelStat = new JLabel(nomStat + " : ");
		labelStat.setFont(new Font("Arial", Font.BOLD, 15));
		JLabel labelValStat = new JLabel(String.valueOf(stat));
		
		panelCreer.add(labelStat);
		panelCreer.add(labelValStat);
		
		return panelCreer;
	}
	
	private JPanel CreerPanelNouveauStat(String nomStat) {
		JPanel panelCreer = new JPanel();
		panelCreer.setLayout(new FlowLayout());
		JLabel labelStat = new JLabel(nomStat + " : ");
		labelStat.setFont(new Font("Arial", Font.BOLD, 15));
		
		
		panelCreer.add(labelStat);
		
		
		return panelCreer;
	}
	
	private JPanel CreerPanelEquipementActuel(Equipable equipement) {
		JPanel panelStat = new JPanel();
		panelStat.setLayout(new BoxLayout(panelStat, BoxLayout.Y_AXIS));
		//Titre partie actuelle
		JPanel panelActuel = new JPanel();
		panelActuel.setLayout(new FlowLayout());
		JLabel labelActuel = new JLabel("Equipement actuel");
		labelActuel.setFont(new Font("Serif", Font.BOLD, 20));
		panelActuel.add(labelActuel);
		
		JPanel panelNom = new JPanel();
		panelNom.setLayout(new FlowLayout());
		JLabel labelNom = new JLabel("Nom equipement : " + equipement.getNom());
		panelNom.add(labelNom);
		JPanel panelDesc = new JPanel();
		panelDesc.setLayout(new FlowLayout());
		JLabel labelDesc = new JLabel("Description equipement : " + equipement.getDesc());
		panelDesc.add(labelDesc);
		
		JPanel panelForceEquip = CreerPanelStat("Force", equipement.getStatistiques().getForce());
		JPanel panelIntelEquip = CreerPanelStat("Intel", equipement.getStatistiques().getIntelligence());
		JPanel panelVitesseEquip = CreerPanelStat("Vitesse", equipement.getStatistiques().getVitesse());
		JPanel panelLuckEquip = CreerPanelStat("Chance", equipement.getStatistiques().getChance());
		JPanel panelResEquip = CreerPanelStat("Resistance", equipement.getStatistiques().getResistance());
		
		panelStat.add(panelActuel);
		panelStat.add(panelNom);
		panelStat.add(panelDesc);
		panelStat.add(panelForceEquip);
		panelStat.add(panelIntelEquip);
		panelStat.add(panelVitesseEquip);
		panelStat.add(panelLuckEquip);
		panelStat.add(panelResEquip);
		
		return panelStat;
	}
	
	private JPanel CreerPanelNouveauEquipement(JButton boutonCreer) {
		JPanel panelStat = new JPanel();
		panelStat.setLayout(new BoxLayout(panelStat, BoxLayout.Y_AXIS));
		//Titre partie actuelle
		JPanel panelNouveau = new JPanel();
		panelNouveau.setLayout(new FlowLayout());
		JLabel labelNouveau = new JLabel("Nouveau équipement");
		panelNouveau.setFont(new Font("Serif", Font.BOLD, 20));
		panelNouveau.add(labelNouveau);
		
		JPanel panelNom = new JPanel();
		panelNom.setLayout(new FlowLayout());
		JLabel labelNom = new JLabel("Nom nouveau equipement : ");
		JTextField nomEquipement = new JTextField(25);
		panelNom.add(labelNom);
		panelNom.add(nomEquipement);
		JPanel panelDesc = new JPanel();
		JTextField descEquipement = new JTextField(25);
		panelDesc.setLayout(new FlowLayout());
		JLabel labelDesc = new JLabel("Description nouveau equipement : ");
		panelDesc.add(labelDesc);
		panelDesc.add(descEquipement);
		
		JPanel panelForceEquip = CreerPanelNouveauStat("Force");
		JSlider sliderForce = CreerSlider(0);
		panelForceEquip.add(sliderForce);
		
		JPanel panelIntelEquip = CreerPanelNouveauStat("Intel");
		JSlider sliderIntel = CreerSlider(0);
		panelIntelEquip.add(sliderIntel);
		
		JPanel panelVitesseEquip = CreerPanelNouveauStat("Vitesse");
		JSlider sliderVitesse = CreerSlider(0);
		panelVitesseEquip.add(sliderVitesse);
		
		JPanel panelLuckEquip = CreerPanelNouveauStat("Chance");
		JSlider sliderLuck = CreerSlider(0);
		panelLuckEquip.add(sliderLuck);
		
		JPanel panelResEquip = CreerPanelNouveauStat("Resistance");
		JSlider sliderRes = CreerSlider(0);
		panelResEquip.add(sliderRes);
		
		JPanel panelBouton = new JPanel();
		panelBouton.setLayout(new FlowLayout());
		boutonCreer.addActionListener(new ActionRemplacerEquipement(nomEquipement, descEquipement, sliderForce, sliderIntel, sliderVitesse, sliderLuck, sliderRes));
		panelBouton.add(boutonCreer);
		
		panelStat.add(panelNouveau);
		panelStat.add(panelNom);
		panelStat.add(panelDesc);
		panelStat.add(panelForceEquip);
		panelStat.add(panelIntelEquip);
		panelStat.add(panelVitesseEquip);
		panelStat.add(panelLuckEquip);
		panelStat.add(panelResEquip);
		panelStat.add(panelBouton);
				
		return panelStat;
	}
	
	private JSlider CreerSlider(int valStat) {
		JSlider slider = new JSlider(JSlider.HORIZONTAL, 0, 10 , valStat);
		slider.setMinorTickSpacing(1);
		slider.setPaintTicks(true);
		return slider;
	}
			
	private class ActionTerminer implements ActionListener{
		@Override
		public void actionPerformed(ActionEvent e) {
			fenetreEquiper.dispose();
			new MenuPersonnage();
		}		
	}
	
	private class ActionAnnuler implements ActionListener{
		@Override
		public void actionPerformed(ActionEvent e) {
			fenetreEquiper.dispose();
			new MenuPersonnage();
		}		
	}
	
	private class ActionRemplacerEquipement implements ActionListener{
		
		private JTextField nomEquipement;
		private JTextField descEquipement;
		private JSlider sliderForce;
		private JSlider sliderIntel;
		private JSlider sliderVitesse;
		private JSlider sliderLuck;
		private JSlider sliderRes;
		
		public ActionRemplacerEquipement(JTextField nomEquipement, JTextField descEquipement, JSlider sliderForce, JSlider sliderIntel, JSlider sliderVitesse, JSlider sliderLuck, JSlider sliderRes) {
			this.nomEquipement = nomEquipement;
			this.descEquipement = descEquipement;
			this.sliderForce = sliderForce;
			this.sliderIntel = sliderIntel;
			this.sliderVitesse = sliderVitesse;
			this.sliderLuck = sliderLuck;
			this.sliderRes = sliderRes;
		}
		
		@Override
		public void actionPerformed(ActionEvent e) {	
			
			if (e.getSource() == boutonTete) {
				EquipableTete newTete = new EquipableTete(nomEquipement.getText(), descEquipement.getText(),
						new Statistiques(sliderForce.getValue(), sliderIntel.getValue(), sliderVitesse.getValue(),
								sliderLuck.getValue(), sliderRes.getValue()));
				personnage.getEquipement().echangerEquipementTete(newTete);
				enregister(newTete, Paths.get("vue/Sauvegarde/Tete/Force"), Paths.get("vue/Sauvegarde/Tete/Intelligence"),
						Paths.get("vue/Sauvegarde/Tete/Vitesse"), Paths.get("vue/Sauvegarde/Tete/Resistance"), 
						Paths.get("vue/Sauvegarde/Tete/Chance"));
				fenetreEquiper.dispose();
				new EquiperPersonnage(personnage);
			} else if (e.getSource() == boutonBottes) {
				EquipableBottes newBottes = new EquipableBottes(nomEquipement.getText(), descEquipement.getText(),
						new Statistiques(sliderForce.getValue(), sliderIntel.getValue(), sliderVitesse.getValue(),
								sliderLuck.getValue(), sliderRes.getValue()));
				enregister(newBottes, Paths.get("vue/Sauvegarde/Bottes/Force"), Paths.get("vue/Sauvegarde/Bottes/Intelligence"),
						Paths.get("vue/Sauvegarde/Bottes/Vitesse"), Paths.get("vue/Sauvegarde/Bottes/Resistance"), 
						Paths.get("vue/Sauvegarde/Bottes/Chance"));
				personnage.getEquipement().echangerEquipementBottes(newBottes);
				fenetreEquiper.dispose();
				new EquiperPersonnage(personnage);
			} else if (e.getSource() == boutonArme) {
				EquipableArme newArme = new EquipableArme(nomEquipement.getText(), descEquipement.getText(),
						new Statistiques(sliderForce.getValue(), sliderIntel.getValue(), sliderVitesse.getValue(),
								sliderLuck.getValue(), sliderRes.getValue()));
				enregister(newArme, Paths.get("vue/Sauvegarde/Arme/Force"), Paths.get("vue/Sauvegarde/Arme/Intelligence"),
						Paths.get("vue/Sauvegarde/Arme/Vitesse"), Paths.get("vue/Sauvegarde/Arme/Resistance"), 
						Paths.get("vue/Sauvegarde/Arme/Chance"));
				personnage.getEquipement().echangerEquipementArme(newArme);
				fenetreEquiper.dispose();
				new EquiperPersonnage(personnage);
			} else if (e.getSource() == boutonArmure) {
				EquipableArmure newArmure = new EquipableArmure(nomEquipement.getText(), descEquipement.getText(),
						new Statistiques(sliderForce.getValue(), sliderIntel.getValue(), sliderVitesse.getValue(),
								sliderLuck.getValue(), sliderRes.getValue()));
				enregister(newArmure, Paths.get("vue/Sauvegarde/Armure/Force"), Paths.get("vue/Sauvegarde/Armure/Intelligence"),
						Paths.get("vue/Sauvegarde/Armure/Vitesse"), Paths.get("vue/Sauvegarde/Armure/Resistance"), 
						Paths.get("vue/Sauvegarde/Armure/Chance"));
				personnage.getEquipement().echangerEquipementArmure(newArmure);
				fenetreEquiper.dispose();
				new EquiperPersonnage(personnage);
			}		

		}	
		
		private void enregister(Equipable equipement, Path pathForce, Path pathIntel, Path pathVitesse, Path pathRes, Path pathLuck) {
			try {
				List<String> forces = new ArrayList<String>();
				forces = Files.readAllLines(pathForce);
				forces.add(Integer.toString(equipement.getStatistiques().getForce()));
				Files.write(pathForce, forces);
			} catch (IOException e1) {
			}
			try {
				List<String> vitesses = new ArrayList<String>();
				vitesses = Files.readAllLines(pathVitesse);
				vitesses.add(Integer.toString(equipement.getStatistiques().getVitesse()));
				Files.write(pathVitesse, vitesses);
			} catch (IOException e1) {
			}
			try {
				List<String> intelligences = new ArrayList<String>();
				intelligences = Files.readAllLines(pathIntel);
				intelligences.add(Integer.toString(equipement.getStatistiques().getIntelligence()));
				Files.write(pathIntel, intelligences);
			} catch (IOException e1) {
			}
			try {
				List<String> chances = new ArrayList<String>();
				chances = Files.readAllLines(pathLuck);
				chances.add(Integer.toString(equipement.getStatistiques().getChance()));
				Files.write(pathLuck, chances);
			} catch (IOException e1) {
			}
			try {
				List<String> resistances = new ArrayList<String>();
				resistances = Files.readAllLines(pathRes);
				resistances.add(Integer.toString(equipement.getStatistiques().getResistance()));
				Files.write(pathRes, resistances);
			} catch (IOException e1) {
			}
		}

	}	
	
	

}
