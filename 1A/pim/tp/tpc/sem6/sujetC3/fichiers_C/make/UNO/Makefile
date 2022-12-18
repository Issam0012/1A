all: jouer_uno test_uno

# Ceci est un commentaire pour introdure la variable CC qui comporte le nom du compilateur utilisé :
CC=c99
# Les variables CFLAGS et LDFLAGS comportent les options de compilation et d'édition des liens :
CFLAGS=-Wextra -pedantic -c
LDFLAGS=

jouer_uno: carte.o jeu.o main.o uno.o jouer_uno.o
	$(CC) $(LDFLAGS) $< jeu.o main.o uno.o $@.o -o $@
	
test_uno: carte.o jeu.o main.o uno.o test_uno.o
	$(CC) $(LDFLAGS) $< jeu.o main.o uno.o $@.o -o $@

clean:
	rm *.o jouer_uno test_uno
	
depend: 
	makedepend *.c -Y

.PHONY: clean

# DO NOT DELETE

EDT.o: cours.h salle.h date.h enseignant.h
cours.o: cours.h salle.h date.h enseignant.h
date.o: date.h
enseignant.o: enseignant.h date.h
ephemeride.o: date.h
salle.o: salle.h date.h
