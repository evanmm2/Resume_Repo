#include "cs225/PNG.h"
#include "cs225/HSLAPixel.h"
#include "Image.h"
#include "StickerSheet.h"
#include <vector>

StickerSheet::StickerSheet(const Image & picture, unsigned max)
{
  InPNG = picture;
  OutPNG.resize(picture.width(),picture.height());
  array.resize(max);

  for(unsigned i = 0; i < max; i++){
    array[i] = NULL;
  }
  array1.resize((max)*2);
  for(unsigned i = 0; i < max*2; i++){
    array1[i] = 0;
  }
  max1 = max;
}
//---------------------------------------------------------------
StickerSheet::~StickerSheet(){
for(unsigned i =0 ; i < max1; i++){
  if(array[i]!=NULL){
    delete array[i];
    array[i] = NULL;
  }
}
array.clear();
array1.clear();
}
//----------------------------------------------------------
StickerSheet::StickerSheet(StickerSheet const & other){

_Copy(other);
}
//---------------------------------------------------------------
StickerSheet const & StickerSheet::operator=(StickerSheet const & other) {
  if (this != &other) { _Copy(other); }
  return *this;
}
//---------------------------------------------------------------
void StickerSheet::_Copy(StickerSheet const & other) {
changeMaxStickers(other.max1);
for(unsigned int i = 0; i < max1; i++){
  if(array[i]!=NULL){
    delete array[i];
    array[i] = NULL;
  }
}
for(unsigned i = 0; i < other.max1; i++){
  if(other.array[i] != NULL){
  array[i] = new Image;
  *array[i] = *other.array[i];
}}
for(unsigned i = 0; i <= ((max1-1)*2); i++){
  array1[i] = other.array1[i];
}
max1 = other.max1;
InPNG  = other.InPNG;
OutPNG = other. OutPNG;
}
//---------------------------------------------------------------
void StickerSheet::changeMaxStickers (unsigned max){
  unsigned max2 = max;
  unsigned max3 = max;
  if(max2<max1){

    for( ; max2 < max1; max2++){
      removeSticker((max1-max2+max-1));
    }
    array.resize(max);
  }
  if(max3>max1){
  array.resize(max);
  for( ; max3 > max1; max3=max3-1){
    array[max3-1] = NULL;
  }}

  array1.resize((max)*2);
  max1 = max;
}
//---------------------------------------------------------------
int StickerSheet::addSticker (Image &sticker, unsigned x, unsigned y){
for(unsigned i = 0; i <= max1-1; i++){
  if(array[i] == NULL){

    array[i] = new Image;
    *array[i] = sticker;
    array1[i*2] = x;
    array1[i*2+1] = y;
    return i;
  }

}
  return -1;
}
//---------------------------------------------------------------
bool StickerSheet::translate (unsigned index, unsigned x, unsigned y){
if(index > max1-1 || array[index]==NULL){
  return false;
}else{
array1[index*2] = x;
array1[index*2+1] = y;
return true;
}

}
//---------------------------------------------------------------
void StickerSheet::removeSticker (unsigned index){
if(array[index]!=NULL){
  delete array[index];
  array[index] = NULL;

}
}
//---------------------------------------------------------------
Image* StickerSheet::getSticker (unsigned index){
  if(index > max1-1){
    return NULL;
  }
  return array[index];
}
//---------------------------------------------------------------

Image StickerSheet::render () const{
  for(unsigned j = 1; j <= InPNG.height(); j++){
    for(unsigned k = 1; k <= InPNG.width(); k++){
      cs225::HSLAPixel& In_Pix = InPNG.getPixel(k-1,j-1);
      cs225::HSLAPixel& Out1_Pix = OutPNG.getPixel(k-1,j-1);
      Out1_Pix = In_Pix;
}}


  for(unsigned i = 0; i < max1; i++){
    if(array[i]!= NULL){
    for(unsigned j = 1; j <= array[i]->height(); j++){
      for(unsigned k = 1; k <= array[i]->width(); k++){

        if((array1[i*2])+k-1<InPNG.width() && array1[i*2+1]+j-1<InPNG.height()){
          cs225::HSLAPixel& Out1_Pix = OutPNG.getPixel(k-1+array1[i*2],j-1+array1[i*2+1]);
          cs225::HSLAPixel& In_Pix = array[i]->getPixel(k-1, j-1);
          if(In_Pix.a != 0){
          Out1_Pix = In_Pix;
        }}
      }}}}


return OutPNG;
}
