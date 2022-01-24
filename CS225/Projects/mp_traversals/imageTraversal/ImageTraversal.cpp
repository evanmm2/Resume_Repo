#include <cmath>
#include <iterator>
#include <iostream>

#include "../cs225/HSLAPixel.h"
#include "../cs225/PNG.h"
#include "../Point.h"

#include "ImageTraversal.h"

/**
 * Calculates a metric for the difference between two pixels, used to
 * calculate if a pixel is within a tolerance.
 *
 * @param p1 First pixel
 * @param p2 Second pixel
 * @return the difference between two HSLAPixels
 */
double ImageTraversal::calculateDelta(const HSLAPixel & p1, const HSLAPixel & p2) {
  double h = fabs(p1.h - p2.h);
  double s = p1.s - p2.s;
  double l = p1.l - p2.l;

  // Handle the case where we found the bigger angle between two hues:
  if (h > 180) { h = 360 - h; }
  h /= 360;

  return sqrt( (h*h) + (s*s) + (l*l) );
}

/**
 * Default iterator constructor.
 */
ImageTraversal::Iterator::Iterator() {
  /** @todo [Part 1] */
  type_ = NULL;
  flag = 0;
}

ImageTraversal::Iterator::Iterator(Point start, PNG png, double tolerance, ImageTraversal* type){
type_ = type;
tolerance_ = tolerance;
start_ = start;
curr_  = start;
png_ = png;
for(double i = 0; i < png.width() * png.height(); i++){
  truthChart.push_back(false);
}


flag = 0;
}


/**
 * Iterator increment opreator.
 *
 * Advances the traversal of the image.
 */
ImageTraversal::Iterator & ImageTraversal::Iterator::operator++() {
  /** @todo [Part 1] */

  // std::cout<<curr_.x<<" "<<curr_.y<<std::endl;
  truthChart[curr_.x + curr_.y*png_.width()] = true;
  Point right =  Point(curr_.x+1, curr_.y);  // (x+1, y)
  Point down  =  Point(curr_.x, curr_.y+1);  // (x, y-1)
  Point left  =  Point(curr_.x-1, curr_.y);  // (x-1, y)
  Point up    =  Point(curr_.x, curr_.y-1);  // (x, y+1)

  if(isValid(right)){         // If any of the locations are valid, push them onto the stack and update the truthChart
    type_->add(right);
     // std::cout<<right.x<<" ADDED TO STACK RIGHT "<<right.y<<std::endl;
  }
  if(isValid(down)){
    type_->add(down);
     // std::cout<<down.x<<" ADDED TO STACK DOWN "<<down.y<<std::endl;
  }
  if(isValid(left)){
    type_->add(left);
     // std::cout<<left.x<<" ADDED TO STACK LEFT "<<left.y<<std::endl;
  }
  if(isValid(up)){
    type_->add(up);
     // std::cout<<up.x<<" ADDED TO STACK UP "<<up.y<<std::endl;
    // std::cout<< "Peek top "<<type_->peek()<<std::endl;

  }
  if(truthChart[curr_.x + curr_.y*png_.width()]){              // Make it so that what is popped off can only be the next non visited thing
    while(truthChart[curr_.x + curr_.y*png_.width()]){
      // std::cout<<"Truth Chart False"<<std::endl;
      curr_  = type_->pop();
      if(type_->empty()){
        flag = 1;
        return *this;
      }
    }}
  return *this;
}

/**
Helper function that checks whether or not a point is valid
*/

bool ImageTraversal::Iterator::isValid(Point z){
  if(z.x >= png_.width() || z.y >= png_.height()){
    // std::cout<<"Outta Bounds False"<<std::endl;
    return false;
  }
  HSLAPixel original  = png_.getPixel(start_.x, start_.y);
  HSLAPixel current   = png_.getPixel(z.x, z.y);
  if(calculateDelta(original, current) >= tolerance_){
    // std::cout<<"Delta  False"<<std::endl;
    return false;
  }

  // std::cout<<"Truth Returned"<<std::endl;

  return true;

}



/**
 * Iterator accessor operator.
 *
 * Accesses the current Point in the ImageTraversal.
 */
Point ImageTraversal::Iterator::operator*() {
  /** @todo [Part 1] */


  return curr_;           // Shows us current traversal location
}

/**
 * Iterator inequality operator.
 *
 * Determines if two iterators are not equal.
 */
bool ImageTraversal::Iterator::operator!=(const ImageTraversal::Iterator &other) {
  /** @todo [Part 1] */
  if(flag == other.flag){
    return false;
  }
  return true;
}
