#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/wait.h>

void garnir(char zone[], int lg, char motif) {
	int ind;
	for (ind=0; ind<lg; ind++) {
		zone[ind] = motif ;
	}
}

void lister(char zone[], int lg) {
	int ind;
	for (ind=0; ind<lg; ind++) {
		printf("%c",zone[ind]);
	}
	printf("\n");
}

int main(int argc,char *argv[]) {

    int desc_fic_des, taillepage, file, retour, wstatus;

	taillepage = sysconf(_SC_PAGESIZE);
	
	char* base;
	char buffer[taillepage] ;
    bzero(buffer, sizeof(buffer)) ;
    
    /* ouverture du fichier en écriture */
    file = open("fichier", O_RDWR | O_CREAT | O_TRUNC, 0644) ;
    /* traiter systématiquement les retours d'erreur des appels */
    if (file < 0) {
        perror("Erreur ouverture du fichier\n") ;
        exit(2) ;
    }
    
    garnir(buffer, taillepage, 'a');
    write(desc_fic_des, buffer, taillepage);
    write(desc_fic_des, buffer, taillepage);
    
    /**if ((base = mmap (NULL, 2*taillepage, PROT_READ | PROT_WRITE , MAP_SHARED, file, 0)) == (caddr_t) -1) {
        perror ("erreur mmap\n"); 
        exit(2);
    }
    
    retour = fork();
    if (retour<0) {
        perror("erreur fork");
    } else if (retour == 0) {
        sleep(2);
        lister(base, 10);
        garnir(base, taillepage, 'c');
        exit(EXIT_SUCCESS);
    } else {
        garnir(base+taillepage, 2*taillepage, 'b');
        
        wait(&wstatus);
        
        lister(base, 10);
    }*/
    
    close(file);
    
    return EXIT_SUCCESS;

}
