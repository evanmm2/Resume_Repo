#include "Image.h"

#include <iostream>

int main() {
  Image alma;

  std::cout << "Using Image::lighten to create `lighten.png`..." << std::endl;
  alma.readFromFile("alma.png");
  alma.lighten();
  alma.writeToFile("lighten.png");

  std::cout << "Using Image::saturate to create `saturate.png`..." << std::endl;
  alma.readFromFile("alma.png");
  alma.saturate();
  alma.writeToFile("saturate.png");

  std::cout << "Using Image::scale to create `scale.png`..." << std::endl;
  alma.readFromFile("alma.png");
  alma.scale(1500,1500);
  alma.writeToFile("scale2x.png");

  std::cout << "Using Image::scale to create `rotatecolor.png`..." << std::endl;
  alma.readFromFile("alma.png");
  alma.rotateColor(150);
  alma.writeToFile("rotatecolor.png");



  return 0;
}
