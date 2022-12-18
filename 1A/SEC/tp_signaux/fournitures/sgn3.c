# include <stdio.h> /* entr  ́e es / sorties */
# include <unistd.h> /* primitives de base : fork , ...*/
# include <stdlib.h> /* exit */
# include <signal.h>
# define MAX_PAUSES 10 /* nombre d ’ attentes maximum */

void handler(int signal_num) {
    printf("\n  Processus de pid %d : J'ai reçu le signal %d\n",getpid(),signal_num) ;
    return ;
}

int main ( int argc , char * argv []) {
int nbPauses ;
nbPauses = 0;
printf (" Processus de pid % d \n " , getpid ());
for ( nbPauses = 0 ; nbPauses < MAX_PAUSES ; nbPauses ++) {

signal(SIGINT, handler) ;
signal(SIGUSR1, handler) ;
signal(SIGCONT, handler) ;

int retour = fork();
        
    if (retour == -1) {
        printf("Erreur fork");
        exit(1);    
    } else if (retour == 0) {
        int nbPauses ;
        nbPauses = 0;
        printf (" Processus fils de pid % d \n " , getpid ());
        for ( nbPauses = 0 ; nbPauses < MAX_PAUSES ; nbPauses ++) {
            pause (); // Attente d ’ un signal
            printf (" pid = % d - NbPauses = % d \n " , getpid () , nbPauses );
        }
    }
    
pause (); // Attente d ’ un signal
printf (" pid = % d - NbPauses = % d \n " , getpid () , nbPauses );
} ;
return EXIT_SUCCESS ;
}
