#include "cs225/PNG.h"
#include "cs225/HSLAPixel.h"
#include "Image.h"
#include <string>
#include <cmath>
#include <tgmath.h>


Image::Image()  {
                }


Image::~Image(){
}



 void Image::darken() {
   PNG* Original = this;
   unsigned int height1= Original->height();
   unsigned int width1 = Original->width();
   resize(width1, height1);
     for (unsigned y = 1; y <= height1; y++) {
        for (unsigned x = 1; x <= width1; x++) {
          cs225::HSLAPixel& Orig_Pix = Original->getPixel(x-1,y-1);
          cs225::HSLAPixel& Out_Pix = getPixel(x-1,y-1);
          Out_Pix = Orig_Pix;
         Orig_Pix.l = Orig_Pix.l - .1;
         if(Orig_Pix.l >= 0){
           Out_Pix.l = Orig_Pix.l;
         }
         if(Orig_Pix.l < 0){
           Out_Pix.l = 0;
         }

       }}
}

void Image::darken(double amount) {
  PNG* Original = this;
  unsigned int height1= Original->height();
  unsigned int width1 = Original->width();
  resize(width1, height1);
    for (unsigned y = 1; y <= height1; y++) {
       for (unsigned x = 1; x <= width1; x++) {
         cs225::HSLAPixel& Orig_Pix = Original->getPixel(x-1,y-1);
         cs225::HSLAPixel& Out_Pix = getPixel(x-1,y-1);
        Out_Pix = Orig_Pix;
        Orig_Pix.l = Orig_Pix.l - amount;
        if(Orig_Pix.l >= 0){
          Out_Pix.l = Orig_Pix.l;
        }
        if(Orig_Pix.l < 0){
          Out_Pix.l = 0;
        }
        if(Orig_Pix.l > 1){
          Out_Pix.l = 1;
        }
      }}

}

void Image::desaturate(){
   PNG* Original = this;
  height1 = Original->height();
  width1 =  Original->width();
  resize(width1, height1);
    for (unsigned y = 1; y <= height1; y++) {
       for (unsigned x = 1; x <= width1; x++) {
         cs225::HSLAPixel& Orig_Pix = Original->getPixel(x-1,y-1);
         cs225::HSLAPixel& Out_Pix = getPixel(x-1,y-1);
         Out_Pix = Orig_Pix;
         Orig_Pix.s = Orig_Pix.s - .1;
         if(Orig_Pix.s >= 0){
           Out_Pix.s = Orig_Pix.s;
         }
         if(Orig_Pix.s < 0){
           Out_Pix.s = 0;
         }

       }}
}
void Image::desaturate(double amount){
   PNG* Original = this;
  height1 = Original->height();
  width1 =  Original->width();
  resize(width1, height1);
    for (unsigned y = 1; y <= height1; y++) {
       for (unsigned x = 1; x <= width1; x++) {
         cs225::HSLAPixel& Orig_Pix = Original->getPixel(x-1,y-1);
         cs225::HSLAPixel& Out_Pix = getPixel(x-1,y-1);
         Out_Pix = Orig_Pix;
         Orig_Pix.s = Orig_Pix.s - amount;
         if(Orig_Pix.s >= 0){
           Out_Pix.s = Orig_Pix.s;
         }
         if(Orig_Pix.s < 0){
           Out_Pix.s = 0;
         }
         if(Orig_Pix.s > 1){
           Out_Pix.s = 1;
         }
       }}
}


void Image::grayscale(){
   PNG* Original = this;
  unsigned int height1= Original->height();
  unsigned int width1 = Original->width();
  resize(width1, height1);
    for (unsigned y = 1; y <= height1; y++) {
       for (unsigned x = 1; x <= width1; x++) {
         cs225::HSLAPixel& Orig_Pix = Original->getPixel(x-1,y-1);
         cs225::HSLAPixel& Out_Pix = getPixel(x-1,y-1);
         Out_Pix = Orig_Pix;
}}}


void Image::illinify(){
   PNG* Original = this;
  unsigned int height1= Original->height();
  unsigned int width1 = Original->width();
  resize(width1, height1);
    for (unsigned y = 1; y <= height1; y++) {
       for (unsigned x = 1; x <= width1; x++) {
         cs225::HSLAPixel& Orig_Pix = Original->getPixel(x-1,y-1);
         cs225::HSLAPixel& Out_Pix = getPixel(x-1,y-1);
         Out_Pix = Orig_Pix;
         if(Orig_Pix.h <113.5 || Orig_Pix.h >318.5){
           Out_Pix.h = 11;
         }
         else{
           Out_Pix.h = 216;
         }}}
}

void Image::lighten(){
   PNG* Original = this;
  unsigned int height1= Original->height();
  unsigned int width1 = Original->width();
  resize(width1, height1);
    for (unsigned y = 1; y <= height1; y++) {
       for (unsigned x = 1; x <= width1; x++) {
         cs225::HSLAPixel& Orig_Pix = Original->getPixel(x-1,y-1);
         cs225::HSLAPixel& Out_Pix = getPixel(x-1,y-1);
         Out_Pix = Orig_Pix;
         Orig_Pix.l = Orig_Pix.l + .1;
         if(Orig_Pix.l <= 1){
           Out_Pix.l = Orig_Pix.l;
         }
         if(Orig_Pix.l > 1){
           Out_Pix.l = 1;
         }

       }}

}

void Image::lighten(double amount){
   PNG* Original = this;
  unsigned int height1 = Original->height();
  unsigned int width1 = Original->width();
  resize(width1, height1);
    for (unsigned y = 1; y <= height1; y++) {
       for (unsigned x = 1; x <= width1; x++) {
         cs225::HSLAPixel& Orig_Pix = Original->getPixel(x-1,y-1);
         cs225::HSLAPixel& Out_Pix = getPixel(x-1,y-1);
         Out_Pix = Orig_Pix;
         Orig_Pix.l = Orig_Pix.l + amount;

         if(Orig_Pix.l < 1 || Orig_Pix.l == 1){
           Out_Pix.l = Orig_Pix.l;
            }
          if(Orig_Pix.l > 1){
            Out_Pix.l =  1;
          }
          if(Orig_Pix.l < 0){
            Out_Pix.l = 0;
          }
          }}
}

void Image::rotateColor(double degrees){
   PNG* Original = this;
  unsigned int height1= Original->height();
  unsigned int width1 = Original->width();
  resize(width1, height1);
    for (unsigned y = 1; y <= height1; y++) {
       for (unsigned x = 1; x <= width1; x++) {
         cs225::HSLAPixel& Orig_Pix = Original->getPixel(x-1,y-1);
         cs225::HSLAPixel& Out_Pix = getPixel(x-1,y-1);
         Out_Pix = Orig_Pix;
         Out_Pix.h = Orig_Pix.h + degrees;
         while(Out_Pix.h > 360.0){
         Out_Pix.h = Out_Pix.h - 360.0;}
         while(Out_Pix.h < 0){
           Out_Pix.h = Out_Pix.h + 360;
         }
}}}

void Image::saturate(){
   PNG* Original = this;
  unsigned int height1= Original->height();
  unsigned int width1 = Original->width();
  resize(width1, height1);
    for (unsigned y = 1; y <= height1; y++) {
       for (unsigned x = 1; x <= width1; x++) {
         cs225::HSLAPixel& Orig_Pix = Original->getPixel(x-1,y-1);
         cs225::HSLAPixel& Out_Pix = getPixel(x-1,y-1);
         Out_Pix = Orig_Pix;
         Orig_Pix.s = Orig_Pix.s + .1;
         if(Orig_Pix.s <= 1){
           Out_Pix.s = Orig_Pix.s;
         }
         if(Orig_Pix.s > 1){
           Out_Pix.s = 1;
         }
       }}
}

void Image::saturate(double amount){
   PNG* Original = this;
  unsigned int height1= Original->height();
  unsigned int width1 = Original->width();
  resize(width1, height1);
    for (unsigned y = 1; y <= height1; y++) {
       for (unsigned x = 1; x <= width1; x++) {
         cs225::HSLAPixel& Orig_Pix = Original->getPixel(x-1,y-1);
         cs225::HSLAPixel& Out_Pix = getPixel(x-1,y-1);
         Out_Pix = Orig_Pix;
         Orig_Pix.s = Orig_Pix.s + amount;
         if(Orig_Pix.s <= 1){
           Out_Pix.s = Orig_Pix.s;
         }
         if(Orig_Pix.s > 1){
           Out_Pix.s = 1;
         }
         if(Orig_Pix.s < 0){
           Out_Pix.s = 0;
         }
       }}
}

void Image::scale(double factor){
  PNG* Original1 = this;
  PNG Original = *Original1;
  unsigned int height1= Original.height();
  unsigned int width1 = Original.width();
  unsigned countery = 0;
  unsigned counterx = 0;

  if(factor < 1.0){
    double factor2 = 1.0/factor;
    double factor3 = round(factor2);
    unsigned width2 = width1/factor3;
    unsigned height2 = height1/factor3;
    resize(width2, height2);
    for (unsigned y = 1; y <= height2; y++) {
      for(unsigned x = 1; x <= width2; x++){
        cs225::HSLAPixel& Orig_Pix = Original.getPixel(((x-1)*factor3),(y-1)*factor3);
        cs225::HSLAPixel& Out_Pix = getPixel(x-1,y-1);
          Out_Pix = Orig_Pix;
          
}}}
if(factor == 1.0){
  double factor1 = round(factor);
  unsigned width2 = width1 * factor1;
  unsigned height2 = height1 * factor1;
  resize(width2,height2);

for (unsigned y = 1; y <= height1; y++) {
   for (unsigned x = 1; x <= width1; x++) {
     cs225::HSLAPixel& Orig_Pix = Original.getPixel(x-1,y-1);
     cs225::HSLAPixel& Out_Pix = getPixel(x-1,y-1);
     Out_Pix = Orig_Pix;
}}}



unsigned counter = 0;
if(factor > 1.0){
  double factor1 = round(factor);
  unsigned width2 = width1 * factor1;
  unsigned height2 = height1 * factor1;
  resize(width2, height2);

  for (unsigned y = 1; y <= height2; y++) {
    for(unsigned i = 0; i < factor1; i++){
     for (unsigned x = 1; x < width2; x++) {
         for(int j = 0; j < factor1; j++){
       cs225::HSLAPixel& Orig_Pix = Original.getPixel(x-1,y-1);
       cs225::HSLAPixel& Out_Pix = getPixel(x-1+counterx,y-1+countery);
       Out_Pix = Orig_Pix;
       counterx = counterx + 1;
       }
       counterx = counterx - 1;
       if((x-1+counterx) >= width2-1){
         counterx = 0;
         break;
    }
    }
    countery = countery + 1;
}
countery = countery - 1;
if((y-1+countery) >= height2-1){
  countery = 0;
  break;
   }}}}

void Image::scale(unsigned w, unsigned h){
  PNG* Original1 = this;
  PNG Original = *Original1;
     double factor = 0.0;
     unsigned int height1= Original.height();
     unsigned int width1 = Original.width();
     unsigned countery = 0;
     unsigned counterx = 0;
     double height4 = (double)h/(double)height1;
     double width4 = (double)w/(double)width1;
     if(width4>height4){
       factor = height4;
     }
     else {
       factor = width4;
     }

     scale(factor);

   }
