/* Your code here! */
#include "maze.h"
#include <queue>
SquareMaze::SquareMaze():width1(0),height1(0){
//Left as an empty constructor

}


void 	SquareMaze::makeMaze(int width, int height){
width1 = width;
height1 = height;       //To be used by other functions? Not sure yet, just saving it here in case
int size = width*height;
cells.addelements(size);          // Each element in the disjoint set is a cell
for(int j = 0; j < size; j++){
  rightWalls.push_back(true);
  downWalls.push_back(true);        //Initialize the whole bottom and right arrays to be true

}


int i = 0;
std::srand (time(NULL));   // Initializes the random seed
while(i <= size/2){
  //Randomize whether it is a right or left that is being looked at. Once that is randomized, go through all the cells and finish deleting walls wherever possible
  int right = std::rand() % 2;
  int column = std::rand() % (width-1);    //Randomizes the cell that it is looking at. Doesn't let the far right or bottom get touched.
  int row = std::rand() %  (height-1);
  if(right == 1 && rightWalls[row*width + column] == true &&              // Determines if there is a wall to delete or not, checks the random right value
			cells.find(row*width + column) != cells.find(row*width + column+1)) {      // This part determines if it is a cycle or not
      rightWalls[row*width + column] = false;                                   // Set the wall false at this location
      cells.setunion(row*width + column, row*width + column+1);                 // union the disjoint sets
                                                                            // Only increases the counter if it's possible to do the right deletion
  }
  else if(downWalls[row*width + column] == true &&
      cells.find(row*width + column) != cells.find(row*width + column)) {     // If it can't do the right then it does the left if possible
      downWalls[row*width + column] = false;
      cells.setunion(row*width + column, (row+1)*width + column);

  }
  i++;
}         // The above function goes and randomizes the ones that it deletes throught the grid. The next one will delete out the rest of the maze, not include the edge cases of the
          // far right and the far bottom
for(int f = 0; f < height-1; f++){
  for(int g = 0; g < width-1; g++){
    if(rightWalls[f*width + g] == true &&
      cells.find(f*width + g) != cells.find(f*width + g+1)) {
        rightWalls[f*width + g] = false;
        cells.setunion(f*width + g, f*width + g+1);
    }
    if(downWalls[f*width + g] == true &&
      cells.find(f*width + g) != cells.find((f+1)*width+g)){
        downWalls[f*width + g] = false;
        cells.setunion(f*width + g, (f+1)*width + g);
      }
  }
}
std::cout<<"Gets through main body"<<std::endl;

for(int f = 0; f < height - 1; f++){        // Checks the right most columns for bottoms that it can delete f is the row we are looking at
  if(downWalls[f*(width-1) + (width-1)] == true &&    // Width should be the value of the location of the rightmost row
    cells.find(f*(width-1) + (width-1)) != cells.find((f+1)*(width-1)+(width-1))){
      downWalls[f*(width-1) + (width-1)] = false;
      cells.setunion(f*(width-1) + (width-1), (f+1)*(width-1) + (width-1));
      }
    }
    std::cout<<"Gets through first edge case body"<<std::endl;
// for(int f = 0; f < width - 1; f++){
//   if((height-1)*width+f+1 >= size){
//     break;
//   }

//   std::cout<<"Middle of second case"<<std::endl;
  // if(rightWalls[(height-1)*(width-1) + f] == true &&
  //   cells.find((height-1)*(width-1) + f) != cells.find(height-1)*(width-1) + f+1) {
  //     rightWalls[(height-1)*(width-1) + f] = false;
  //     cells.setunion((height-1)*(width-1) + f, (height-1)*(width-1) + f+1);
  //   }
  // }


}

bool 	 SquareMaze::canTravel(int x, int y, int dir) const{   // X is the x coor y is the y coord
  if(dir == 0){
    if(x != width1-1){
    if(rightWalls[y*width1 + x]){
      return false;
      }
    }
  }
  else if(dir == 1){
    if(x != height1-1){
    if(downWalls[y*width1 + x]){
      return false;
    }
    }
  }
  else if(dir == 2){
  if(x!=0){
    if(rightWalls[y*width1 + x-1]){
      return false;
      }
    }
  }
  else if(dir == 3){
    if(y != 0){
    if(rightWalls[(y-1)*width1 + x]){
      return false;
      }
    }
  }
  return false;
}

void 	SquareMaze::setWall(int x, int y, int dir, bool exists){
if(dir == 0){
  rightWalls[y*width1 + x] = exists;
  }
 if(dir == 1){
  downWalls[y*width1 + x] = exists;
}
return;
}


std::vector<int>	SquareMaze::solveMaze(){

std::vector<int> path;
int * bottom = new int[width1];
for(int i = 0; i < width1; i++){
  bottom[i] = 0;
}
//Lets try doing this recursively
recursivePath(0, 0, path, bottom);    //Starts in location 0
int finalColumn = 0;

for(int i = 0; i < width1; i++){
  if(bottom[finalColumn] < bottom[i]){
    finalColumn = i;
  }
}
std::cout<<finalColumn<<std::endl;

recursivePath2(0,0,path,finalColumn);
delete[] bottom;

return path;
}



// int distance = 0;
// int current;
// bottom.reserve(width1);
// parent.reserve(width1 * height1);
// for(int i = 0; i < width1*height1; i++ ){
//   visited.push_back(false);
// }
// for(int i = 0; i < width1; i++ ){
//   bottom.push_back(0);
// }
// queue.push(0);    // 0 is the start of all of the mazes
// visited[0] = true; // Visited location 0 and so this location is now true;
// current = queue.front();
// while(!queue.empty()){    // So while the queue still has stuff in it
// current = queue.front();
// queue.pop();
// int x = current%width1;
// int y = current/width1;
// if(current >= (width1*(height1-1))){
//   bottom[x] = distance;
// }
// if(canTravel(x, y, 0) && !visited[x + 1 + y*width1]) {
//       queue.push(x + 1 + y*width1);
//       visited[x + 1 + y*width1] = true;
//       parent[y * width1 + x + 1] = current;
//     }
//
//     if(canTravel(x, y, 1) && !visited[x + (y+1)*width1]) {
//       queue.push(x + (y+1)*width1);
//       visited[x + (y+1)*width1] = true;
//       parent[(y + 1) * width1 + x] = current;
//     }
//
//     if(canTravel(x, y, 2) && !visited[x-1 + y*width1]) {
//       queue.push(x-1 + y*width1);
//       visited[x-1 + y*width1] = true;
//       parent[x-1 + y*width1] = current;
//     }
//
//     if(canTravel(x, y, 3) && !visited[(y - 1) * width1 + x]) {
//       queue.push((y - 1) * width1 + x);
//       visited[(y - 1) * width1 + x] = true;
//       parent[(y - 1) * width1 + x] = current;
//     }
//
//     distance++;
//   }
// int maxDistance = 0;
// int finalColumn;
// for(int i = 0; i < width1; i++){
//   if(bottom[i] > maxDistance){
//     maxDistance = bottom[i];
//     finalColumn = i;
//   }
// }
// int dir;
// int finalDestination = finalColumn + width1*(height1-1);
// current = finalDestination;
// while(current!=0){
// int  x = current%width1;
// int  y = current/width1;
// int  par = parent[current];
//
//   if (par%width1 == x) {
//     if (par/width1 + 1 == y)
//       dir = 1;
//
//     if (par/width1 - 1 == y)
//       dir = 3;
//   }
//
//   if (par/width1 == y) {
//     if (par%width1 + 1 == x)
//       dir = 0;
//
//     if (par%width1 - 1 == x)
//       dir = 2;
//   }
//
//     output.insert(output.begin(), dir);
//     current = par;
//   }





cs225::PNG* SquareMaze::drawMaze() const{

cs225::PNG* drawn = new cs225::PNG(width1 * 10 + 1, height1 * 10 + 1);
for(int y = 0; y < height1*10; y++)
	{
    cs225::HSLAPixel & pixel = drawn->getPixel(0, y);
    pixel.l = 0;
	}

for(int x = 10; x < width1*10; x++)
  	{
      cs225::HSLAPixel & pixel = drawn->getPixel(x, 0);
      pixel.l = 0;
  	}
for(int i = 0; i < width1 * height1; i++){
    int y = i/width1;
		int x = i%width1;

    if(rightWalls[i]){
      for(int z = 0; z<= 10; z++){
        cs225::HSLAPixel & pixel = drawn->getPixel((x+1)*10,y*10+z);
        pixel.l = 0;
      }
    }
    if(downWalls[i]){
      for(int z = 0; z <= 10; z++){
      cs225::HSLAPixel & pixel = drawn->getPixel(x*10 + z,(y+1)*10);
      pixel.l = 0;
      }
    }
  }
return drawn;

}

cs225::PNG* SquareMaze::drawMazeWithSolution(){
cs225::PNG* output = drawMaze();
std::vector<int> path = solveMaze();
cs225::HSLAPixel red (0,1,0.5,1);
int x = 5;
int y = 5;
for(size_t i = 0; i < path.size(); i ++){
  if(path[i] == 0){
    for(int j = 0; j <= 10; j++){
      output->getPixel(x + j, y) = red;
    }
    x = x + 10;
  }
  if(path[i] == 1){
    for(int j = 0; j <= 10; j++){
      output->getPixel(x, j + y) = red;
    }
    y = y + 10;
  }
  if(path[i] == 2){
    for(int j = 0; j <= 10; j++){
      output->getPixel(x - j, y) = red;
    }
    x = x - 10;
  }
  if(path[i] == 3){
    for(int j = 0; j <= 10; j++){
      output->getPixel(x,  y - j) = red;
    }
    y = y - 10;
    }
  }
  int f = x /10;
	int g = height1 - 1;
  for(int k = 1; k < 10; k++){
    output->getPixel(f*10+k, (g+1)*10).l = 1.0 ;
  }
  return output;
}

//Is this even possible to do recursively?
void SquareMaze::recursivePath(int x, int y, std::vector<int> & path, int * bottom){ // Thhis function finds the
  if(y == height1-1){
      bottom[x] = path.size();          // The length of the path from the recursive function is the total length to get to that x location on the bottom layer
      std::cout<<"Ever retrun via this?"<<std::endl;
  }
  if(canTravel(x, y, 0))
	{
		path.push_back(0);                // For all of them, it checks if it can travel in a certain direction
		setWall(x, y, 0, true);          // It closes the floodgates behind them
		recursivePath(x + 1, y, path, bottom);      // It checks for more places in that direction
		path.pop_back();                  // It opens the floodgates again so it can move on
		setWall(x, y, 0, false);
	}

	if(canTravel(x, y, 1))
	{
		path.push_back(1);
		setWall(x, y, 1, true);
		recursivePath(x, y + 1, path, bottom);
		path.pop_back();
		setWall(x, y, 1, false);
	}

	if(canTravel(x, y, 2))
	{
		path.push_back(2);
		setWall(x - 1, y, 0, true);
		recursivePath(x - 1, y, path, bottom);
		path.pop_back();
		setWall(x - 1, y, 0, false);
	}

	if(canTravel(x, y, 3))
	{
		path.push_back(3);
		setWall(x, y - 1, 1, true);
		recursivePath(x, y - 1, path, bottom);
		path.pop_back();
		setWall(x, y - 1, 1, false);
	}
	return;
}

bool SquareMaze::recursivePath2(int x, int y, std::vector<int> & path, int finalColumn){
//Set our base cases
if(x == finalColumn && y == height1-1){    // If we are in the right row and column return true
  return true;
}
              // This set of recursive functions follows the same idea as the one above it. If the path is closed off, then just recurse back and continue on until
              // the desired column and row  is reached
if(canTravel(x,y,0)){
  path.push_back(0);  // To the right
  setWall(x, y, 0, true);     // Checks the bar to the right of the current cell
  if(recursivePath2(x+1,y, path, finalColumn) == true){
    return true;
  }
  path.pop_back();
  setWall(x, y, 0, false);
}
if(canTravel(x,y,1)){             // To the bottom
  path.push_back(1);              // checks the bar below the current cell
  setWall(x, y, 1, true);
  if(recursivePath2(x,y + 1, path, finalColumn) == true){
    return true;
  }
  path.pop_back();
  setWall(x, y, 1, false);
}
if(x!=0){
if(canTravel(x-1,y,0)){           //To the left
  path.push_back(0);            // Checks the right of the cells to the left, so the left
  setWall(x-1, y, 0, true);
  if(recursivePath2(x-1,y, path, finalColumn) == true){
    return true;
  }
  path.pop_back();
  setWall(x-1, y, 0, false);
}}
if(y != 0){
if(canTravel(x,y-1,0)){               // Up above
  path.push_back(0);                  // Checks the bottom of the cell above, so the top
  setWall(x, y-1, 0, true);
  if(recursivePath2(x,y-1, path, finalColumn) == true){
    return true;
  }
  path.pop_back();
  setWall(x, y-1, 0, false);
}
}
return false;
}
