package modele;

import modele.Personnage;
import modele.Race;

public class Ennemi extends Personnage{

    /**
     * Le constructeur
     *
     * @param nom
     * @param race
     * @param description
     */
    public Ennemi() {
        super("nom aléatoire", new RaceHumain(), "description aléatoire");
    }
}
