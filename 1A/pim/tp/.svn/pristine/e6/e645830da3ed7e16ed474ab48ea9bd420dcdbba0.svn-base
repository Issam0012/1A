#include <stdlib.h> 
#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#define taille_porte_monnaie 5

// Definition du type monnaie
struct t_monnaie {
    float val;
    char dev;
};

typedef struct t_monnaie t_monnaie;

/*
 * \brief Initialiser une monnaie 
 * \param: valeur: in float, devise: in character, monnaie: in out t_monnaie
 * \pre : valeur >= 0
*/
void initialiser(t_monnaie* monnaie, float valeur, char devise){
    assert(valeur>=0);
    monnaie->dev = devise;
    monnaie->val = valeur;
}


/**
 * \brief Ajouter une monnaie m2 à une monnaie m1 
 * \param: m1: in t_monnaie, m2: in out t_monnaie
*/
bool ajouter(t_monnaie* m1, t_monnaie* m2){
    if (m1->dev=m2->dev){
        m2->val = m2->val+m1->val;
        return true;
    } else {
        return false;
    }
}


/**
 * \brief Tester Initialiser 
 * \param: valeur: in float, devise: in character, monnaie: in t_monnaie
 */ 
void tester_initialiser(t_monnaie m, float valeur, char devise){
    assert(m.val==valeur);
    assert(m.dev==devise);
}

/**
 * \brief Tester Ajouter 
 * \param: m1: in t_monnaie, m2: in t_monnaie, valeur_m2_old: in integer
 */ 
void tester_ajouter(t_monnaie m1, t_monnaie m2, int valeur_m2_old){
    if (m1.dev=m2.dev){
        assert(ajouter(&m1, &m2));
        assert(m2.val=m1.val+valeur_m2_old);
    } else {
        assert(ajouter(&m1, &m2)==false);
    }
}



int main(void){
    // Un tableau de 5 monnaies
    t_monnaie porte_monnaie[taille_porte_monnaie];

    //Initialiser les monnaies
    float valeur;
    char devise;
    for (int i=0;i<5;i++){    //à chaque itération on demande les paramètres au utilisateur et on les stocke et on vérifie qu'ils sont bien stockés
        printf("Entrer les paramètres souhaités (valeur + devise) : ");
        scanf("%f %c", &valeur, &devise);
        initialiser(&porte_monnaie[i], valeur, devise);
        tester_initialiser(porte_monnaie[i], valeur, devise);
        }
     
    // Afficher la somme des toutes les monnaies qui sont dans une devise entrée par l'utilisateur.
    printf("Entrez la devise souhaitée : ");
    scanf(" %c", &devise);
    int indice=0; //la variable qui va stocker l'indice de la première monnaie dont sa devise est a devise souhaitée
    
    for (int i=0;i<5;i++){
        if (porte_monnaie[i].dev==devise){
            indice = i;
            break;
        }
    }
    
    for (int i=indice+1; i<5; i++){
        if (porte_monnaie[i].dev==devise){  //on cherche les monnaies au devise demandée, on ajoute ses valeurs au monnaie d'indice incdice, et on stocke le résultat dans la monnaie d'indice indice
            valeur=porte_monnaie[indice].val;                      //et on vérifie que l'opération d'addition s'était bien fait
            ajouter(&porte_monnaie[i],&porte_monnaie[indice]);
            tester_ajouter(porte_monnaie[i], porte_monnaie[indice], valeur);
        }
    }  
    printf("%1.2f\n", porte_monnaie[indice].val);

    return EXIT_SUCCESS;
}
