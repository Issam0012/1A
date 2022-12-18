package controleur;

import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;

public class deplacement implements KeyListener {

	public boolean haut, bas, gauche, droite;
	public Partie partie;

	public deplacement(Partie partie) {
		this.partie = partie;
	}
	
	@Override
	public void keyPressed(KeyEvent e) {
		int touche = e.getKeyCode();
		
		if(touche == KeyEvent.VK_Z) {
			haut = true;
		}
		
		if(touche == KeyEvent.VK_Q) {
			gauche = true;
		}

		if(touche == KeyEvent.VK_S) {
			bas = true;
		}

		if(touche == KeyEvent.VK_D) {
			droite = true;
		}
	}

	@Override
	public void keyReleased(KeyEvent e) {
		int touche = e.getKeyCode();
		
		if(touche == KeyEvent.VK_Z) {
			haut = false;
		}
		
		if(touche == KeyEvent.VK_Q) {
			gauche = false;
		}

		if(touche == KeyEvent.VK_S) {
			bas = false;
		}

		if(touche == KeyEvent.VK_D) {
			droite = false;
		}
	}	
	@Override
	public void keyTyped(KeyEvent e) {
	}

}
