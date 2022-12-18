#include <stdio.h>
#include <unistd.h>
#include <stdlib.h> /* exit */
#include <stdbool.h>
#include "liste.h"

void Initialiser(pListe *liste) {
    liste->taille = 0;
}

void Ajouter(pListe *liste, int idpro, pid_t pid, char* etat, char* commande) {

    int n = liste->taille;
    
    liste->Liste = realloc(liste->Liste, (liste->taille + 1) * sizeof(struct pCase));
    
    liste->Liste[n].idprocessus = idpro;
    liste->Liste[n].pid = pid;
    liste->Liste[n].etat = etat;
    liste->Liste[n].commande = commande;

    liste->taille = liste->taille + 1;
    
}

int indice(pListe *liste, pid_t pid){
    
    int indice = 0;
    
    while (liste->Liste[indice].pid != pid) {
        indice++;
    }
    
    return indice;
    
}

int indice_id(pListe *liste, int id_processus) {

    int indice;

    for (int i=0; i<liste->taille; i++) {
        if (liste->Liste[i].idprocessus == id_processus) {
            indice = i;
            break;
        }
    }
    
    return indice;

}

bool existe(pListe *liste, int idpro) {
    
    bool existe = false;
    
    for (int i=0; i<liste->taille; i++) {
        if (liste->Liste[i].idprocessus == idpro) {
            existe = true;
            break;
        }
    }
    
    return existe;
}

void Supprimer(pListe *liste, pid_t pid) {
    
    for (int i = indice(liste, pid); i<liste->taille - 1; i++) {
        liste->Liste[i] = liste->Liste[i+1];
    }
    
    liste->taille = liste->taille - 1;
    
    liste->Liste = realloc(liste->Liste, liste->taille * sizeof(struct pCase));
    
}

void Afficher(pListe *liste) {

    printf("id            pid             etat               commande \n");  
    
    for (int i = 0; i<liste->taille; i++) {
        printf("%d            %d            %s           %s \n",liste->Liste[i].idprocessus, liste->Liste[i].pid, liste->Liste[i].etat, liste->Liste[i].commande);
    }
    
}

void changerEtat(pListe *liste, int indice, char* newEtat) {

    liste->Liste[indice].etat = newEtat;

}
