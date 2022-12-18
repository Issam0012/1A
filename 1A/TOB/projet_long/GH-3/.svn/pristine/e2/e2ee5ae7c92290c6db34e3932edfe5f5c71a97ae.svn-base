package vue.de;

import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JTextField;

import modele.De;

/**
 * Menu de création de dé
 */
public class CreerDe {
	
	private JFrame fenetreDe;
	private int nbDes;
	private int nbFaces;
	List<De> des = new ArrayList<De>();
	
	public CreerDe() {
		this.fenetreDe = new JFrame("Création de Dé");
		fenetreDe.setSize(445, 400);
		fenetreDe.setResizable(false);
		fenetreDe.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		fenetreDe.setLocationRelativeTo(null);
		fenetreDe.setVisible(true);
		
		Container c = fenetreDe.getContentPane();
		
		//Menu :
		
		/*JButton bCreer = new JButton("Créer");
		bCreer.setPreferredSize(new Dimension(100,40));
		bCreer.addActionListener(new ActionCreer());
		bCreer.setAlignmentX(Component.CENTER_ALIGNMENT);*/
				
		JLabel lNbDes = new JLabel("Nombre de dés : ");
		JLabel lFaces = new JLabel("Faces : ");
		
		JTextField tnbFaces = new JTextField();
		JTextField tnbDes = new JTextField();
		
		JButton bSauv = new JButton("Sauvegarder");
		bSauv.setPreferredSize(new Dimension(200,40));
		bSauv.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				try {
					nbDes = Integer.parseInt(tnbDes.getText());
					if (nbDes <= 0) {throw new NumberFormatException();}
				} catch (NumberFormatException err) {
					JFrame er = new JFrame("Erreur");
					er.setSize(300, 100);
					er.setResizable(false);
					JLabel msg = new JLabel("Nombre de dés invalide.");
					msg.setHorizontalAlignment(JLabel.CENTER);
					er.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
					er.getContentPane().add(msg);
					er.setLocationRelativeTo(null);
					er.setVisible(true);
				}
				try {
					nbFaces = Integer.parseInt(tnbFaces.getText());
					if (nbFaces < 3) {throw new NumberFormatException();}
					for (int i = 0; i < nbDes ; i++) {
						des.add(new De(nbFaces));
						System.out.println("Ajout du dé numéro " + (i+1) + " à " + des.get(i).getNbFaces() +  " faces.");
					}
				} catch (NumberFormatException err) {
					JFrame er = new JFrame("Erreur");
					er.setSize(300, 100);
					er.setResizable(false);
					JLabel msg = new JLabel("Veuilliez choisir au moins 3 faces.");
					msg.setHorizontalAlignment(JLabel.CENTER);
					er.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
					er.getContentPane().add(msg);
					er.setLocationRelativeTo(null);
					er.setVisible(true);
				}
				try {
					Path path = Paths.get("vue/Sauvegarde/De/NbDe");
					List<String> NbDes = new ArrayList<String>();
					NbDes = Files.readAllLines(path);
					NbDes.add(Integer.toString(nbDes));
					Files.write(path, NbDes);
					path = Paths.get("vue/Sauvegarde/De/NbFaces");
					List<String> NbFaces = new ArrayList<String>();
					NbFaces = Files.readAllLines(path);
					NbFaces.add(Integer.toString(nbFaces));
					Files.write(path, NbFaces);
				} catch (IOException e1) {
				}
			}
			
		});
		Box b = Box.createHorizontalBox();
		b.add(bSauv);
		b.add(Box.createHorizontalStrut(30));
		bSauv.setAlignmentX(Component.CENTER_ALIGNMENT);
		
		JButton bAnnuler = new JButton("Annuler");
		bAnnuler.setPreferredSize(new Dimension(200,40));
		bAnnuler.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				des.clear();
			}		
		});
		
		b.add(bAnnuler);
		
		JButton bFermer = new JButton("Fermer");
		bFermer.setPreferredSize(new Dimension(200,40));
		bFermer.addActionListener(new ActionFermer());
		bFermer.setAlignmentX(Component.CENTER_ALIGNMENT);	
		
		Box box = Box.createVerticalBox();
		box.add(Box.createVerticalStrut(20));
		box.add(lFaces);
		box.add(Box.createVerticalStrut(50));
		box.add(tnbFaces);
		box.add(Box.createVerticalStrut(50));
		box.add(lNbDes);
		box.add(Box.createVerticalStrut(50));
		box.add(tnbDes);
		box.add(Box.createVerticalStrut(50));
		box.add(b);
		//box.add(Box.createVerticalStrut(100));
		//box.add(bSauv);
		box.add(Box.createVerticalStrut(10));
		box.add(bFermer);
		box.setBorder(BorderFactory.createTitledBorder("Créer vos dés"));

		c.add(box, BorderLayout.WEST);
	}
	
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				new CreerDe();
			}
		});
	}
	
	private class ActionFermer implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Fermer");
			fenetreDe.dispose();
			new MenuDe();
		}		
	}
}