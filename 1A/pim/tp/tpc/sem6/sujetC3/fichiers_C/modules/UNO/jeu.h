// Garde conditionnelle pour protéger le module de la double inclusion
#ifndef JEU_H
#define JEU_H

// Inclure les interfaces carte.h et main.h
#include "carte.h"
#include "main.h"

//Définition du type jeu complet pour enregistrer NB_CARTES cartes.
typedef carte jeu[NB_CARTES];

/**
 * \brief Initialiser le jeu en ajoutant toutes les cartes possibles au jeu.
 * \param[out] le_jeu tableau de cartes avec les 4 couleurs et NB_VALEURS valeurs possibles
 */
void init_jeu(jeu le_jeu);

/**
 * \brief Afficher le jeu.
 * \param[in] le_jeu complet avec les 4 couleurs et 910valeurs possibles
 */
void afficher_jeu(jeu le_jeu);

/**
 * \brief mélange le jeu.
 * \param[in out] le_jeu complet
 */
void melanger_jeu(jeu le_jeu);

/**
 \brief Distribuer N cartes à chacun des deux joueurs, en alternant les joueurs.
 * \param[in out] le_jeu complet.
 *       Si la carte c est distribuée dans une main, c.presente devient faux.
 * \param[in] N nombre de cartes distribuées à chaque joueur.  Précondition : N <= (NB_CARTES - 1) div 2
 * \param[out] m1 main du joueur 1.
 * \param[out] m2 main du joueur 2.
 */
void distribuer_mains(jeu le_jeu, int N, t_main* m1, t_main* m2);

/**
 * \brief Piocher une carte dans le jeu et l'inclure dans la main en paramètre.
 * \param[in out] le_jeu complet avec les 4 couleurs et 10 valeurs possibles.
 *                Ce jeu est mélangé.
 *                Si la carte est inclue dans une main ou est la derniere carte jouée,
 *                Alors presente vaut faux.
 * \param[in out] main main d'un joueur
 * \return carte* un pointeur sur la carte piochee dans le_jeu en paramètre. Ce pointeur vaut NULL si aucune carte ne peut être piochée.
*/
carte * piocher(jeu le_jeu, t_main* main);

#endif
