package vue;



import vue.de.MenuDe;
import vue.environnement.ChoixEnvironnement;
import vue.environnement.MenuEnvironnement;
import vue.event.MenuEvent;
import vue.personnage.MenuPersonnage;

import javax.swing.*;
import java.awt.*;

import java.awt.event.*;

/** Programmation du menu principal d'un jeu de rôle
 * 
 * @author Jean-Baptiste Prevost
 * @version 1.0
 *
 */
public class MenuPrincipal {
	
	// Les éléments de la vue (IHM)
	//-----------------------------
	
	/** Fenêtre principale */
	private JFrame fenetrePrincipale;
	
	/** Bouton pour quitter */
	private final JButton boutonQuitter = new JButton("Quitter");
	
	/** Bouton pour aller dans l'éditeur de personnage */
	private final JButton boutonPersonnage = new JButton("Personnages");
	
	/** Label du titre du menu */
	private final JLabel Titre = new JLabel("RPG-Maker");
	
	/** Bouton des **/
	private final JButton boutonDes = new JButton("Des");
	
	/** Bouton env **/
	private final JButton boutonEnvironnements = new JButton("Environnements");
	
	/** Bouton events **/
	private final JButton boutonEvenements = new JButton("Evenements");

	private final JButton boutonJouer = new JButton("Jouer");
	
	/** Le menu d'ajout du personnage **/
	private MenuPersonnage menuPersonnage;
	
	// Le menu d'édition d'environnement
	private MenuEnvironnement menuEnvironnement;
	
	
	// Le constructeur
	// ---------------
	
	public MenuPrincipal() {
		
		// Définir la fenêtre principal
		this.fenetrePrincipale = new JFrame("Jeu de role");		
		
		Container contenu = this.fenetrePrincipale.getContentPane();		
		
		// TEXTE TITRE
		//alignement
		Titre.setHorizontalAlignment( SwingConstants.CENTER );
		// police
		Titre.setFont(new Font("Arial", Font.BOLD, 28));
		
		
		contenu.add(Titre, BorderLayout.NORTH);
		
		//JPanel panelBouton = new JPanel(new GridLayout(2,1,10,10));
		JPanel panelBouton = new JPanel();
		panelBouton.setLayout(new BoxLayout(panelBouton, BoxLayout.Y_AXIS));
		
		
		
		//bordure jolie
		panelBouton.setBorder(BorderFactory.createEmptyBorder(5, 5, 5, 5));
		boutonJouer.setPreferredSize(new Dimension(150,50));
		boutonJouer.addActionListener(new ActionJouer());
		boutonJouer.setAlignmentX(Component.CENTER_ALIGNMENT);
		
		boutonPersonnage.setPreferredSize(new Dimension(150,50));
		boutonPersonnage.addActionListener(new ActionEditPersonnage());
		boutonPersonnage.setAlignmentX(Component.CENTER_ALIGNMENT);
		boutonQuitter.setPreferredSize(new Dimension(150,50));
		boutonQuitter.addActionListener(new ActionQuitter());
		boutonQuitter.setAlignmentX(Component.CENTER_ALIGNMENT);
		boutonDes.setPreferredSize(new Dimension(150,50));
		boutonDes.addActionListener(new ActionEditDes());
		boutonDes.setAlignmentX(Component.CENTER_ALIGNMENT);
		boutonEnvironnements.setPreferredSize(new Dimension(150,50));
		boutonEnvironnements.addActionListener(new ActionEditEnvironnement());
		boutonEnvironnements.setAlignmentX(Component.CENTER_ALIGNMENT);
		boutonEvenements.setPreferredSize(new Dimension(150,50));
		boutonEvenements.addActionListener(new ActionEditEvenements());
		boutonEvenements.setAlignmentX(Component.CENTER_ALIGNMENT);



		panelBouton.add(Box.createRigidArea(new Dimension(50, 50)));
		panelBouton.add(boutonJouer);
		panelBouton.add(Box.createRigidArea(new Dimension(50, 50)));
		panelBouton.add(boutonPersonnage);
		//margin 
		panelBouton.add(Box.createRigidArea(new Dimension(10, 10)));
		panelBouton.add(boutonDes);
		panelBouton.add(Box.createRigidArea(new Dimension(10, 10)));
		panelBouton.add(boutonEnvironnements);
		panelBouton.add(Box.createRigidArea(new Dimension(10, 10)));
		panelBouton.add(boutonEvenements);
		
		panelBouton.add(Box.createVerticalGlue());
		panelBouton.add(boutonQuitter);
		
		contenu.add(panelBouton, BorderLayout.WEST);
		
		this.fenetrePrincipale.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		
		this.fenetrePrincipale.pack();
		this.fenetrePrincipale.setSize(1024, 640);
		this.fenetrePrincipale.setLocationRelativeTo(null);
		this.fenetrePrincipale.setVisible(true);
		
	}
	
	public static void main(String args[]) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				new MenuPrincipal();
			}
		});
	}
	
	// Quelques réactions aux interactions de l'utilisateur
	// ----------------------------------------------------
	
	private class ActionQuitter implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Quitter");
			System.exit(0);
		}		
	}
	
	private class ActionEditPersonnage implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Edition personnage");
			fenetrePrincipale.dispose();
			menuPersonnage = new MenuPersonnage();
		}	
		
		
		
		
	}
	private class ActionEditDes implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Edition Des");
			fenetrePrincipale.dispose();
			new MenuDe();
		}	
	
}
	private class ActionEditEnvironnement implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Edition Env");
			fenetrePrincipale.dispose();
			new MenuEnvironnement();
		}	
	
}
	private class ActionEditEvenements implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Edition Events");
			fenetrePrincipale.dispose();
			new MenuEvent();
		}	
	
}
	private class ActionJouer implements ActionListener {
		@Override
		public void actionPerformed(ActionEvent e) {
			System.out.println("Jouer");
			fenetrePrincipale.dispose();
			new ChoixEnvironnement();
		}

	}
}
