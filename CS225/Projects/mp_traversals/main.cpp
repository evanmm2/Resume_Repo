
#include "cs225/PNG.h"
#include "FloodFilledImage.h"
#include "Animation.h"

#include "imageTraversal/DFS.h"
#include "imageTraversal/BFS.h"

#include "colorPicker/RainbowColorPicker.h"
#include "colorPicker/GradientColorPicker.h"
#include "colorPicker/GridColorPicker.h"
#include "colorPicker/SolidColorPicker.h"
#include "colorPicker/MyColorPicker.h"

using namespace cs225;

int main() {

  // @todo [Part 3]
  // - The code below assumes you have an Animation called `animation`
  // - The code provided below produces the `myFloodFill.png` file you must
  //   submit Part 3 of this assignment -- uncomment it when you're ready.
PNG png;      png.readFromFile("tests/lantern.png");
FloodFilledImage image(png);

BFS bfs1(png, Point(35, 15), 0.05);
RainbowColorPicker rainbow1(0.05);
image.addFloodFill( bfs1, rainbow1 );

BFS bfs2(png, Point(60, 10), 0.1);
RainbowColorPicker rainbow2(0.05);
image.addFloodFill( bfs2, rainbow2);

BFS bfs3(png, Point(90, 10), 0.1);
RainbowColorPicker rainbow3(0.05);
image.addFloodFill( bfs3, rainbow2);

BFS bfs4(png, Point(20, 30), 0.1);
RainbowColorPicker rainbow4(0.05);
image.addFloodFill( bfs3, rainbow4);

BFS bfs5(png, Point(60, 30), 0.1);
RainbowColorPicker rainbow5(0.05);
image.addFloodFill( bfs5, rainbow5);

BFS bfs6(png, Point(90, 30), 0.1);
RainbowColorPicker rainbow6(0.05);
image.addFloodFill( bfs6, rainbow6);

BFS bfs7(png, Point(30, 45), 0.1);
RainbowColorPicker rainbow7(0.05);
image.addFloodFill( bfs7, rainbow7);


BFS bfs8(png, Point(60, 45), 0.1);
RainbowColorPicker rainbow8(0.05);
image.addFloodFill( bfs8, rainbow8);

BFS bfs9(png, Point(95, 45), 0.1);
RainbowColorPicker rainbow9(0.05);
image.addFloodFill( bfs9, rainbow9);

BFS bfs10(png, Point(30, 55), 0.1);
RainbowColorPicker rainbow10(0.05);
image.addFloodFill( bfs10, rainbow10);

BFS bfs11(png, Point(60, 55), 0.1);
RainbowColorPicker rainbow11(0.05);
image.addFloodFill( bfs11, rainbow11);

BFS bfs12(png, Point(99, 55), 0.1);
RainbowColorPicker rainbow12(0.05);
image.addFloodFill( bfs12, rainbow12);




DFS dfs(png, Point(65, 50), 0.3);
MyColorPicker black;
image.addFloodFill( dfs, black );



Animation animation = image.animate(1000);

  PNG lastFrame = animation.getFrame( animation.frameCount() - 1 );
  lastFrame.writeToFile("myFloodFill.png");
  animation.write("myFloodFill.gif");



  return 0;
}
