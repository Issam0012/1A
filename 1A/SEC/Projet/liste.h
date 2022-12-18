#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>  
#include <stdbool.h>

struct pCase{
    int idprocessus;
    pid_t pid;
    char* etat;
    char* commande;
    };
    
typedef struct pCase *pliste;

typedef struct pListe{
    int taille;
    pliste Liste;
} pListe;

/** Initialiser une liste vide
IN : liste = la liste à initialiser
 */
void Initialiser(pListe *liste);

/** calculer la taille d'une liste
IN : liste = la liste qu'on veut calculer la taille
OUT : int taille de la liste
 */
int taille(pListe *liste);
 
/** Ajouter un élément dans la liste
IN : liste = la liste où on veut ajouter l'élément
IN : idpro = l'identifiant de l'élément
IN : pid = le pid de l'élément
IN : etat = l'état de l'élement
IN : commande = la commande de l'élément
 */
void Ajouter(pListe *liste, int idpro, pid_t pid, char* etat, char* commande);

/** tester si un identifiant appartient à une liste
IN : liste = la liste
IN : idpro = l'identifiant de test
OUT : bool l'identifiant existe ou pas
*/
bool existe(pListe *liste, int idpro);

/** L'indice d'un pid donné dans une liste
IN : liste = la liste
IN : pid = le pid qu'on veut savoir l'indice
OUT : int l'indice du pid donné dans la liste
*/
int indice(pListe *liste, pid_t pid);

/** L'indice d'un identifiant donné dans une liste
IN : liste = la liste
IN : id_processus = l'identifiant qu'on veut savoir l'indice
OUT : int l'indice de l'identifiant donné dans la liste
*/
int indice_id(pListe *liste, int id_processus);

/** Supprimer un élément d'une liste à partir de son pid
IN : liste = la liste
IN : pid = le pid en question
*/
void Supprimer(pListe *liste, pid_t pid);

/** Afficher une liste donnée
IN : liste = la liste en question
*/
void Afficher(pListe *liste);

/** Changer l'état d'un élément dans une liste à partir de son indice
IN : liste = la liste en question
IN : indice = l'indice de l'élément en question
IN : newEtat = le nouveau etat de l'élément
*/
void changerEtat(pListe *liste, int indice, char* newEtat);
