#include "Graph.h"
#include "Edge.h"
#include "Vertex.h"

#include <string>
#include <iostream>

/**
* @return The number of vertices in the Graph
*/
template <class V, class E>
unsigned int Graph<V,E>::numVertices() const {
  // TODO: Part 2
  return vertexMap.size();
}


/**
* The degree of the vertex. For directed: Sum of in-degree and out-degree
* @return Returns the degree of a given vertex.
* @param v Given vertex to return degree.
*/
template <class V, class E>
unsigned int Graph<V,E>::degree(const V & v) const {
  // TODO: Part 2

  return adjList.find(v.key())->second.size();

}


/**
* Inserts a Vertex into the Graph.
* @param key The key of the Vertex to insert
* @return The inserted Vertex
*/
template <class V, class E>
V & Graph<V,E>::insertVertex(std::string key) {
  // TODO: Part 2
  V & v = *(new V(key));  // What do we need to do? We need to add the vertex in. We also need to add the vertex to the potential adjacency graph
  V_byRef vex = std::ref(v);
  vertexMap.insert({key, vex});
  std::list<edgeListIter> edges = *(new std::list<edgeListIter>()); // List that iterates through the adjacent edges for that vertex
  adjList.insert({key, edges});
  return v;                 // Returns the new vertex that has been made
}


/**
* Removes a given Vertex
* @param v The Vertex to remove
*/
template <class V, class E>
void Graph<V,E>::removeVertex(const std::string & key) {//When we remove a vertex, we also have to update the graph
  // TODO: Part 2 So we get all adjacent edges and delete them. We also remove the vertex from vertexMap and adjList
  std::list<std::reference_wrapper<E>> edges = incidentEdges(key);
  for(auto it = edges.begin(); it!=edges.end(); it++){    //get() gets the wrapper variable that it's hiding
    // std::cout<<edgeList.size()<<std::endl;
    removeEdge((*it).get().source().key(), (*it).get().dest().key()); //Access the wrapper from iterator, get gets edge, dest gets dest, key gets the key
    // std::cout<<edgeList.size()<<std::endl;                                                                  //for the remove edge function
  }
  auto x = vertexMap.begin();
  while((*x).first != key){
    x++;
  }
  auto y = adjList.begin();
  while((*y).first != key){
    y++;
  }
  vertexMap.erase(x); // Only deletes these keys from our map because we are getting rid of their associated vertexes
  adjList.erase(y);
}


/**
* Inserts an Edge into the Graph.
* @param v1 The source Vertex
* @param v2 The destination Vertex
* @return The inserted Edge
*/
template <class V, class E>
E & Graph<V,E>::insertEdge(const V & v1, const V & v2) {
  // TODO: Part 2
  E & e = *(new E(v1, v2));           // Makes a new edge. New edge has to be shoved into adjacency list. Edge has to be put into list
  edgeList.push_front(std::ref(e));     // Have to insert at front not back because when getting the iterator, the end will give a value we don't want and we can't come back from
  // Now need to insert into adjacency list // Need to add it to the lists //need to convert it into a listiterator from edges
  std::list<edgeListIter> edges = adjList.find(v1.key())->second;  //find returns an iterator. The second is the list of edges
  edgeListIter edge = edgeList.begin(); //Gets the iterator of the edge we are adding
  edges.push_back(edge);                // Adds the iterator to the vector
  //std::cout<<adjList[v1.key()].size()<<std::endl;
  adjList[v1.key()] = edges;            // Replaces the old edges with the new one with the extra edge
//  std::cout<<adjList[v1.key()].size()<<std::endl;
  std::list<edgeListIter> edges2 = adjList.find(v2.key())->second;  //find returns an iterator. The second is the list of edges
  edgeListIter edge2 = edgeList.begin(); //Gets the iterator of the edge we are adding
  edges2.push_back(edge2);                // Adds the iterator to the vector
  adjList[v2.key()] = edges2;            // Replaces the old edges with the new one with the extra edge


  return e;       // Returns the inserted edges as requested
}


/**
* Removes an Edge from the Graph. Consider both the undirected and directed cases.
* min(degree(key1), degree(key2))
* @param key1 The key of the source Vertex
* @param key2 The key of the destination Vertex
*/
template <class V, class E>
void Graph<V,E>::removeEdge(const std::string key1, const std::string key2) {
  // TODO: Part 2     // If the edge is removed, then delete it from the edgeList. Get rid of the missing adjacencies. Vertices stay
  // Check both vertices and delete the edges from both adjacency graphs
  V & v1 = vertexMap.find(key1)->second;    // Finds the first vector
  V & v2 = vertexMap.find(key2)->second;    // Finds the second vector
  // Need to get rid of edge from the edges list. Need to get the iterator to know what to delete from our graphs and stuff
  std::list<E_byRef> newList;
  E edge1  = E(v1, v2);
  edgeListIter remover1;
  E_byRef ex = std::ref(edge1);
  int counter = 1;
  std::list<edgeListIter> vertex1;
  std::list<edgeListIter> vertex2;

  for(edgeListIter it = edgeList.begin(); it != edgeList.end(); it++){
    if(edge1 == (*it)){
      remover1 = it;

    }
    else{
      E_byRef ed = std::ref(*it);
      newList.push_back(ed);
      // std::cout<<"It found the edge to keep " <<counter<<std::endl;
      counter = counter + 1;
    }

    if(edge1 == (*it)){
    //  std::cout<<"Exited"<<std::endl;
      continue;
    }

    if((*it).get().source() == v1 || v1 == (*it).get().dest()) {   //Make the replacement vector for the source vertex
      vertex1.push_back(it);      // So if vertex one is in that list, but the rejected edge isn't, add it
    }
    if((*it).get().source() == v2 || v2 == (*it).get().dest()) {   //Make the replacement vector for the source vertex
      vertex2.push_back(it);    // Same as above

    }

  }

  // The problem is that removing it deletes it. Maybe make it a new value and then immediatly delete it
  //Make a new vector of the edges of each using the for loop, and then just replace the vector with the new one that is excluding the lost iterator
  //Remove that iterator at the very end. We should only have to do it for the first one. Actually, both should be good because they remove their
  //respective edges.
  adjList.find(v1.key())->second = vertex1;
  adjList.find(v2.key())->second = vertex2;
  // std::cout<<edgeList.size() <<std::endl;
  edgeList.erase(remover1);       // Can't directly remove it for some reason. No clue why, so replace it with a list of everthing but the removed edge
  // std::cout<<edgeList.size() <<std::endl;
}


/**
* Removes an Edge from the Graph given by the location of the given iterator into the edge list.
* @param it An iterator at the location of the Edge that
* you would like to remove
*/
template <class V, class E>
void Graph<V,E>::removeEdge(const edgeListIter & it) {
  // TODO: Part 2
  V & v1 = (*it).get().source;    // Finds the first vector
  V & v2 = (*it).get().dest;    // Finds the second vector
  // Need to get rid of edge from the edges list. Need to get the iterator to know what to delete from our graphs and stuff
  std::list<E_byRef> newList;
  E edge1  = E(v1, v2);
  E_byRef ex = std::reference_wrapper<E>(edge1);
  edgeListIter remover1;
  std::list<edgeListIter> vertex1;
  std::list<edgeListIter> vertex2;
  for(edgeListIter it = edgeList.begin(); it != edgeList.end(); it++){
    if(edge1 == (*it)){
      remover1 = it;
    }
    else{
      E_byRef ed = std::ref(*it);
      newList.push_back(ed);
    }

    if(edge1 == (*it)){
      continue;
    }

    if((*it).get().source() == v1 || v1 == (*it).get().dest()) {   //Make the replacement vector for the source vertex
      vertex1.push_back(it);      // So if vertex one is in that list, but the rejected edge isn't, add it
    }
    if((*it).get().source() == v2 || v2 == (*it).get().dest()) {   //Make the replacement vector for the source vertex
      vertex2.push_back(it);    // Same as above
    }

  }

  // The problem is that removing it deletes it. Maybe make it a new value and then immediatly delete it
  //Make a new vector of the edges of each using the for loop, and then just replace the vector with the new one that is excluding the lost iterator
  //Remove that iterator at the very end. We should only have to do it for the first one. Actually, both should be good because they remove their
  //respective edges.
  adjList.find(v1.key())->second = vertex1;
  adjList.find(v2.key())->second = vertex2;

  edgeList.erase(remover1);       // Can't directly remove it for some reason. No clue why, so replace it with a list of everthing but the removed edge
}


/**
* Return the list of incident edges from a given vertex.
* For the directed case, consider all edges that has the vertex as either a source or destination.
* @param key The key of the given vertex
* @return The list edges (by reference) that are adjacent to the given vertex
*/
template <class V, class E>
const std::list<std::reference_wrapper<E>> Graph<V,E>::incidentEdges(const std::string key) const {
  // TODO: Part 2
  std::list<std::reference_wrapper<E>> edges;
  std::list<edgeListIter> edgeAdj = adjList.find(key)->second; // Second is the list of iterators

  for(auto it = edgeAdj.begin(); it != edgeAdj.end(); it++){    // Apparently auto works. Thanks StackExchange
    edges.push_back((**it));    // Iterator of iterators. Pretty freaky, but it goes over the iterators and takes the wrapped edges from inside
  }

  return edges;
}


/**
* Return whether the two vertices are adjacent to one another. Consider both the undirected and directed cases.
* When the graph is directed, v1 and v2 are only adjacent if there is an edge from v1 to v2.
* @param key1 The key of the source Vertex
* @param key2 The key of the destination Vertex
* @return True if v1 is adjacent to v2, False otherwise
*/
template <class V, class E>
bool Graph<V,E>::isAdjacent(const std::string key1, const std::string key2) const {
  // TODO: Part 2
  V & v2 = vertexMap.find(key2)->second;    // Gets the Second vertex that lines up with this key
  std::list<std::reference_wrapper<E>> edges = incidentEdges(key1);   // Gets the adjacent edges
  for(edgeListIter it = edges.begin(); it != edges.end(); it++){
    if((*it).get().dest() == v2){       // If any of the edges from v1 have a destination at key2, then the two keys are adjacent
      return true;
    }
  }


  return false;
}
