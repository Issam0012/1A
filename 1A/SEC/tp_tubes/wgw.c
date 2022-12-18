#include <stdio.h>
#include <unistd.h>
#include <stdlib.h> /* exit */
#include <sys/wait.h> 	/* wait */
#include <string.h>   /* bibliothèque string */

int main(int argc, char* argv[]) {
    
    int retour;

    if (argc != 2) {
        perror("Entrée invalide \n");
        exit(1);
    }

    int pipe1[2];
    int pipe2[2];
    
    if (pipe(pipe1) < 0) {
        perror("Erreur pipe \n");
        exit(2);
    }

    retour = fork();
    
    if (retour == -1) {
        perror("Erreur fork \n");
        exit(3);
        
    } else if (retour == 0) {
    
        close(pipe1[0]);
        
        if (dup2(pipe1[1],1)<0) {
            perror("Erreur dup2 \n");
            exit(4);
        }
        
        close(pipe1[1]);
        
        if (pipe(pipe2) < 0) {
            perror("Erreur pipe \n");
            exit(2);
        }
        
        retour = fork();
    
            if (retour == -1) {
            
                perror("Erreur fork \n");
                
                exit(3);
                
            } else if (retour == 0) {
            
                close(pipe2[0]);
                
                if (dup2(pipe2[1],1)<0) {
                    perror("Erreur dup2 \n");
                    exit(4);
                }
                
                close(pipe2[1]);
        
                execlp("who", "" ,NULL);

                exit(2);
            
            } else {
            
                close(pipe2[1]);
                
                if (dup2(pipe2[0],0)<0) {
                    perror("Erreur dup2 \n");
                    exit(4);
                }
                
                close(pipe2[0]);
        
                execlp("grep", "", argv[1] ,NULL);

                exit(2);
            
            }
        
    } else {
    
        close(pipe1[1]);
        
        if (dup2(pipe1[0],0)<0) {
            perror("Erreur dup2 \n");
            exit(4);
        }
        
        close(pipe1[0]);
        
        execlp("wc", "", "-l" ,NULL);

	    exit(2);
	
    }

    return EXIT_SUCCESS;
}
