/* Your code here! */
#pragma once
#include <vector>
#include "cs225/PNG.h"
#include "cs225/HSLAPixel.h"
#include "dsets.h"

class SquareMaze{
public:
  SquareMaze();
  void 	makeMaze(int width, int height);
  bool 	canTravel(int x, int y, int dir) const;
  void 	setWall(int x, int y, int dir, bool exists);
  std::vector<int>	solveMaze();
  cs225::PNG* drawMaze() const;
  cs225::PNG* drawMazeWithSolution();

private:

int width1;
int height1;
DisjointSets cells;
std::vector<bool> rightWalls, downWalls;
void recursivePath(int x, int y, std::vector<int> & path, int* bottom);
bool recursivePath2(int x, int y, std::vector<int> & path, int finalColumn);
};
