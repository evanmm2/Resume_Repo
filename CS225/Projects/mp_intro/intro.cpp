#include "cs225/PNG.h"
#include "cs225/HSLAPixel.h"

#include <unistd.h>
#include <string>
#include <cmath>

void rotate(std::string inputFile, std::string outputFile) {
  //Sets up a pointer to a new png with the information from the input file
  cs225::PNG* Original = new cs225::PNG(1,1);
  Original->readFromFile(inputFile);
  unsigned width  = Original->width();
  unsigned height = Original->height();
  //Sets up the output png
  cs225::PNG* Output = new cs225::PNG(width, height);
  //Cycles through the pixels and assigns them a location completely opposite their previous location into the output
  for (unsigned y = 1; y <= height; y++) {
       for (unsigned x = 1; x <= width; x++) {
         int x1 = x;
         int y1 = y;
         int width1 = width;
         int height1 = height;
         unsigned new_x = std::abs(x1 - width1);
         unsigned new_y = std::abs(y1 - height1);
         //Gets the pixel at that opposite location
         cs225::HSLAPixel& Orig_Pix = Original->getPixel(new_x , new_y);
         // Makes an alias of the pixel we want to change
         cs225::HSLAPixel& Out_Pix = Output->getPixel(x-1,y-1);
         Out_Pix.l = Orig_Pix.l;
         Out_Pix.h = Orig_Pix.h;
         Out_Pix.s = Orig_Pix.s;
         Out_Pix.a = Orig_Pix.a;

       }}
       Output->writeToFile(outputFile);
       delete Original;
       delete Output;
}

cs225::PNG myArt(unsigned int width, unsigned int height) {
  cs225::PNG png(width, height);

  for (unsigned y = 0; y < height; y++) {
       for (unsigned x = 0; x < width; x++) {
        cs225::HSLAPixel& pixel = png.getPixel(x,y);

        if(x < 100){
        pixel.l = .6;
        pixel.h = (x+y)/10+230;
        pixel.a = 1;
        pixel.s = 1;
        }
        if(x >= 100 && x<=200){
          pixel.l = .6;
          pixel.h = (x+y)/10+240;
          pixel.a = 1;
          pixel.s = 1;
        }
        if(x >= 200 && x<=300){
          pixel.l = .6;
          pixel.h = (x+y)/10+250;
          pixel.a = 1;
          pixel.s = 1;
        }
        if(x >= 300 && x<=400){
          pixel.l = .6;
          pixel.h = (x+y)/10+260;
          pixel.a = 1;
          pixel.s = 1;
        }
        if(x >= 400 && x<=500){
          pixel.l = .6;
          pixel.h = (x+y)/10+270;
          pixel.a = 1;
          pixel.s = 1;
        }
        if(x >= 500 && x<=600){
          pixel.l = .6;
          pixel.h = (x+y)/10+280;
          pixel.a = 1;
          pixel.s = 1;
        }
        if(x >= 600 && x<=700){
          pixel.l = .6;
          pixel.h = (x+y)/10+290;
          pixel.a = 1;
          pixel.s = 1;
        }
        if(x >= 700 && x<=800){
          pixel.l = .6;
          pixel.h = (x+y)/10+300;
          pixel.a = 1;
          pixel.s = 1;
        }
}}


  return png;
}
