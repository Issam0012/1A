#include <stdio.h>    /* entrées/sorties */
#include <unistd.h>   /* primitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <signal.h>   /* opérations sur les signaux */

void handler(int signal_num) {
    printf("Reception %d\n", signal_num);
    return;
}

void dormir(int duree) {
    for (int i=0; i<duree; i++) {
        sleep(1);
    }
}

int main(int argc, char *argv[]) {

    /* Déclaration et initialisation de l'ensemble des signaux */
    sigset_t ens_signaux ;
    sigemptyset(&ens_signaux) ;

    /* Associer le traiteur demandé au 2 signaux */
    signal(SIGUSR1, handler);
    signal(SIGUSR2, handler);

    /* Masquer SIGINT et SIGUSR1 */
    sigaddset(&ens_signaux, SIGINT);
    sigaddset(&ens_signaux, SIGUSR1);
    sigprocmask(SIG_BLOCK, &ens_signaux, NULL);

    dormir(10);  /* L'attente de 10 s */

    /* Envoie de 2 SIGUSR1 */
    kill(getpid(), SIGUSR1);
    kill(getpid(), SIGUSR1);

    dormir(5);   /* L'attente de 5 s */

    /* Envoie de 2 SIGUSR2 */
    kill(getpid(), SIGUSR2);
    kill(getpid(), SIGUSR2);

    /* Démasquer SIGUSR1 */
    sigemptyset(&ens_signaux);
    sigaddset(&ens_signaux, SIGUSR1);
    sigprocmask(SIG_UNBLOCK, &ens_signaux, NULL);

    dormir(10);  /* L'attente de 10 s */

    /* Démasquer SIGINT*/
    sigemptyset(&ens_signaux);
    sigaddset(&ens_signaux, SIGINT);
    sigprocmask(SIG_UNBLOCK, &ens_signaux, NULL);

    printf("Salut ! \n");

    return EXIT_SUCCESS;
}
