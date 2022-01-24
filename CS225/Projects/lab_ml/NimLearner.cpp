/**
 * @file NimLearner.cpp
 * CS 225: Data Structures
 */

#include "NimLearner.h"
#include <ctime>


/**
 * Constructor to create a game of Nim with `startingTokens` starting tokens.
 *
 * This function creates a graph, `g_` representing all of the states of a
 * game of Nim with vertex labels "p#-X", where:
 * - # is the current player's turn; p1 for Player 1, p2 for Player2
 * - X is the tokens remaining at the start of a player's turn
 *
 * For example:
 *   "p1-4" is Player 1's turn with four (4) tokens remaining
 *   "p2-8" is Player 2's turn with eight (8) tokens remaining
 *
 * All legal moves between states are created as Edges with initial weights
 * of 0.
 *
 * @param startingTokens The number of starting tokens in the game of Nim.
 */
NimLearner::NimLearner(unsigned startingTokens) : g_(true, true) {
    /* Your code goes here! */

    for(unsigned i = 0; i <= startingTokens; i++){
      Vertex vertexNum = "p1-" + std::to_string(i);
      g_.insertVertex(vertexNum);
      Vertex vertexNum2 = "p2-" + std::to_string(i);
      g_.insertVertex(vertexNum2);
    }
    int i = (int)startingTokens;
    while(i >= 2){   // Now we are going to set up the Edges. Do all until the last two
      Vertex p1_0 =  "p1-" + std::to_string(i);
      Vertex p1_1 =  "p1-" + std::to_string(i-1);
      Vertex p1_2 =  "p1-" + std::to_string(i-2);
      Vertex p2_0 =  "p2-" + std::to_string(i);
      Vertex p2_1 =  "p2-" + std::to_string(i-1);
      Vertex p2_2 =  "p2-" + std::to_string(i-2);

      g_.insertEdge(p1_0, p2_1);
      g_.insertEdge(p1_0, p2_2);
      g_.insertEdge(p2_0, p1_1);
      g_.insertEdge(p2_0, p1_2);

      g_.setEdgeWeight(p1_0, p2_1, 0);
      g_.setEdgeWeight(p1_0, p2_2, 0);
      g_.setEdgeWeight(p2_0, p1_1, 0);
      g_.setEdgeWeight(p2_0, p1_2, 0);

      i--;
    }
if(1==1){
    Vertex p1_0 =  "p1-" + std::to_string(i);
    Vertex p1_1 =  "p1-" + std::to_string(i-1);
    Vertex p2_0 =  "p2-" + std::to_string(i);
    Vertex p2_1 =  "p2-" + std::to_string(i-1);


    g_.insertEdge(p1_0, p2_1);
    g_.insertEdge(p2_0, p1_1);
    g_.setEdgeWeight(p1_0, p2_1, 0);
    g_.setEdgeWeight(p2_0, p1_1, 0);
  }
  startingVertex_ =  "p1-" + std::to_string(startingTokens);

}

/**
 * Plays a random game of Nim, returning the path through the state graph
 * as a vector of `Edge` classes.  The `origin` of the first `Edge` must be
 * the vertex with the label "p1-#", where # is the number of starting
 * tokens.  (For example, in a 10 token game, result[0].origin must be the
 * vertex "p1-10".)
 *
 * @returns A random path through the state space graph.
 */
std::vector<Edge> NimLearner::playRandomGame() const {
  vector<Edge> path;
 /* Your code goes here! */
  //Now we have to make it so that it goes along a path until there are no more left. // Have to make current the very first one
  //Starting Vertex is always p1 // How to find the total size of the graph vertices
  vector<Vertex> vs = g_.getVertices();   // Gives all the verteceis
  Vertex curr = "p1-" + std::to_string(vs.size()/2-1);

  while(curr != "p1-0" &&  curr != "p2-0"){
    vector<Vertex> next = g_.getAdjacent(curr);
    int x = std::rand() % next.size();         // Gets a rand # for the array between 0 and the size - 1;
    Edge pathWay = g_.getEdge(curr, next[x]);
    path.push_back(pathWay);
    curr = next[x];
  }

  return path;
}

/*
 * Updates the Edge weights on the graph based on a path through the state
 * tree.
 *
 * If the `path` has Player 1 winning (eg: the last vertex in the path goes
 * to Player 2 with no tokens remaining, or "p2-0", meaning that Player 1
 * took the last token), then all choices made by Player 1 (Edges where
 * Player 1 is the source vertex) are rewarded by increasing the Edge weight
 * by 1 and all choices made by Player 2 are punished by changing the Edge
 * weight by -1.
 *
 * Likewise, if the `path` has Player 2 winning, Player 2 choices are
 * rewarded and Player 1 choices are punished.
 *
 * @param path A path through the a game of Nim to learn.
 */
void NimLearner::updateEdgeWeights(const std::vector<Edge> & path) {
 /* Your code goes here! */
 Vertex last = path.back().dest;      // Gives the destination of the last one
 Vertex winner;
 if(last == "p1-0"){
   winner = "p2";
 }
 else{
   winner = "p1";
 }
 
for(unsigned i = 0; i < path.size(); i++){
// Get the first edge
  if(path[i].source.substr(0,2) == winner){     //If it's the winner, then set the edge weight for that one to be +1
    int weight = g_.getEdgeWeight(path[i].source, path[i].dest) + 1;
    g_.setEdgeWeight(path[i].source, path[i].dest, weight);
  }
  else{
    int weight = g_.getEdgeWeight(path[i].source, path[i].dest) - 1;
    g_.setEdgeWeight(path[i].source, path[i].dest, weight);
  }
}

}

/**
 * Label the Edges as "WIN" or "LOSE" based on a threshold.
 */
void NimLearner::labelEdgesFromThreshold(int threshold) {
  for (const Vertex & v : g_.getVertices()) {
    for (const Vertex & w : g_.getAdjacent(v)) {
      int weight = g_.getEdgeWeight(v, w);

      // Label all Edges with positve weights as "WINPATH"
      if (weight > threshold)           { g_.setEdgeLabel(v, w, "WIN"); }
      else if (weight < -1 * threshold) { g_.setEdgeLabel(v, w, "LOSE"); }
    }
  }
}

/**
 * Returns a constant reference to the state space graph.
 *
 * @returns A constant reference to the state space graph.
 */
const Graph & NimLearner::getGraph() const {
  return g_;
}
