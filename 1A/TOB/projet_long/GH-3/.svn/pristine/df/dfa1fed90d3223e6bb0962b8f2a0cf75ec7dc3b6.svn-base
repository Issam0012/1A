package vue.personnage;

import modele.Personnage;

import javax.swing.*;
import java.awt.*;

public class PanelPerso extends JPanel {

    private final Personnage personnage;
    public PanelPerso(Personnage p){
        String Nom = p.getNom();
        String Race = p.getRace().getRace();

        // Carte Perso

        this.setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
        //bordure jolie
        this.setBorder(BorderFactory.createEmptyBorder(55, 55, 55, 55));

        JLabel JNom = new JLabel(Nom, JLabel.CENTER);
        JLabel JRace = new JLabel(Race,JLabel.CENTER);

        JNom.setAlignmentX(JLabel.CENTER_ALIGNMENT);
        JRace.setAlignmentX(JLabel.CENTER_ALIGNMENT);

        this.add(Box.createRigidArea(new Dimension(10, 10)));
        this.add(JNom);
        this.add(Box.createRigidArea(new Dimension(20, 20)));
        this.add(JRace);
        this.setBorder(BorderFactory.createLineBorder(Color.black));
        this.setPreferredSize(new Dimension(80, 120));
        this.personnage = p;

    }


    public Personnage getPersonnage() {
        return personnage;
    }
}
