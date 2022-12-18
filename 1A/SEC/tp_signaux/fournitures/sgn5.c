# include <stdio.h> /* entr  ́e es / sorties */
# include <unistd.h> /* primitives de base : fork , ...*/
# include <stdlib.h> /* exit */
# include <signal.h>
# define MAX_PAUSES 10 /* nombre d ’ attentes maximum */

void handler(int signal_num) {
    printf("\n  Processus de pid %d : J'ai reçu le signal %d\n",getpid(),signal_num) ;
    return ;
}

void handler_alrm(int signal_num) {
    printf("\n pid du processus père : %d \n", getpid());
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
signal(SIGALRM, handler_alrm);

alarm(5);
    
pause (); // Attente d ’ un signal
printf (" pid = % d - NbPauses = % d \n " , getpid () , nbPauses );
} ;
return EXIT_SUCCESS ;
}
