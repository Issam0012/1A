#include <stdlib.h> 
#include <stdio.h>
#include <assert.h>
#include <math.h>

// Definition du type Point 
struct Point{
    int X;
    int Y;
};
typedef struct Point pt;

int main(){
    // Déclarer deux variables ptA et ptB de types Point
    pt ptA;
    pt ptB;
    
    // Initialiser ptA à (0,0)
    ptA.X=0;
    ptA.Y=0;
    
    // Initialiser ptB à (10,10)
    ptB.X=10;
    ptB.Y=10;
    
    // Calculer la distance entre ptA et ptB.
    float distance = sqrt((ptB.Y-ptA.Y)*(ptB.Y-ptA.Y)+(ptB.X-ptA.X)*(ptB.X-ptA.X));
    assert( (int)(distance*distance) == 200);
    
    return EXIT_SUCCESS;
}
