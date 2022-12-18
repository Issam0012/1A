all: ephemeride EDT

# Ceci est un commentaire pour introdure la variable CC qui comporte le nom du compilateur utilisé :
CC=c99
# Les variables CFLAGS et LDFLAGS comportent les options de compilation et d'édition des liens :
CFLAGS=-Wextra -pedantic -c
LDFLAGS=

ephemeride: date.o ephemeride.o
	$(CC) $(LDFLAGS) $< $@.o -o $@
	
EDT: EDT.o
	$(CC) $(LDFLAGS) date.o $< -o $@

clean:
	rm *.o ephemeride EDT
	
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
