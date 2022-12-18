#include <stdio.h>    /* entrées/sorties */
#include <unistd.h>   /* primitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <signal.h>   /* opérations sur les signaux */

void handler(int signal_num) {
    printf("Reception %d\n", signal_num);
}

int main(int argc, char *argv[]) {
    
    int pid;

    /* Déclaration et initialisation de l'ensemble des signaux */
    sigset_t ens_signaux ;
    sigemptyset(&ens_signaux) ;

    /* Associer le traiteur demandé au 2 signaux */
    signal(SIGUSR1, handler);
    signal(SIGUSR2, handler);

    /* Masquer SIGINT et SIGUSR1 */
    sigaddset(ens_signaux, SIGINT);
    sigaddset(ens_signaux, SIGUSR1);
    sigprocmask(SIG_BLOCK, &ens_signaux, NULL);

    sleep(10);  /* L'attente de 10 s */

    /* Envoie de 2 SIGUSR1 */
    pid = getpid();
    kill -SIGUSR1 pid;
    kill -SIGUSR1 pid;

    sleep(5);   /* L'attente de 5 s */

    /* Envoie de 2 SIGUSR2 */
    pid = getpid();
    kill -SIGUSR2 pid;
    kill -SIGUSR2 pid;

    /* Démasquer SIGUSR1 */
    sigemptyset(&ens_signaux);
    sigaddset(ens_signaux, SIGUSR1);
    sigprocmask(SIG_UNBLOCK, &ens_signaux, NULL);

    sleep(10);  /* L'attente de 10 s */

    /* Démasquer SIGINT*/
    sigemptyset(&ens_signaux);
    sigaddset(ens_signaux, SIGINT);
    sigprocmask(SIG_UNBLOCK, &ens_signaux, NULL);

    printf("Salut !");

    return EXIT_SUCCESS;
}