package modele;

public class EquipableTete extends Equipable {
	
	public EquipableTete(String nom, String description) {
		super(nom, description);
	}
	
	public EquipableTete(String nom, String desc, Statistiques statsEquipable) {
		super(nom, desc, statsEquipable);
	}
	
}
