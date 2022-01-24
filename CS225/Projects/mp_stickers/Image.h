/**
 * @file Image.h
 * Contains your declaration of the interface for the Image class.
 */
 #include "cs225/PNG.h"
 #include "cs225/HSLAPixel.h"

#pragma once

class Image : public cs225::PNG{

  public:
    

    unsigned int width1;
    unsigned int height1;

    Image();                                    // Loading Functions


    void darken();                              // Implementation Functions
    void darken(double amount);
    void desaturate();
    void desaturate(double amount);
    void grayscale();
    void illinify();
    void lighten();
    void lighten(double amount);
    void rotateColor(double degrees);
    void saturate();
    void saturate(double amount);
    void scale(double factor);
    void scale(unsigned w, unsigned h);


    virtual ~Image();                           // Deconstructor




  private:

};
