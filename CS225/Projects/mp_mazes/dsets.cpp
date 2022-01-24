/* Your code here! */

#include "dsets.h"



void DisjointSets::addelements(int num){
  for(int i = 0; i < num; i++){     // Sets up the disjonint sets with the required -1
    sets.push_back(-1);
  }
}


int DisjointSets::find(int elem){
  if(sets[elem] < 0){
    return elem;
  }
  else{
    int root = find(sets[elem]);
    sets[elem] = root;
    return root;
  }
}

void DisjointSets::setunion(int a, int b){
int x = find(a);
int y = find(b);    //Finds the number of elements in the two of them
int newSize = sets[x] + sets[y];      // Sets the new size to be the addition of the two negative widths of it
if(sets[x] < sets[y]){
  sets[y] = x;
  sets[x] = newSize;
}
else{
  sets[x] = y;
  sets[y] = newSize;
}

}

int DisjointSets::size(int elem){

  return -1 * sets[find(elem)];     //The root should hold the width of it's tree, but be negative. Returns the negative of this
}
