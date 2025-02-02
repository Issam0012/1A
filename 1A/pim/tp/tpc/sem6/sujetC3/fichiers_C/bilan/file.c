/**
 *  \author Xavier Cr�gut <nom@n7.fr>
 *  \file file.c
 *
 *  Objectif :
 *	Implantation des op�rations de la file
*/

#include <malloc.h>
#include <assert.h>

#include "file.h"


void initialiser(File *f)
{
    
    f->tete = NULL;
    
    f->queue = NULL;

    assert(est_vide(*f));
}


void detruire(File *f)
{
    free(f->tete);
    
    f->tete = NULL;
}


char tete(File f)
{
    assert(! est_vide(f));

    return (f.tete -> valeur);
}


bool est_vide(File f)
{

    return (f.tete == NULL && f.queue == NULL);
    
}

/**
 * Obtenir une nouvelle cellule allou�e dynamiquement
 * initialis�e avec la valeur et la cellule suivante pr�cis� en param�tre.
 */
static Cellule * cellule(char valeur, Cellule *suivante)
{
    Cellule* file = malloc(sizeof(char)+sizeof(suivante));
    
    file -> valeur = valeur;
    
    file -> suivante = suivante;
    
    return file;
}


void inserer(File *f, char v)
{
    assert(f != NULL);
    
    if (f->tete == NULL) {
    
        f->tete = cellule(v,NULL);
        
        f->queue = f->tete;
        
    } else {
    
        f->queue->suivante = cellule(v,NULL);
        
        f->queue = f->queue->suivante;
        
    }

}

void extraire(File *f, char *v)
{
    assert(f != NULL && !est_vide(*f));
    
    *v = (f->tete)->valeur;
    
    Cellule *suivante = (f->tete)->suivante;
    
    free(f->tete);
    
    f->tete = NULL;
    
    f->tete = suivante;
    
}


int longueur(File f)
{
    if (f.tete == NULL){
    
        return 0;
    
    } else {
    
        File f1;
    
        f1.tete = f.tete->suivante;
    
        return 1 + longueur(f1);
    
    }
}
