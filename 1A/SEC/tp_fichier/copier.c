#include <stdio.h>
#include <unistd.h>
#include <stdlib.h> /* exit */
#include <sys/wait.h>
#include <string.h>
#include <fcntl.h>

int main(int argc, char *argv[]) {

    int BUFSIZE, desc_fic_orig, desc_fic_des, taille_lue;
    char *fichier_original, *fichier_destination;
    
    BUFSIZE = 8;       /* taille de buffer de lecture */
    char buffer[BUFSIZE] ;     /* buffer de lecture */
    
    bzero(buffer, sizeof(buffer)) ;
    
    fichier_original = argv[1];
    fichier_destination = argv[2];
    
    /* ouverture du fichier en lecture */
    desc_fic_orig = open(fichier_original, O_RDONLY) ;
    /* traiter systématiquement les retours d'erreur des appels */
    if (desc_fic_orig < 0) {
        printf("Erreur ouverture du fichier original %s\n", fichier_original) ;
        exit(1) ;
    }
    
    /* ouverture du fichier en écriture */
    desc_fic_des = open(fichier_destination, O_WRONLY | O_CREAT | O_TRUNC, 0600) ;
    /* traiter systématiquement les retours d'erreur des appels */
    if (desc_fic_des < 0) {
        printf("Erreur ouverture du fichier destination %s\n", fichier_destination) ;
        exit(2) ;
    }
    
    do {
        
        taille_lue = read(desc_fic_orig, buffer, sizeof(buffer));
        
        write(desc_fic_des, buffer, taille_lue);
        
        bzero(buffer, sizeof(buffer));
            
        } while (taille_lue>0);
    
            
    close(desc_fic_orig);
    close(desc_fic_des);
    
    
    return EXIT_SUCCESS;
}
