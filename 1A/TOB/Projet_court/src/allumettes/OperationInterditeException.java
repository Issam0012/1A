package allumettes;

/** Exception qui indique qu'un joueur a essayé de faire une opération interdite
 * @author	Issam Alouane
 */

public class OperationInterditeException extends RuntimeException  {
	
	// Le nom du tricheur
	public String nomTricheur;

	/** Initialiser CoupInvalideException à partir du nom du tricheur
	 * @param nom le nom du tricheur
	 */
	public OperationInterditeException(String nomTricheur) {
		super();
		this.nomTricheur = nomTricheur;
	}
	
	/** Obtenir le nom du tricheur
	 * @return nom du tricheur
	 */
	public String getNomTricheur () {
		return this.nomTricheur;
	}

}
