package allumettes;

import java.util.InputMismatchException;
import java.util.Scanner;

/** La classe qui représente le joueur humain. Cette classe devra impérativement n'utiliser qu'un seul scanner 
 * par partie
 * @author	Issam Alouane
 */

public class StrategieHumain implements Strategie {
	
	private Scanner scanner;
	
	/** Construire un joueur humain à partir de son nom et initialiser son scanner
	 * @param Nom le nom du joueur
	 */
	public StrategieHumain(String nom) {
		this.scanner = new Scanner(System.in);
	}
	
	/** Construire un joueur humain à partir de son nom et initialiser son scanner d'après un joueur déjà existant
	 * (Rappelez-vous du condition cité au début)
	 * @param Nom le nom du joueur
	 */
	public StrategieHumain(Joueur joueurHumain) {
		this.scanner = ((StrategieHumain) joueurHumain.getStrategie()).scanner;
	}
	
	/** Obtenir le nombre d'allumettes que le joueur veut tirer.
	 * @param jeu Le jeu en cours
	 */
	public int getPrise(Jeu jeu, String nom) {
		
		/** Le corps suivant demande à l'utilisateur d'entrer un chiffre, s'il entre "triche" ça va retirer une allumette
		 *  sinon on aura une exception levé où on affiche un message d'avertissement et on crée une sorte de récurrence
		 */
				
		System.out.print(nom + ", combien d'allumettes ? ");
		
		int prise = 0;
		
		try {
			prise = scanner.nextInt();
		} catch (InputMismatchException e) {
			
			if (scanner.nextLine().equals("triche")) {
				try {
					jeu.retirer(1);
				} catch (CoupInvalideException f) {
					// cette instruction ne sera jamais exécuté
					System.out.println("Opération invalide.");
				}
				System.out.println("[Une allumette en moins, plus que " + jeu.getNombreAllumettes() +". Chut !]");
			} else {
				System.out.println("Vous devez donner un entier.");
			}
			
			return this.getPrise(jeu, nom);
		}
		
		return prise;
	}
	
}