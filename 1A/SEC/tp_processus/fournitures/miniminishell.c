#include <stdio.h>
#include <unistd.h>
#include <stdlib.h> /* exit */
#include <sys/wait.h> 	/* wait */
#include <string.h>   /* bibliothèque string */

int main(int argc, char* argv[]) {

    int retour, ret, wstatus, fils_termine;

    char buf[30]; 		/* contient la commande saisie au clavier */

    bool sortie = false;

    Do {

        ret = scanf("\%s",buf);	/* lit et range dans buf la chaine entrée au clavier */

        retour = fork();
        
        if (retour == -1) {
            printf("Erreur fork");
            exit(1);
            
        } else if (retour == 0) {
        
            printf(">>> Entrez votre commande : \n");
    
            /* Sortir quand Ctrl + D */
            if (ret == EOF) {
                sortie = true;
            } 
            
            /* Sortir quand exit est saisie au clavier */
            if (strcmp(buf, "exit")) {
                sortie = true;
            }
            
            execlp(buf, "" ,NULL);
            
            printf("Erreur \n");

            exit(2);
            
        } else {
            fils_termine = wait(&wstatus);
            if (fils_termine < 0) { /* si le fils a mourit avant que son père fait conaissance*/
                exit(3);
            }
            if (WIFEXITED(wstatus)) {
                if (WEXITSTATUS(wstatus) == 0) {
                    printf("SUCCES ! La commande a été exécutée \n");
                } else if (WEXITSTATUS(wstatus) == 2) {
		    printf("ECHEC ! La commande n'a pas été exécutée \n");
                }
            }
        }
    } while (!sortie);

    printf("Salut !\n");

    return EXIT_SUCCESS;
}
