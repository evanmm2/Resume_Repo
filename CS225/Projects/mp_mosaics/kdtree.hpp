/**
 * @file kdtree.cpp
 * Implementation of KDTree class.
 */

#include <utility>
#include <algorithm>

using namespace std;

template <int Dim>
bool KDTree<Dim>::smallerDimVal(const Point<Dim>& first,
                                const Point<Dim>& second, int curDim) const
{
    /**
     * @todo Implement this function!
     */
     if(first[curDim] <  second[curDim]){
        return true;
      }
     if(first[curDim] == second[curDim]){
       if(first < second){
         return true;
       }
     }

    return false;
}

template <int Dim>
bool KDTree<Dim>::shouldReplace(const Point<Dim>& target,
                                const Point<Dim>& currentBest,
                                const Point<Dim>& potential) const
{
    /**
     * @todo Implement this function!
     */
     int distance1 = 0;
     int distance2 = 0;
     for(int i = 0; i < Dim; i++){
       distance1 = distance1 + (target[i] - potential[i])*(target[i] - potential[i]);
       distance2 = distance2 + (target[i] - currentBest[i])*(target[i] - currentBest[i]);
     }
     if(distance1 < distance2){
       return true;
     }
     if(distance1 == distance2){
       if(potential < currentBest){
         return true;
       }
     }

     return false;
}

template <int Dim>
KDTree<Dim>::KDTree(const vector<Point<Dim>>& newPoints)
{
    /**
     * @todo Implement this function!
     */
     pointArray = newPoints;
     if(newPoints.size() == 0){
       return;
     }
     if(newPoints.size() == 1){
       root->point = newPoints[0];
       return;
     }

    construct(root, 0, newPoints.size()-1, 0); // Constructs with array location zero to max

}


template<int Dim>
void KDTree<Dim>::construct(KDTreeNode* &subroot, int left, int right, int dimension){
  if(left > right ){
    return;
  }
  int mid = (left+right)/2;
  subroot = quickSelect(left, right, mid, dimension);  // Find the middle of this partition
  // std::cout<<subroot->point<<std::endl;
  // std::cout << left << right << dimension << std::endl;
  construct(subroot->left, left, mid-1, (dimension+1) % Dim);     // Goes down left partition
  // std::cout << left << right << dimension << std::endl;
  construct(subroot->right, mid+1, right, (dimension+1) % Dim );  // Goes down the right partition
}

template <int Dim>
typename KDTree<Dim>::KDTreeNode* KDTree<Dim>::quickSelect(int left, int right, int midpoint, int dimension){
  if(left >= right){

    return new KDTreeNode(pointArray[midpoint]);
  }
  int sortIdx = partition(left, right, (left+right)/2, dimension);

  if(sortIdx < midpoint){
    return quickSelect(sortIdx+1, right, midpoint, dimension);
  }
  else if(sortIdx > midpoint){
    return quickSelect(left, sortIdx-1, midpoint, dimension);
  }
  return new KDTreeNode(pointArray[sortIdx]);
}

template <int Dim>
int KDTree<Dim>::partition(int left, int right, int mid, int dimension){
    Point<Dim> pivot = pointArray[mid];
    int swapIdx = left;
    swap(pointArray[mid], pointArray[right]);
    for(int i = left; i < right; i++){
      if(smallerDimVal(pointArray[i], pivot, dimension)){
        swap(pointArray[i], pointArray[swapIdx]);
        swapIdx = swapIdx + 1;
      }
    }
    swap(pointArray[right], pointArray[swapIdx]);
    return swapIdx;
}

template <int Dim>
KDTree<Dim>::KDTree(const KDTree<Dim>& other) {
  /**
   * @todo Implement this function!
   */
   pointArray = other.pointArray;
   root = other.root;
   size = other.size;
   distance = other.distance;
}

template <int Dim>
const KDTree<Dim>& KDTree<Dim>::operator=(const KDTree<Dim>& rhs) {
  /**
   * @todo Implement this function!
   */


  return *this;
}

template <int Dim>
KDTree<Dim>::~KDTree() {
  /**
   * @todo Implement this function!
   */
}

template <int Dim>
Point<Dim> KDTree<Dim>::findNearestNeighbor(const Point<Dim>& query) const
{
    /**
     * @todo Implement this function!
     */
     if(pointArray.size() == 0){
       return root->point;
     }
     cout<<query<<endl;
     Point<Dim> pivot = query;
     double distance = 0;
     int elem = 0;
     KDTreeNode* node = root;
     KDTreeNode* currentBest = root;
    recursiveHelper(distance, elem, node, currentBest, query);   //Sets best node and the radius

    return currentBest->point;
}
template<int Dim>
void KDTree<Dim>::recursiveHelper( double & distance, int elem,  KDTreeNode* node, KDTreeNode*& currentBest,  Point<Dim> query) const{



if(node == NULL){
  printf("NULL \n");
  return;
}


if(node->point == query){
  currentBest = node;
  distance = 0;
}

cout<<node->point<<endl;
if(node->left == NULL){                         // If it's a leaf node then either make it the best, or do nothing if it's not the best
  if(node->right == NULL){
    printf("Leaf");
    if(currentBest == NULL)
    currentBest = node;
    distance = getDistance(query, node->point);
    return;
    }
    else if(shouldReplace(query, currentBest->point, node->point)){
      currentBest = node;
      distance = getDistance(query, node->point);
      return;
    }
}

 if(node->left == NULL){                     // If the node to the left is NULL
  printf("Recursive Helper0 Called");
recursiveHelper( distance, (elem + 1) % Dim, node->right, currentBest, query);
  if(shouldReplace(query, currentBest->point, node->point)){    // If the parent node is better than the child node, then replace
    currentBest = node;
    distance = getDistance(query, currentBest->point);
  }             // No need to recurse down the left hand side, because it doesn't exist
}

else if(node->right == NULL){             // If the node to the right is NULL
  printf("Recursive Helper1 Called");
recursiveHelper(distance, (elem + 1) % Dim,node->left, currentBest, query);
if(shouldReplace(query, currentBest->point, node->point)){
  currentBest = node;
  distance = getDistance(query, currentBest->point);
  }                                   // No need to recurse down the left hand side, because it doesn't exist
}

else if(!smallerDimVal(node->point, query, elem%Dim)){             // If node point is less, go left
  printf("Recursive Helper2 Called");
    // If the left value is less than the value on the right
recursiveHelper(distance, (elem + 1) % Dim, node->left, currentBest, query);   // Runs recursive helper on left node
if(shouldReplace(query, currentBest->point, node->point)){
  currentBest = node;
  distance = getDistance(query, currentBest->point);}
if(getDistance(query, node->right->point) <= distance){
  printf("Recursive Double");                                       // If the right is still in the radius
    recursiveHelper(distance, (elem+1) % Dim, node->right, currentBest, query);
  }

}


else if(smallerDimVal(node->point, query, elem%Dim)){          // Send it checking right first
  printf("Recursive Helper3 Called");
  // If right is less than left
    recursiveHelper(distance, (elem + 1) % Dim, node->right, currentBest, query); // Runs recursive helper on the right node
    if(shouldReplace(query, currentBest->point, node->point)){
      currentBest = node;
      distance = getDistance(query, currentBest->point);}                // If the parent node is better, change what it should be
      if(getDistance(query, node->left->point) <= distance){
        recursiveHelper(distance, (elem+1) % Dim, node->left, currentBest, query); // If the other node is still in radius
      }
  }
  printf("Reaches end\n");
}


template<int Dim>
double KDTree<Dim>::getDistance(const Point<Dim>& point0, const Point<Dim> & point1) const{
  double distance1 = 0;
  for(int i = 0; i < Dim; i++){
    distance1 = distance1 + (point0[i]- point1[i])*(point0[i] - point1[i]);
  }
  return distance1;
}
