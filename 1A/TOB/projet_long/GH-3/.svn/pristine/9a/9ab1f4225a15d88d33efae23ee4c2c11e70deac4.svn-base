package controleur;

import modele.Ennemi;
import modele.*;

import java.awt.*;
import java.util.ArrayList;
import java.util.Random;

public class Partie {


        private ArrayList<Joueur> Joueurs = new ArrayList<Joueur>();
        private Plateau env;

        private ArrayList<Ennemi> Ennemis = new ArrayList<Ennemi>();

        private ArrayList<Objet> Objets = new ArrayList<Objet>();
        private static final int RATIO_ENNEMI = 10;
        private static final int RATIO_OBJET = 15;
        //private int nombreTours = 0;


    public Partie(){

    }
    public Partie(ArrayList<Personnage> Personnages, Plateau env) {

        // création Joueurs et couleurs
       for (int i = 0; i < Personnages.size(); i++){
            Color c = new Color((int)((i+1)/(Personnages.size()+1) * 0x1000000));

            this.Joueurs.add(new Joueur(Personnages.get(i), c));
        }

        this.env = env;


        int surface = env.getHauteur()*env.getLargeur();

        // tirage aléatoire ennemis
        int nombreEnnemis = surface/RATIO_ENNEMI;
        for(int i = 0; i < nombreEnnemis; i++){
            Ennemi e = new Ennemi();
            Random r = new Random();
            e.setPosition(r.nextInt(env.getLargeur()), r.nextInt(env.getHauteur()));
            Ennemis.add(e);

        }
        //tirage aléatoire objets
        int nombreObjets = surface/RATIO_OBJET;
        for(int i = 0; i < nombreObjets; i++){
            Objet o = new Objet("nom aléatoire", "description aléatoire");

            //set random position ?

            Objets.add(o);
        }


    }

    public int getNombreJoueurs(){
        return this.Joueurs.size();
    }

    public Personnage getPersonnageFromCouleur(Color col){
        Personnage p = null;
        for (Joueur j : this.Joueurs){
            if (j.getCouleur() == col){
                p = j.getPersonnage();
            }
        }
        return p;

        //exception si non trouvé ?

    }

    public void setEnv(Plateau env){
        this.env = env;
    }
    
    public Plateau getEnv() {
    	return env;
    }

    public void setJoueurs(ArrayList<Joueur> joueurs){
        this.Joueurs = joueurs;
    }

    public ArrayList<Joueur> getJoueurs() {
    	return this.Joueurs;
    }


}
