/* version 0.2.2 (PM, 16/5/22) :
	Le serveur de conversation
	- crée un tube (fifo) d'écoute (avec un nom fixe : ./ecoute)
	- gère un maximum de maxParticipants conversations : attente (select) sur
		* tube d'écoute : accepter le(s) nouveau(x) participant(s) si possible
			-> initialiser et ouvrir les tubes de service (entrée/sortie) fournis
		* tubes (fifo) de service en entrée -> diffuser sur les tubes de service en sortie
	- détecte les déconnexions lors du select
	- se termine lorsqu'un client de pseudo "fin" se connecte
	Protocole
	- suppose que les clients ont créé les tubes d'entrée/sortie avant la demande de connexion,
		et que ces tubes sont nommés par le nom du client, suffixé par _C2S/_S2C.
	- les échanges par les tubes se font par blocs de taille fixe, dans l'idée d'éviter
	  le mode non bloquant
*/

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>

#include <stdbool.h>
#include <sys/stat.h>

#define MAXPARTICIPANTS 5		/* seuil au delà duquel la prise en compte de nouvelles
								 						 	   connexions sera différée */
#define TAILLE_MSG 128			/* nb caractères message complet (nom+texte) */
#define TAILLE_NOM 25			/* nombre de caractères d'un pseudo */
#define NBDESC FD_SETSIZE-1		/* pour le select (macros non definies si >= FD_SETSIZE) */
#define TAILLE_RECEPTION 512	/* capacité du tampon de messages reçus */

typedef struct ptp { 			/* descripteur de participant */
    bool actif; /* indique si le descripteur correspond à un client effectivement connecté */
    char nom [TAILLE_NOM];
    int in;		/* tube d'entrée (C2S) */
    int out;	/* tube de sortie (S2C) */
} participant;


participant participants [MAXPARTICIPANTS];

char buf[TAILLE_RECEPTION]; 	/* tampon de messages reçus/à rediffuser */
int nbactifs = 0;				/* nombre de clients effectivement connectés */

void effacer(int i) { /* efface le descripteur pour le participant i */
    participants[i].actif = false;
    bzero(participants[i].nom, TAILLE_NOM);
    participants[i].in = -1;
    participants[i].out = -1;
}


void ajouter(char *dep) { // traite la demande de connexion du pseudo référencé par dep
/*  (**** à faire ****) 
	Si le participant est "fin", termine le serveur (et gère la terminaison proprement)
	Sinon, ajoute un participant actif, de pseudo référencé par dep
*/
    if (strcmp(dep,"fin")==0) {
        exit(EXIT_SUCCESS);
    } else {
        participants[nbactifs].actif = true;
        strcpy(participants[nbactifs].nom, dep);
        
        char tubeC2S [strlen(dep)+5];
        char tubeS2C [strlen(dep)+5];
        
        strcpy(tubeC2S, "./");
        strcpy(tubeC2S+2, dep);
        strcpy(tubeC2S+strlen(dep)+2,"_C2S");
        participants[nbactifs].in = open(tubeC2S,O_RDONLY);
        
        strcpy(tubeC2S, "./");
        strcpy(tubeC2S+2, dep);
        strcpy(tubeC2S+strlen(dep)+2,"_S2C");
        participants[nbactifs].out = open(tubeS2C,O_WRONLY, 0666);
        
        nbactifs++;
    }
}

void desactiver (int p) {
/*  (**** à faire ****) traitement d'un participant déconnecté */
    nbactifs--;
    printf("%s quitte la conversation \n", participants[p].nom);
    close(participants[p].in);
    close(participants[p].out);
    effacer(p);
}

void diffuser(char *dep) { 
/* (**** à faire ****) envoi du message référencé par dep à tous les actifs */
    for (int i=0; i<MAXPARTICIPANTS; i++) {
        if (participants[nbactifs].actif == true) {
            if (write(participants[i].out, dep, strlen(dep)*sizeof(char))<0) {
                printf("Erreur write \n");
                exit(1);
            }
        }
    }
}

int main (int argc, char *argv[]) {
    int i,nlus,res;
    int ecoute;				/* descripteur d'écoute */
    fd_set readfds; 		/* ensemble de descripteurs écoutés par le select */
	char pseudonyme[TAILLE_NOM];

    /* création (puis ouverture) du tube d'écoute */
    mkfifo("./ecoute",S_IRUSR|S_IWUSR); // mmnémoniques sys/stat.h: S_IRUSR|S_IWUSR = 0600
    ecoute=open("./ecoute",O_RDONLY);

    FD_ZERO(&readfds);
    FD_SET(ecoute, &readfds);
    
    for (i=0; i< MAXPARTICIPANTS; i++) {
        effacer(i);
    }
    
	/* (**** à faire [éventuellement] ****) : autres initialisations */
    while (true) {
        printf("participants actifs : %d\n",nbactifs);
	/* (**** à faire ****) : boucle du serveur : traiter les requêtes en attente 
				 * 	sur le tube d'écoute : ajouter de nouveaux participants 
				 	(tant qu'il y a moins de MAXPARTICIPANTS actifs)
				 * 	sur les tubes d'entrée : lire les messages, et les diffuser.
		   			Note : 
		   			- tous les messages comportent TAILLE_MSG caractères, et les tailles sont
		   			  fixées pour qu'il n'y ait pas de message tronqué, pour simplifier la gestion. 
		   			- un tampon peut contenir plusieurs messages (et prochainMessage est destiné
				  	  à repérer le prochain message du tampon du tube c2s à diffuser)
					- Enfin, on ne traite pas plus de TAILLE_RECEPTION/TAILLE_MSG*sizeof(char)
					  à chaque itération.
    				- dans le cas où la terminaison d'un participant est détectée, gérer sa déconnexion
    				- Attention : le serveur doit fonctionner même lorsqu'aucun client n'est
    				 connecté (de nouveaux clients peuvent se connecter à tout moment)
	*/
	    res = select(FD_SETSIZE, &readfds, NULL, NULL, NULL);
	    if (res == -1) {
	        printf("Erreur Select \n");
	        exit(2);
	    } else if (res > 0) {
	        /* lire le descripteur prêt */
            if (FD_ISSET(ecoute, &readfds)) {
            
                bzero(pseudonyme,TAILLE_NOM);
                if (nbactifs < MAXPARTICIPANTS) {
                    if (read(ecoute, pseudonyme, TAILLE_NOM) < 0) {
                        perror("Erreur read \n");
                        exit(4);
                    } else {
                        if (strcmp(pseudonyme, "fin") == 0) {
                            bzero(buf,TAILLE_MSG);
                            const char * message = "[SERVEUR] Fermeture du serveur.\n"; 
                            strncpy(buf,message,TAILLE_RECEPTION);
                            diffuser(buf);
                            printf("Conversation terminée.\n");
                            exit(0);
                        } else {
                            ajouter(pseudonyme);
                        }
                    }
                } else {
                    printf("Le serveur est déjà plein.\n");
                }
                
            }
            for (nlus=0; nlus<MAXPARTICIPANTS; nlus++) {
                if (FD_ISSET(participants[nlus].in, &readfds)) {
                    bzero(buf, TAILLE_MSG);
                    if (read(participants[nlus].in, buf, TAILLE_MSG)<0) {
                        printf("Erreur lecture \n");
                        exit(3);
                    }
                    diffuser(buf);
                }
            }
            
	    }
	}
	/*nettoyage */
	close(ecoute);
    unlink("./ecoute");
    exit(EXIT_SUCCESS);
	    
}
