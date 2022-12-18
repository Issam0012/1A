#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* pimitives de base : fork, ...*/
#include <stdlib.h>   /* exit */
#include <sys/wait.h> /* wait */
#include <string.h>   /* opérations sur les chaines */
#include <signal.h>

int main()
{
    int retour ;

    int pipe_f2p[2] ;    /* pipe pour communiquer depuis les fils vers le père* */

    retour = pipe(pipe_f2p) ;
    /* Bonne pratique : tester systématiquement le retour des appels système */
    if (retour == -1) {   /* échec du pipe */
         printf("Erreur pipe\n") ;
        /* Convention : s'arrêter avec une valeur > 0 en cas d'erreur */
        exit(1) ;
    }

    retour = fork() ;
    if (retour < 0) {   /* échec du fork */
        printf("Erreur fork\n") ;
        /* Convention : s'arrêter avec une valeur > 0 en cas d'erreur */
        exit(1) ;
    }
    
    /* fils */
    if (retour == 0) {
        
        if (close(pipe_f2p[1])<0){
            perror("Erreur de fermeture");
            exit(2);
        }
        
        int entier, val_read;
        do {
            val_read = read(pipe_f2p[0], &entier, sizeof(int));
            printf("la valeur de read est : %d,, et l'entier est : %d \n", val_read, entier);
        } while (val_read>0);
        
        printf("Sortie de la boucle \n");
        
        if (close(pipe_f2p[0])<0){
            perror("Erreur de fermeture");
            exit(2);
        }

        exit(EXIT_SUCCESS) ;   /* Terminaison normale (0 = sans erreur) */
    } else {
    
        if (close(pipe_f2p[0])<0){
            perror("Erreur de fermeture");
            exit(2);
        }
        
        int entier;
        for (int i = 1; i<=20;i++) {
            entier = i;
            if (write(pipe_f2p[1], &entier, sizeof(int))<0){
                perror("Erreur d'écriture");
                exit(3);
            }

        }

        if (close(pipe_f2p[1])<0){
            perror("Erreur de fermeture");
            exit(2);
        }
    
        sleep(1);
        
    }

    return EXIT_SUCCESS ;
}
