// Garde conditionnelle pour protéger le module de la double inclusion
#ifndef SALLE_H
#define SALLE_H

#include "date.h"

struct salle {
	char *nom;
	char *batiment;
};
typedef struct salle salle;

#endif
