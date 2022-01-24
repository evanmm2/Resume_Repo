#include <queue>
#include <algorithm>
#include <string>
#include <list>

/**
 * Returns an std::list of vertex keys that creates any shortest path between `start` and `end`.
 *
 * This list MUST include the key of the `start` vertex as the first vertex in the list, the key of
 * the `end` vertex as the last element in the list, and an ordered list of all vertices that must
 * be traveled along the shortest path.
 *
 * For example, the path a -> c -> e returns a list with three elements: "a", "c", "e".
 *
 * You should use undirected edges. Hint: There are no edge weights in the Graph.
 *
 * @param start The key for the starting vertex.
 * @param end   The key for the ending vertex.
 */
template <class V, class E>
std::list<std::string> Graph<V,E>::shortestPath(const std::string start, const std::string end) {
  // TODO: Part 3
  std::list<std::string> path;    // We will be going through all possible paths.
  // We should make a list of all possible vectors, and every time we find a smaller vector, we make that the path at the end
  // How is it going to do that? It is going to go through all of the adjacent edges and push back the vertices each time it goes through one
  // If it has been through an edge before, it doesn't do that edge again, because then it cannot possibly be a shorter path
  // We know that we've visited all edges
  // Give every vertex a weight with it. If the weight of a vertex connected to it
// unordered_map<string, double> vertices; // If it checks each edge as it radiates out, then the moment it arrives at the end it exits with the path
// V & vertex = Vertex(start);             // Get start vertex
// vertices.insert({start, 0});
// queue<V &> toVisit;
// while(vertex.key() != end){
//   std::list<E_byRef> edges = incidentEdges(vertex);
//
//   for(int i  = 0; i < edges.size(); i++){ // Go through each of the edges from the vertex and add them to the map
//     push_back()
//     if(){
//
//         }
//  unordered_map<string, int> dist;
//  unordered_map<string, bool> visited;
//  unordered_map<string, string> predecessor;
//  queue<string> vertex;
//
// for(auto it = vertexMap.begin(); it != vertexMap.end(); it++)
//   visited[it->second.get().key()] = FALSE;
//   dist[it->second.get().key()] = std::numeric_limits<int>::max();
//   predecessor[it->second.get().key()] = "";
//   }
//   dist[start] = 0;
//   visited[start] = TRUE;
//   vertex.push(start);
//   for(int i = 0; i < vertexMap.size(); i++){  // We will go through and apply a value to every edge now
//       //  Get the edges
//       vertex1 = vertex.front(); // Updates the vertex we are looking at
//       vertex.pop();
//     std::list<E_byRef> incidentEdges = incidentEdges(vertex1);  // This will get all edges connected. We only want the ones we haven't seen yet
//     for(auto it = incidentEdges.begin(); it != incidentEdges.end(); it++){  // Apply values if we haven't seen the vertex yet
//       if(!visited[it->get().dest()]){  // If the destination hasn't been visited yet from the perspective of this node, then update values
//         dist[it->get().dest()]  = dist[vertex1] + 1;
//         visited[it->get().dest()] = TRUE;
//       }
//       if(it->get().dest() == end){
//         break;
//       }
//     }
//   }
// //At this point, we now have the distance vertex graph
// string verts
// while(verts != end){
//
//
//
// }
//   return path;
// }


std::unordered_map<string, double> dist;
std::unordered_map<string, bool> visited;
std::unordered_map<string, string> predecessor;

 for(auto it = vertexMap.begin(); it != vertexMap.end(); it++){
   dist[(*it).second.get().key()] = std::numeric_limits<int>::max();    // Initializes all of our mappers
   predecessor[(*it).second.get().key()] = "";
   visited[(*it).second.get().key()] = false;
 }
 dist[start] = 0;


 for(unsigned i = 0; i < vertexMap.size(); i++){
   double min = std::numeric_limits<int>::max();
   string key = "";
   for(auto it=dist.begin(); it != dist.end(); it++){
     if(visited[(*it).first] == false && dist[(*it).first] < min){  // If the vertex value has been set, but it it hasn't been visited yet
       key = (*it).first;      // Takes the minimum out of the vertexes that have been visited
       min = (*it).second;        // Takes the value of that vertex, so it's making sure to visit each of these vertices one at a time.
     }
   }

   std::list<E_byRef>  edges = incidentEdges(key);   // Gets the edges to set the weight for the next cycle
   for(auto it = edges.begin(); it != edges.end(); it++){ //sets the vertex values for each of the new edges
     if((*it).get().dest().key() != key){              //If the edge is outgoing
       string vertex = (*it).get().dest().key();           // Get the vertex we are going to mess with
       if( 1 + dist[key] < dist[vertex]){
         dist[vertex] = 1 + dist[key];                     // Weights of the edges are all 1
         predecessor[vertex] = key;                        //
          }
        }
     else{
       string vertex = (*it).get().source().key();            // If the edge is incoming. Remember, it's biderectional
       if( 1 + dist[key] < dist[vertex]){                  // If that vertex location already has a number and it is not smaller than the next one
         dist[vertex] = 1 + dist[key];
         predecessor[vertex] = key;
       }
     }
   }
   visited[key] = true;        // It has now visited the vertex that we are looking at
 }
 string final = end;
 while(final != start){   // Because it got to the final in the predecessor graph, we just have to back track from there
   path.push_front(final);
   final = predecessor[final];
 }
 path.push_front(final);    // Won't do this one inside the while loop

  return path;
}



//
