#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>  /* exit */
#include <sys/wait.h> 	/* wait */
#include <string.h>   /* bibliothèque string */
#include <stdbool.h>
#include <fcntl.h>    /* opérations sur les fichiers */
#include "readcmd.h"
#include"liste.h"

pListe liste;
pid_t pid_fils = 0;
bool foreground;

/** La handler du signal SIGCHLD */
void handler_CHLD(int signal_num) {

    int wstatus, pid_chld;
    pid_chld = pid_fils;
    
    if (pid_chld>0) {
    
        waitpid(pid_chld, &wstatus, WUNTRACED | WCONTINUED);  /** waitpid bloquante avec retour si un fils est suspendu ou un fils suspendu a été relancé */ 
        
        if (WIFSTOPPED(wstatus)) {  /** un fils suspendu est décalré suspendu sur la liste des jobs et le boolean indique qu'il n'est plus en avant-plan (s'il était ou s'il n'était pas) */
            int k = indice(&liste, pid_chld);
            changerEtat(&liste, k, "SUSPENDU");
            foreground = false;
        }
        else if (WIFCONTINUED(wstatus)) { /** un fils relancé est décalré actif sur la liste des jobs */
            int k = indice(&liste, pid_chld);
            changerEtat(&liste, k, "ACTIF");
            
        }
        else if (WIFEXITED(wstatus) || WIFSIGNALED(wstatus)) {  /** un fils arrêté par exit ou tué par un signal est supprimé de la liste des jobs et le boolean indique qu'il n'est plus en avant-plan (s'il était ou s'il n'était pas) */
            Supprimer(&liste, pid_chld);
            foreground = false;
        } 
    }
    

}

/** La handler du signal SIGTSTP */
void handler_STOP(int signal_num) {
    if (pid_fils != 0) {
        if (foreground == true) { /** on envoir le signal SIGSTOP pour suspendre juste au fils en avant-plan */
            kill(pid_fils,SIGSTOP); 
            printf("[%d]    Arrêté \n", indice(&liste,pid_fils));
        }
    } else { /** S'il y'a pas de commande en avant-plan on affiche un message d'erreur */
        perror("Aucune commande n'est en cours \n");
    }
}

/** La handler du signal SIGTSTP */
void handler_INT(int signal_num) {
    if (pid_fils != 0) {
        if(foreground == true) { /** on envoir le signal SIGKILL pour tuer juste au fils en avant-plan */
            kill(pid_fils,SIGKILL);
            printf("\n");
        }
    } else { /** S'il y'a pas de commande en avant-plan on affiche un message d'erreur */
        perror("Aucune commande n'est en cours \n");
    }
}
 
/** La commande interne stop jobs 
parametres :
IN : idprocessus : l'identifiant du processus qui est propre au minishell
*/
void sj (int idprocessus) {

    if (existe((&liste), idprocessus)) { /** Si l'identifiant existe on cherche son pid sur la liste des jobs et on le suspend par l'envoie de SIGSTOP */
        
        int indice_pro = indice_id(&liste, idprocessus);
        
        int PID = (&liste)->Liste[indice_pro].pid;
        
        kill(PID,SIGSTOP);
        
    } else { /** Si l'identifiant n'existe pas on affiche un message d'erreur */
        printf("Vous devez entrer un identifiant valide \n"); 
    }

}

/** La commande interne background
parametres :
IN : idprocessus : l'identifiant du processus qui est propre au minishell
*/
void bg(int idprocessus) {

    if (existe((&liste), idprocessus)) { /** Si l'identifiant existe on cherche son pid sur la liste des jobs et on le reprend par l'envoie de SIGCONT et on insiste sur le fait que foreground est false */
        
        int indice_pro = indice_id(&liste, idprocessus);
        
        int PID = (&liste)->Liste[indice_pro].pid;
        
        kill(PID, SIGCONT);
        
        foreground = false;
        
    } else { /** Si l'identifiant n'existe pas on affiche un message d'erreur */
        printf("Vous devez entrer un identifiant valide \n"); 
    }

}

/** La commande interne foreground
parametres :
IN : idprocessus : l'identifiant du processus qui est propre au minishell
*/
void fg(int idprocessus) {

    if (existe((&liste), idprocessus)) { /** Si l'identifiant existe on cherche son pid sur la liste des jobs et on le reprend par l'envoie de SIGCONT (s'il est suspendu il va se reprendre sinon rien ne va passer) et on attribue a foreground la valeur true pour qu'il s'exécute en avant-plan*/
        
        int indice_pro = indice_id(&liste, idprocessus);
        
        int PID = (&liste)->Liste[indice_pro].pid;
        
        kill(PID, SIGCONT);
        
        foreground = true;
        
    } else {
        printf("Vous devez entrer un identifiant valide \n"); 
    }

}

/** La commande interne cd
parametres :
IN : commandes = la ligne de commande
IN : repertoire_actuelle = le répertoire actuelle
*/
void cd(struct cmdline* commandes, char* repertoire_actuelle) {

    char *nouveau_repertoire;

    if((commandes->seq)[0][1]==NULL || strcmp((commandes->seq)[0][1], "~")==0) { /** Si la commande est de la forme "cd" ou "cd ~" on se retrove au dossier personnel */
        nouveau_repertoire = "/home/";
        char buffer1[strlen(repertoire_actuelle)];
        char buffer2[strlen(repertoire_actuelle)];
        
        char *p = strtok(strcpy(buffer2, repertoire_actuelle), "/");
        p = strtok(NULL, "/");
        
        strcat(strcpy(buffer1, nouveau_repertoire), p);
        
        chdir(buffer1);
        
    } else {
        if (chdir(commandes->seq[0][1]) == -1) { /** Sinon on va nous retrouver dans l'endroit indiqué avec un perror si y a erreur (chemin inexistant par exemple) */ 
            perror("Répertoire invalide");
            exit(3);
        }
    }

}

/** Le sous-programme de redirection
parametres :
IN : commandes = la ligne de commande
*/
void redirection(struct cmdline* commandes) {

    int desc_entree, desc_sortie;
    
    if (commandes->in != NULL) { /** Si commandes->in est non null alors on redirige l'entrée standard vers ce fichier */ 
        if ((desc_entree = open(commandes->in, O_RDONLY))<0) {
            perror("Erreur d'ouverture de l'entrée");
            exit(4);
        }
        if (dup2(desc_entree, 0)<0) {
            printf("Erreur de redirection de l'entrée standard");
            exit(3);
        }
    }
    
    if (commandes->out != NULL) { /** Si commandes->out est non null alors on redirige la sortie standard vers ce fichier */ 
        if ((desc_sortie = open(commandes->out, O_WRONLY | O_CREAT | O_TRUNC, 0640))<0) {
            perror("Erreur d'ouverture de la sortie");
            exit(4);
        }
        if (dup2(desc_sortie, 1)<0) {
            printf("Erreur de redirection de la sortie standard");
            exit(3);
        }
    }

}

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
                
				if (nbCmd > 2 ) { /** si on a encore plus que 2 commandes on appelle exec_cmd_pipe */
				    exec_cmd_pipe (cmdv+2);
				}
        
                execvp(cmdv[1][0], cmdv[1]);

                exit(2);
        }
    }
    else {  /* dernière commande : sans pipe */
        ret = execvp(cmdv[0][0], cmdv[0]);
        perror("Commande introuvable");  /* seulement si execvp echoue */
        exit(ret);
    }
    return;
}

int main(int argc, char* argv[]) {
    Initialiser(&liste);  /** initialiser liste jobs */
    struct cmdline* commandes;
    char *commande, *repertoire_actuelle;
    
    /** J'ai esssayé avec le sigaction mais j'ai pas arrivé à avoir un comportement semblable à signal donc j'avais utilisé signal pour associer le signal à son handler */
    
    /**struct sigaction s;
    
    s.sa_flags = SA_NOCLDWAIT;
    s.sa_handler = handler_CHLD;
    sigemptyset(&s.sa_mask);
    if (sigaction(SIGCHLD, &s, NULL)) {
        printf("sigaction CHLD failed");
    }
    
    s.sa_handler = handler_INT;
    if (sigaction(SIGINT, &s, NULL)) {
        printf("sigaction INT failed");
    }
    
    s.sa_handler = handler_STOP;
    if (sigaction(SIGTSTP, &s, NULL)) {
        printf("sigaction STOP failed");
    }*/
    
    signal(SIGCHLD, handler_CHLD);
    signal(SIGINT, handler_INT);
    signal(SIGTSTP, handler_STOP);
    
    /* Clear the screen */
    system("clear");
    
    /** Le boolean qui va servir comme paramètre de sortie du boucle */
    bool sortie = false;

    do {
    
        /** L'attente si le fils est en avant-plan */
        while (foreground != false) {
            pause();
        }
    
        /** L'affichage du répertoire actuel */
        repertoire_actuelle = getcwd(NULL, 0);
        printf("%s >> ", repertoire_actuelle);
        
        /** La lecture de la ligne de commande */
        commandes = readcmd();

        /** on reste au minishell si on tappe entrer sans rien écrire */
        if (commandes->seq[0] != NULL) {
        
            commande = commandes -> seq[0][0];
            
            /* Sortir quand exit est saisie au clavier */
            if (strcmp(commande, "exit") == 0) {
                sortie = true;
            }
            
            /* Le traitement interne de cd */
            else if (strcmp(commande, "cd") == 0) {
                cd(commandes, repertoire_actuelle);
            } 
            /** La commande interne liste jobs */
            else if (strcmp(commande, "lj") == 0) {
                Afficher(&liste);
            } 
            /** La commande interne stop jobs */
            else if (strcmp(commande, "sj") == 0) {
                sj(atoi((commandes->seq)[0][1]));
            } 
            /** La commande interne background */
            else if (strcmp(commande, "bg") == 0) {
                bg(atoi((commandes->seq)[0][1]));
            }
            /** La commande interne foreground */
            else if (strcmp(commande, "fg") == 0) {
                fg(atoi((commandes->seq)[0][1]));
            } 
            /** La commande interne suspendre */
            else if (strcmp(commande, "susp") == 0) {
                kill(getpid(),SIGSTOP);
            } 
            /** Traitement des commandes externes */
            else {

                /** On crée un fils par fork */
                pid_fils = fork();
            
                if (pid_fils == -1) { /** Si la céation échoue */
                    printf("Erreur fork");
                    exit(1);
                    
                } else if (pid_fils == 0) { /** fils*/
                    /** La redirection de l'entrée standard et la sortie standard (si les paramètres existent) */
                    redirection(commandes);
                    
                    /** L'exécution de la commande */
                    exec_cmd_pipe(commandes->seq);
                    
                } else { /** père */
                
                    /** On enregistre le nom de la commande dans command */
                    char command[200] ="  " ;
                    int i = 0;
                    while (!(commandes->seq[0][i] == NULL)) {
                        strcat(command,commandes->seq[0][i]);
                        strcat(command," ");
                        i++;
                    }
                
                    /** On ajoute le processus en cours au liste jobs avec le statut actif */
                    Ajouter(&liste, (&liste)->taille, pid_fils, "ACTIF", command); 
                    /** Si la commande est en avant-plan on met foreground à true */
                    if (commandes->backgrounded == NULL) {
                        foreground = true;
                    }

                }
                
            }
        }
    } while (!(sortie));

    return EXIT_SUCCESS;
}
