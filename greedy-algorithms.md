Greedy Algorithm

## Interval Scheduling
A set of requests, each corresponds to an interval of time starting at s and finishing at f. A subset of requests is _compatible_ if no two of them overlap in time.
Find as large a compatible subset as possible.

#### Greedy Algorithm
>Natural idea: ensure that our reosoures become free as soon as possible while still satisfying one request.

```
Initially let R be the set of all requests, and let A be empty
While R is not yet empty
  Choose a request i ∈ R that has the smallest finishing time
  Add request i to A
  Delete all requests from R that are not compatible with request i
EndWhile
Return the set A as the set of accepted requests
```

>Analysis
>- sort requests in order of finishing time: O(nlogn)
>- iterate through the intervals in order until reacing the first interval starting no sooner than the latest selected interval. This takes time O(n)

### Extension
#### Scheduling All Intervals
We have many identical resources and wish to schedule all the requests using as few resources as possible.
-> Paritiion all intervals across multiple resources: *Interval Partitioning*

* The number of resources needed is at least the depth of the set of intervals

Algorithm: One-pass greedy strategy that orders intervals by starting times. Go through intervals by this order, and try to assign each interval we encounter a label that hasn't already been assigned to any previous interval that overlaps it.
```
Sort the intervals by their start times, breaking ties arbitrarily
Let I1, I2, . . . , In denote the intervals in this order
For j = 1, 2, 3, . . . , n
  For each interval Ii that precedes Ij in sorted order and overlaps it
    Exclude the label of Ii from consideration for Ij
  Endfor
  If there is any label from {1, 2, . . . , d} that has not been excluded then
    Assign a nonexcluded label to Ij
  Else
    Leave Ij unlabeled
  Endif
Endfor
```
> Analysis
> - If use above algorithm, every interval will be assigned a label, no two overlapping intervals will receive the same label
> - The greedy algorithm above schedules every interval on a resource, using a numbef of resources equal to the depth of the set of intervals. This is the optimal number of resources needed.

## Scheduling to Minimize Lateness: An Exchange Argument
A set of requests, each has a deadline d and requires a contiguous time interval of length t. A request is late if it misses the deadline. The goal is to schedule all reequests using nonoverlapping intervals to minimize the maximum lateness.

#### Design the algorithm
* schedule the jobs in order of increasing length t. Too simplistic since ignoring the deadlines.
* Sort job in order of increasing slack time d - t. Failed: two jobs t1 = 1, d1=2, t2=10, d2=10.

##### Earliest Dealdine First
Sort the job in increasing order of their deadlines d and schedule them in this order

#### Analyzing the algorithm
> There is an optimal schedule with no idle time
>
A schedule A' has an inversion if job i is scheduled before job j and di > dj.
> All schedules with no inversions and no idle time have the same maximum lateness.

> There is an optimal schedule that has no inversions and no idle time.
> 
Therefore, 
> The schedule A produced by *Earliest Deadline First* has optimal maximum lateness L.
> 

## Optimal Caching
Given the full sequences S of memory refererences, what is the eviction schedule that incurs as few cache misses as possible?

#### Design Algorithm
##### Farthest-in-Future
```
When di needs to be brought into the cache,
  evict the item that is needed the farthest into the future
```

A schedule is reduced if it only brings in items in a step when it is requested.

Let $$$\bar{S}$$$ - the reduction of S. In any step i where S brings in an item d that has not been requested, $$$\bar{S}$$$ pretends to do this but leaves d in main memory. It only brings d into the cache in step j when d is requested.

> Recuded schedule $$$\bar{S}$$$ brings in at most as many items as the schedule S
> 

Let SFF denote the schedule produced by Farthest-in-Future

> Let S be a reduced schedule that makes the same eviction decisions as SFF through the first j items in the sequence, for a number j. Then there is a reduced schedule S' that makes the same eviction decisions as SFF through the first j + 1 items, and incurs no more misses than S does
> 

>SFF incurs no more misses than any other schedule S∗ and hence is optimal.
>

## Shortest Paths in a Graph 
Given a directed graph G = (V, E), with a designated start node s. Assume that s has a path to every other node in G. Each edge e has a length le ≥ 0,indicating the time (or distance, or cost) it takes to traverse e. Our goal is to determine the shortest path from s to every other node in the graph. 

#### Design Algorithm
##### Dijkstra's Algorithm
```
Dijkstra’s Algorithm (G, l)
Let S be the set of explored nodes
  For each u ∈ S, we store a distance d(u)
Initially S = {s} and d(s) = 0
While S # V
  Select a node v /∈ S with at least one edge from S for which
    d'(v) = min e=(u,v):u∈S d(u) + le is as small as possible
  Add v to S and define d(v) = d'(v)
EndWhile
```

> Algorithm is not applied if there are any negative lengths.
> 
*Implementation & Running Time*
Use a priority queue to store nodes not in S: key is the min length. 
- Update key occur at most one per edge: ChangeKey
- ExtractMin once for each new node.

> Using a priority queue, Dijkstra’s Algorithm can be implemented on a graph with n nodes and m edges to run in O(m) time, plus the time for n ExtractMin and m ChangeKey operations.
> 
Use heap-based priority queue, each operation can be made to run in O(logn) time. Overall time is O(mlogn)

## The Minimum Spanning Tree

a set of locations V = {v1, v2, . . . , vn}, and we want to build a communication network on top of them. The network should be connected— there should be a path between every pair of nodes—but subject to this requirement, we wish to build it as cheaply as possible.

> Let T be a minimum-cost solution to the network design problem defined above. Then (V, T) is a tree
> 
#### Design Algorithm
* Kruskal's Algorithm: start without edges. Insert each edge in order of increasing cost as long as it does not create a cycle when added to the edges we've already inserted.
* Prim's Algorithm: set S = {s}. Grow S by one node in each iteration, addinng the node that minimizes the attachment cost.
* Reverse-Delete Algorithm: Start with full graph. Delete edges in order of decreasing cost as long as it does not disconnect the graph.

#### Analyzing
Assume all deges costs are distinct
*Cut Property*
> Assume that all edge costs are distinct. Let S be any subset of nodes that is neither empty nor equal to all of V, and let edge e = (v, w) be the minimumcost edge with one end in S and the other in V − S. Then every minimum spanning tree contains the edge e
> 

When Can We Guarantee an Edge Is Not in the Minimum Spanning Tree? 
*Cycle Property*
> Assume that all edge costs are distinct. Let C be any cycle in G, and let edge e = (v, w) be the most expensive edge belonging to C. Then e does not belong to any minimum spanning tree of G.
> 
Eliminating the Assumption that All Edge Costs Are Distinct
* perturb all edges cost by different, extremely small numbers, so that they all become distinct. Any minimum spanning tree T for the new, perturbed instance must have also been a MST for the original instance.

#### Implementing Prim's Algorithm
Use priority queue to store attachment cost. 
> Using a priority queue, Prim’s Algorithm can be implemented on a graph with n nodes and m edges to run in O(m) time, plus the time for n ExtractMin, and m ChangeKey operations.
> 

## Implementing Kruskal's Algorithm: The Union-Find Data Structure
Union-Find data structure
* MakeUnionFind(S) for a set S will return a Union-Find data structure on set S where all elements are in separate sets. implement MakeUnionFind in time O(n)
* For an element u ∈ S, the operation Find(u) will return the name of the set containing u. Our goal will be to implement Find(u) in O(log n) time
* For two sets A and B, the operation Union(A, B) will change the data structure by merging the sets A and B into a single set. Our goal will be to implement Union in O(log n) time

set up an array Component of size n, where Component[s]is the name of the set containing s. To implement MakeUnionFind(S), we set up the array and initialize it to Component[s]= s for all s ∈ S.

> Consider the array implementation of the Union-Find data structure for some set S of size n, where unions keep the name of the larger set. The Find operation takes O(1) time, MakeUnionFind(S) takes O(n) time, and any sequence of k Union operations takes at most O(k log k) time

Each node v ∈ S will be contained in a record with an associated pointer to the name of the set that contains v. As before, we will use the elements of the set S as possible set names, naming each set after one of its elements. For the MakeUnionFind(S) operation, we initialize a record for each element v ∈ S with a pointer that points to itself (or is defined as a null pointer), to indicate that v is in its own set.
>Consider the above pointer-based implementation of the Union-Find data structure for some set S of size n, where unions keep the name of the larger set. A Union operation takes O(1) time, MakeUnionFind(S) takes O(n) time, and a Find operation takes O(log n) time.

Algorithm
* sort the edges by cost. O(mlogm) ~ O(mlogn)
* For each edge, Find(u), Find(v) & Union if include edge. At most 2m Find & n -  1 Union

> Kruskal’s Algorithm can be implemented on a graph with n nodes and m edges to run in O(m log n) time.
> 

## Clustering