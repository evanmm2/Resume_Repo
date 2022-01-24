/**
 * @file NetworkFlow.cpp
 * CS 225: Data Structures
 */

#include <vector>
#include <algorithm>
#include <set>

#include "graph.h"
#include "edge.h"

#include "NetworkFlow.h"

int min(int a, int b) {
  if (a<b)
    return a;
  else return b;
}

NetworkFlow::NetworkFlow(Graph & startingGraph, Vertex source, Vertex sink) :
  g_(startingGraph), residual_(Graph(true,true)), flow_(Graph(true,true)), source_(source), sink_(sink) {

  // YOUR CODE HERE
  vector<Edge> pathway = g_.getEdges();     // Gets all of the edges of starting graph g and puts them in a vector

  for(size_t i = 0; i < pathway.size(); i++){   // Set edges of risidual and flow_
    Vertex start = pathway[i].source;
    Vertex end = pathway[i].dest;
    int x = g_.getEdgeWeight(start, end);
    flow_.insertEdge(start, end);
    flow_.setEdgeWeight(start, end, 0);
    residual_.insertEdge(start, end);
    residual_.setEdgeWeight(start, end, x);
    residual_.insertEdge(end, start);
    residual_.setEdgeWeight(end, start, 0);
  }

  maxFlow_ = 0;
}

  /**
   * findAugmentingPath - use DFS to find a path in the residual graph with leftover capacity.
   *  This version is the helper function.
   *
   * @param source  The starting (current) vertex
   * @param sink    The destination vertex
   * @param path    The vertices in the path
   * @param visited A set of vertices we have visited
   */

bool NetworkFlow::findAugmentingPath(Vertex source, Vertex sink,
  std::vector<Vertex> &path, std::set<Vertex> &visited) {

  if (visited.count(source) != 0)   // If source oesn't exist, return false
    return false;
  visited.insert(source);     // Insert the source into our path

  if (source == sink) {       // If the source is the same as the sink, exit
    return true;
  }

  vector<Vertex> adjs = residual_.getAdjacent(source);      // Make a vertex that gets the vertexes currently hooked up to the current vertex
  for(auto it = adjs.begin(); it != adjs.end(); it++) {       // Iterates through that vector
    if (visited.count(*it) == 0 && residual_.getEdgeWeight(source,*it) > 0) { // If it hasn't been visited yet, and the edge weight is greater than 0
      path.push_back(*it);                            // Push that next vevtor in
      if (findAugmentingPath(*it,sink,path,visited))
        return true;
      else {
        path.pop_back();
      }
    }
  }

  return false;
}

  /**
   * findAugmentingPath - use DFS to find a path in the residual graph with leftover capacity.
   *  This version is the main function.  It initializes a set to keep track of visited vertices.
   *
   * @param source The starting (current) vertex
   * @param sink   The destination vertex
   * @param path   The vertices in the path
   */

bool NetworkFlow::findAugmentingPath(Vertex source, Vertex sink, std::vector<Vertex> &path) {
   std::set<Vertex> visited;
   path.clear();
   path.push_back(source);
   return findAugmentingPath(source,sink,path,visited);
}

  /**
   * pathCapacity - Determine the capacity of a path in the residual graph.
   *
   * @param path   The vertices in the path
   */

int NetworkFlow::pathCapacity(const std::vector<Vertex> & path) const {
  // YOUR CODE HERE
  int x = std::numeric_limits<int>::max();
  for(size_t i = 0; i < path.size()-1; i++){
    if(residual_.getEdgeWeight(path[i], path[i+1]) < x){    // If they are lower than the previous x value, then decrease it to that minimum value
      x = residual_.getEdgeWeight(path[i], path[i+1]);
    }
  }

  return x;
}

  /**
   * calculuateFlow - Determine the capacity of a path in the residual graph.
   * Sets the member function `maxFlow_` to be the flow, and updates the
   * residual graph and flow graph according to the algorithm.
   *
   * @return The network flow graph.
   */

const Graph & NetworkFlow::calculateFlow() {
  // YOUR CODE HERE We need it find an augmented path.  Updated the graph with the new path until augmented path returns a false
  // Use augmentingpath to get a path of vertices from the original graph
  vector<Vertex> path;
  bool x = findAugmentingPath(source_, sink_, path);
  while(x){   // If the first augmenting path is good, then we go into our while loop
      //At this point, path should be the vertices that are necessary for the path, first lets update the main graph, then we'll update residual
      // We need to check if it's one way or another in the original graph
      int y = pathCapacity(path);
      for(size_t i = 0; i < path.size()-1; i++){
          // So we'll first check if edge exists, if it does, then we add the maxflow. If not, then we subtract the max flow
          Vertex start =  path[i];
          Vertex end   =  path[i+1];

          if(flow_.edgeExists(start, end)){
            flow_.setEdgeWeight(start, end, flow_.getEdgeWeight(start, end) + y);
          }
          else{
            flow_.setEdgeWeight(end, start, flow_.getEdgeWeight(end, start) - y);
          }

          //Now we update the residual graph. We subtract it from the current path, add it to the other side
          residual_.setEdgeWeight(start, end, residual_.getEdgeWeight(start, end) - y);
          residual_.setEdgeWeight(end, start, residual_.getEdgeWeight(end, start) + y);

          if(end == sink_){
            maxFlow_ = maxFlow_ + y;
          }
      }



    x = findAugmentingPath(source_, sink_, path);   // We find the next path, if there is one
  }


  return flow_;
}

int NetworkFlow::getMaxFlow() const {
  return maxFlow_;
}

const Graph & NetworkFlow::getGraph() const {
  return g_;
}

const Graph & NetworkFlow::getFlowGraph() const {
  return flow_;
}

const Graph & NetworkFlow::getResidualGraph() const {
  return residual_;
}
