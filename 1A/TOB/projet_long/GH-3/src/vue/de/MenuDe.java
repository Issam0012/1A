package vue.de;

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
import javax.swing.JFrame;
import javax.swing.JPanel;


public class MenuDe {
	
	private JFrame fenetreAjoutDe;
	
	private JFrame Fmenu = new JFrame("Menu De");
	
	private final JButton boutonAjouter = new JButton("Nouveau");
	
	private final JButton boutonRetour = new JButton("Retour");
	
	public MenuDe() {
		this.fenetreAjoutDe = new JFrame("Dés");
		Container contenu = this.fenetreAjoutDe.getContentPane();
		JPanel panelBouton = new JPanel();
		panelBouton.setLayout(new BoxLayout(panelBouton, BoxLayout.Y_AXIS));
		//bordure jolie
		panelBouton.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));
		
		boutonAjouter.setPreferredSize(new Dimension(150,50));
		boutonAjouter.addActionListener(new ActionNouveauDe());
		boutonAjouter.setAlignmentX(Component.CENTER_ALIGNMENT);
		
		boutonRetour.setPreferredSize(new Dimension(150,50));
		boutonRetour.addActionListener(new ActionRetour());
		boutonRetour.setAlignmentX(Component.CENTER_ALIGNMENT);
		
		panelBouton.add(boutonAjouter);
		panelBouton.add(Box.createVerticalGlue());
		panelBouton.add(boutonRetour);
		
		contenu.add(panelBouton, BorderLayout.WEST);
		
		
		this.fenetreAjoutDe.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		this.fenetreAjoutDe.pack();
		this.fenetreAjoutDe.setSize(1024, 640);
		this.fenetreAjoutDe.setLocationRelativeTo(null);
		this.fenetreAjoutDe.setVisible(true);
	}
	
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				new MenuDe();
			}
		});
	}
	
	private class ActionRetour implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Retour");
			fenetreAjoutDe.dispose();
			new MenuPrincipal();
		}		
	}
	private class ActionNouveauDe implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			fenetreAjoutDe.dispose();
			new CreerDe();
		}		
	}
}
