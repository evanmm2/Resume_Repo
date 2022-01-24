/**
 * @file StickerSheet.h
 * Contains your declaration of the interface for the StickerSheet class.
 */
 #include "cs225/PNG.h"
 #include "cs225/HSLAPixel.h"
 #include "Image.h"
 #include <vector>
#pragma once

 class StickerSheet{
   public:
     StickerSheet(const Image & picture, unsigned max);
     virtual ~StickerSheet();

     StickerSheet(StickerSheet const & other);


     StickerSheet const & operator= (StickerSheet const & other);

     void 	changeMaxStickers (unsigned max);
     int 	addSticker (Image &sticker, unsigned x, unsigned y);
     bool 	translate (unsigned index, unsigned x, unsigned y);
     void 	removeSticker (unsigned index);
     Image * 	getSticker (unsigned index);
     Image 	render () const;
     unsigned max1 = 1;
     std::vector<Image*> array;
     std::vector<unsigned int> array1;
     Image InPNG;
     Image OutPNG;

   private:

     void _Copy(StickerSheet const & other);
 };
