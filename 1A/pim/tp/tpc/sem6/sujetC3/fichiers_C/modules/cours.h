#ifndef DATE__H  // Garde conditionnelle : si la variable DATE__H n'existe pas 
#include "salle.h"
#include "enseignant.h"

struct cours{
	Date debut;
	Date fin;
	char* nom;
};
typedef struct cours cours;

void initialiser_cours(cours *c, salle s, enseignant e);

#endif
