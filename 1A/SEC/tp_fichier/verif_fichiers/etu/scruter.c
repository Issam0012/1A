#include <stdio.h>
#include <unistd.h>
#include <stdlib.h> /* exit */
#include <sys/wait.h>
#include <string.h>
#include <fcntl.h>

int main(int argc, char *argv[]) {

    int retour, wstatus, desc_fic_pere, desc_fic_fils, entier, ecrit, lu;
    

    retour = fork() ;
    
    /* Bonne pratique : tester systématiquement le retour des appels système */
    if (retour < 0) {   /* échec du fork */
        printf("Erreur fork\n") ;
        exit(2) ;
    }

    /* fils */
    if (retour == 0) {
    
        for (int j = 0; j<3; j++) {
    
            sleep(10);
            
            desc_fic_fils = open("temp", O_RDONLY) ;
            
            if (desc_fic_fils < 0) {
                perror("Erreur ouverture du fichier temp en lecture");
                exit(1) ;
            }
            
            for (int i = 1; i<=10; i++) {
                if (read(desc_fic_fils, &lu, sizeof(int))<0) {
                    perror("Erreur lecture");
                }
                printf("le fils lit : %d \n", lu);
            }
            
            /* Placer la tête en début de fichier */
            if (lseek(desc_fic_fils, 0, SEEK_SET)<0) {
                        perror("Erreur lseek fils");
            }
            
            /* La fermeture du fichier */
            if (close(desc_fic_fils) < 0) {
                perror("Erreur lors de la fermeture du fichier ");
                exit(1);
            }
            
        }
        
        /* terminer le processus par exit */
        exit(EXIT_SUCCESS) ; 
        
    }

    /* pere */
    else {
         
        /* ouverture du fichier en écriture */
        desc_fic_pere = open("temp", O_WRONLY | O_CREAT | O_TRUNC, 0600) ;
        /* traiter systématiquement les retours d'erreur des appels */
        if (desc_fic_pere < 0) {
            perror("Erreur ouverture du fichier temp en écriture");
            exit(1) ;
        }
    
        for (entier = 1; entier<=30; entier++) {
            
            printf("le père écrit : %d \n", entier);
        
            /* Placer la tête en début de fichier tous les 10 entiers */
            if (entier % 10 == 1) {
                if (lseek(desc_fic_pere, 0, SEEK_SET)<0) {
                    perror("Erreur lseek père");
                }
            }
        
            ecrit = write(desc_fic_pere, &entier, sizeof(int)); 
            if (ecrit < 0) {
                perror("Erreur d'écriture");
            }
            
            sleep(1);
            
        }
        
        if (close(desc_fic_pere) < 0) {
            perror("Erreur lors de la fermeture du fichier ");
            exit(1);
        }
        
    }
    
    /* attendre la fin du fils */
    wait(&wstatus);

     return EXIT_SUCCESS;

}
