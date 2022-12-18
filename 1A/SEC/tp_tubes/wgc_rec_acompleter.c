#include <stdio.h>
#include <unistd.h>
#include <stdlib.h> 	
#include <string.h>  

/* Exécuter une commande contenant un ou plusieurs pipes 
parametres :
IN : cmdv = ligne de commande (cmdv[0] | cmdv[1] ... )
La commande peut etre sans pipe
*/
void exec_cmd_pipe(char **cmdv[]) {
    int ret, pid, pf2p[2];
    int nbCmd;

    /* Trouver s'il y a un pipe */
	nbCmd = 0;
    while (cmdv[nbCmd] != NULL) { 
        nbCmd++; 
    }
	
    if (nbCmd > 1) { /* c'est une commande avec 1 pipe ou + : cmdv[0] | cmdv[1] ...*/
		
        if (pipe(pf2p) < 0) {
            perror("Erreur pipe");
            exit(3);
        }

        /* Creer un fils pour exécuter cmdv[0], le père executant cmdv[1] ... */
        pid = fork();
        switch (pid) {
            case -1 :
                printf("Erreur fork\n"); 
				exit(1);

            case 0 : /*fils execute cmdv[0] et doit transmettre le résultat au père */
				
                //>>> fils écrit sur pipe1
                close(pf2p[0]);
                
                if (dup2(pf2p[1],1)<0) {
                    perror("Erreur dup2");
                    exit(4);
                }
                
                close(pf2p[1]);
                
                execvp(cmdv[0][0], cmdv[0]);
                
                printf("Erreur d'exécution de la commande %s", cmdv[0][0]);
                
                exit(5);

            default : /* pere execute cmdv[1] | ... en récupérant le flot de données 
						fourni par son fils, qui servira d'entrée pour cmdv[1]*/
                
				close(pf2p[1]);
                
                if (dup2(pf2p[0],0)<0) {
                    perror("Erreur dup2");
                    exit(4);
                }
                
                close(pf2p[0]);
                
                if (nbCmd > 2 ) {
				    exec_cmd_pipe (cmdv+2);
				}
        
                execvp(cmdv[1][0], cmdv[1]);

                exit(2);
        }
    }
    else {  /* dernière commande : sans pipe */
        ret = execvp(cmdv[0][0], cmdv[0]);
        printf("\nErreur execvp \n");  /* seulement si execvp echoue */
        exit(ret);
    }
    return;
}

int main(int argc, char* argv[]) {
	
	/* 	commande : who | grep utilisateur | wc -l
		construite avec la meme strcture fournie par readcmd
	*/
	char **cmdline[4];
	char *cmd1[] = { "who", NULL};
	char *cmd2[] = { "grep", NULL, NULL};
	char *cmd3[] = { "wc", "-l", NULL};
	
	cmdline[0] = cmd1;
	cmdline[1] = cmd3;
	cmdline[2] = cmd3;
	cmdline[3] = NULL;
	
	// controler la validité de la commande
	if (argc != 2) {
        printf("Usage : %s utilisateur\n", argv[0]);
        exit(1);
    }
	
	// completer cmdline avec le nom de l'utilisateur
	cmd2[1] = argv[1];
	
	// executer la commande 
	exec_cmd_pipe (cmdline);
	
	return 0;
}
