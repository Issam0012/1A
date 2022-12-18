package allumettes;

/** Lance une partie des 13 allumettes en fonction des arguments fournis
 * sur la ligne de commande.
 * @author	Xavier Crégut
 * @version	$Revision: 1.5 $
 */
public class Jouer {

	/** Lancer une partie. En argument sont donnés les deux joueurs sous
	 * la forme nom@stratégie.
	 * @param args la description des deux joueurs
	 */
	public static void main(String[] args) {

		try {
			
			verifierArguments(args);
			
			int indiceDebut = 0;                // L'indice du début des informations sur les joueurs
			boolean modeArbitre = false;
			
			int nbJoueurs = 2;
			if (args.length==nbJoueurs + 1) {
				modeArbitre = true;
				indiceDebut = 1;
			}
			
			jeuAllumettes jeu= new jeuAllumettes(13, modeArbitre);
			
			String donneesJoueur1 = args[indiceDebut];
			String donneesJoueur2 = args[indiceDebut+1];
			
			Joueur joueur_1 = creerJoueur(donneesJoueur1);
			Joueur joueur_2 = creerJoueur(donneesJoueur2);
			
			if (joueur_1.estHumain() && joueur_2.estHumain()) {
				joueur_2 = new Joueur(joueur_2.getNom(), new StrategieHumain(joueur_1));
			}
				
			Arbitre arbitre = new Arbitre(joueur_1, joueur_2);
			arbitre.arbitrer(jeu);
			
			

		} catch (ConfigurationException e) {
			System.out.println();
			System.out.println("Erreur : " + e.getMessage());
			afficherUsage();
			System.exit(1);
		}
		
		
	}
	
	private static Joueur creerJoueur(String donneesJoueur) throws ConfigurationException {
		
		String[] joueurSplit = donneesJoueur.split("@");
		
		if (joueurSplit.length != 2 ) {
			throw new ConfigurationException(" Format invalide ");
		}
		
		Joueur joueur = null;
		if (joueurSplit[1].equals("humain")) {
			joueur = new Joueur(joueurSplit[0], new StrategieHumain(joueurSplit[0]));
		} else if (joueurSplit[1].equals("expert")) {
			joueur = new Joueur(joueurSplit[0], new StrategieExpert());
		} else if (joueurSplit[1].equals("rapide")) {
			joueur = new Joueur(joueurSplit[0], new StrategieRapide());
		} else if (joueurSplit[1].equals("naïf")) {
			joueur = new Joueur(joueurSplit[0], new StrategieNaïf());
		} else if (joueurSplit[1].equals("tricheur")) {
			joueur = new Joueur(joueurSplit[0], new StrategieTricheur());
		} else {
			throw new ConfigurationException(" Stratégie invalide ");
	}
		
		return joueur;
	}

	private static void verifierArguments(String[] args) throws ConfigurationException {
		
		final int nbJoueurs = 2;
		
		if (args.length < nbJoueurs) {
			throw new ConfigurationException("Trop peu d'arguments : "
					+ args.length);
		}
		
		if (args.length > nbJoueurs + 1) {
			throw new ConfigurationException("Trop d'arguments : "
					+ args.length);
		}
		
		if (args.length == nbJoueurs + 1) {
			if (!args[0].equals("-confiant")) {
				throw new ConfigurationException("Vous n'avez droit qu'à l'option '-confiant' ");
			}
		}
	}

	/** Afficher des indications sur la manière d'exécuter cette classe. */
	public static void afficherUsage() {
		System.out.println("\n" + "Usage :"
				+ "\n\t" + "java allumettes.Jouer joueur1 joueur2"
				+ "\n\t\t" + "joueur est de la forme nom@stratégie"
				+ "\n\t\t" + "strategie = naif | rapide | expert | humain | tricheur"
				+ "\n"
				+ "\n\t" + "Exemple :"
				+ "\n\t" + "	java allumettes.Jouer Xavier@humain "
					   + "Ordinateur@naif"
				+ "\n"
				);
	}

}
