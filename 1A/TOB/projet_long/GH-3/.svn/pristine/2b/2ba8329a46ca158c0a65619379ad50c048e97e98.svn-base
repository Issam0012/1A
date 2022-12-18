package vue.event;

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


public class MenuEvent {
	
	private JFrame fenetreAjoutEvent;
	
	private JFrame Fmenu = new JFrame("Menu Event");
	
	private final JButton boutonAjouter = new JButton("Nouveau");
	
	private final JButton boutonRetour = new JButton("Retour");
	
	public MenuEvent() {
		this.fenetreAjoutEvent = new JFrame("Evenements");
		Container contenu = this.fenetreAjoutEvent.getContentPane();
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
		
		
		this.fenetreAjoutEvent.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		this.fenetreAjoutEvent.pack();
		this.fenetreAjoutEvent.setSize(1024, 640);
		this.fenetreAjoutEvent.setLocationRelativeTo(null);
		this.fenetreAjoutEvent.setVisible(true);
	}
	
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				new MenuEvent();
			}
		});
	}
	
	private class ActionRetour implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Retour");
			fenetreAjoutEvent.dispose();
			new MenuPrincipal();
		}		
	}
	private class ActionNouveauDe implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			//fenetreAjoutEvent.dispose();
			//new CreerEvent();
		}		
	}
}

