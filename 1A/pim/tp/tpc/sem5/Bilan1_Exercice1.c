/** Squelette du programme **/
/*********************************************************************
 *  Auteur  : Issam Alouane
 *  Version : 1
 *  Objectif : Conversion pouces/centimètres
 ********************************************************************/

#include <stdio.h>
#include <stdlib.h>

int main()
{
    const float UN_POUCE = 2.54;
    float valeur;
    char unite;
    float lg_cm;
    float lg_p;
    
    /* Saisir la longueur */
    printf("Entrer une longueur (valur + unité) : ");
    scanf("%f %c", &valeur, &unite);

    /* Calculer la longueur en pouces et en centimètres */
    switch(unite){
        case 'p':
        case 'P':
            lg_p = valeur;
            lg_cm = lg_p * UN_POUCE;
            break;
        case 'c':
        case 'C':
            lg_cm=valeur;
            lg_p=lg_cm/UN_POUCE;
            break;
        case 'm':
        case 'M':
            lg_cm=valeur * 100;
            lg_p=lg_cm/UN_POUCE;
            break;
        default:
            lg_p=0.0;
            lg_cm=0.0;
    }

    /* Afficher la longueur en pouces et en centimètres */
    printf("%1.2f p = %1.2f cm \n", lg_p, lg_cm);

    return EXIT_SUCCESS;
}
