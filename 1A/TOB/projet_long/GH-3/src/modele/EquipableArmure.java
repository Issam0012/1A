package modele;

public class EquipableArmure extends Equipable{
	
	public EquipableArmure(String nom, String description) {
		super(nom, description);
	}

	public EquipableArmure(String nom, String desc, Statistiques statsEquipable) {
		super(nom, desc, statsEquipable);
	}
}
