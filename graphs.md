Graphs

1. Definition
a collection V of nodes and a collection E of edges

* Path
A path in an undirected graph G = (V, E) is a sequence of nodes $$$v_1, v_2, ..., v_k$$$ with the property that each consecutive pair $$$v_{i-1}, v_i$$$ is joined by an edge in E.  
  - Path is simple if all nodes are distinct
* Tree
an undirected graph is a tree if it is connected and does not contain a cycle

Fact
* Every n-node tree has exactly n − 1 edges
* Let G be an undirected graph on n nodes. Any two of the following statements implies the third.
(i) G is connected.
(ii) G does not contain a cycle.
(iii) G has n − 1 edges


Breadth First Search
- Explore all the nodes that s can reach. Also it computes the shortest paths to them
- Edge (x, y) in G. x, y differs by at most 1 in level

Depth First Search
- nontree edges can only connect ancestors to descendants
- Complexity of O(m+n)

#### Connected Components
any nodes in G, their connected components are either identical or disjoint

--> Produce all connected components: Grow one component at a time
* Start with arbitrary node, find its connected component
* Find a node v that was not visited, find its connected component
* So on

### Directed Graph
Directed graph is strongly connected if every two nodes u, v are mutually reachable.

BFS: computes all nodes that are reachable from s
--> BFS on G: set of nodes to which s has paths. BFS on $$$G^{rev}$$$: stet of nodes with paths to s

* Test if a directed graph is strongly connected?
  * pick any node s and run BFS in G. Run BFS on $$$G^{rev}$$$. These two searches need to reach every node.

#### Directed Acyclic Graphs & Topological Ordering

1. DAG: a directed graph with no cycles.

* If G has a topological ordering, then G is a DAG.

2. Compute A Topological Ordering
* In every DAG G, there is a node v with no incomming edges.
* if G is DAG, then G has a topolocial ordering.

Algorithm:
- Find a node v with no incoming edges and order it first
- Delete v from G
- Recursively compute a topological ordering of G−{v} and append this order after v
Complexity: O(n2)

Improved:
* Active node: node has not been deleted by algorithm. Maintain
  * Every node w, count number of incoming edges
  * A set S of active nodes that have no incoming edges from other active nodes
* At the start, compute those two values.
* Each iteration, get a node v from S, delete v from S & G. Update count of all outgoing w (decrease by 1), add to S if count = 0

