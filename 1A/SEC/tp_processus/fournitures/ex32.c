#include <stdio.h>
#include <unistd.h>
#include <stdlib.h> /* exit */

int main(int argc, char* arg[]) {

    //execlp( "ls", "ls", "-l" , NULL);
    
    execl("/bin/ls", "ls", "-l", arg[1], NULL); 
    
    printf("Erreur \n");
    
    return EXIT_SUCCESS;
}
