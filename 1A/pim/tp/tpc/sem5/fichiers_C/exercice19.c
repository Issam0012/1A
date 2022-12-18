
#include <stdlib.h> 
#include <stdio.h>

int main(int argc, char* argv[]){
    printf("Les arguments sont : %d \n", argc);
    
    // Afficher ici les argc arguments
    for (int i=0; i<argc; i++){
        printf("\n %s ",argv[i]);
    }
    
    return EXIT_SUCCESS;
}

