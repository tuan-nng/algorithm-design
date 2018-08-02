Devide And Conquer

## The Mergesort Algorithm

Divide the input into two pieces of equal size; solve the two subproblems on these pieces separately by recursion; and then combine the two results into an overall solution, spending only linear time for the initial division and final recombining.

Running time
> (1) For some constant c, T(n) ≤ 2T(n/2) + cnwhen n > 2, 
> and T(2) ≤ c.

#### Approaches to Solving Recurrences

* “unroll” the recursion, accounting for the running time across the first few levels, and identify a pattern that can be continued as the recursion expands. One then sums the running times over all levels of the recursion (i.e., until it “bottoms out” on subproblems of constant size) and thereby arrives at a total running time.
* start with a guess for the solution, substitute it into the recurrence relation, and check that it works. Formally, one justifies this plugging-in using an argument by induction on n. There is a useful variant of this method in which one has a general form for the solution, but does not have exact values for all the parameters. By leaving these parameters unspecified in the substitution, one can often work them out as needed.

> Any function T(·) satisfying (1) is bounded by O(n log n), when n > 1.

## Further Recurrence Relations

> (3) For some constant c, T(n) ≤ qT(n/2) + cn when n > 2, and T(2) ≤ c.
> 
#### q > 2 subproblems
> Any function T(·) satisfying (5.3) with q > 2 is bounded by O(n^(log_2 q)).
> 

#### q = 1 subproblem
> Any function T(·) satisfying (5.3) with q = 1 is bounded by O(n).
> 

###### A related Recurrence: T(n) ≤ 2T(n/2) + O(n^2)

Divide the input into two pieces of equal size; solve the two subproblems on these pieces separately by recursion; and then combine the two results into an overall solution, spending quadratic time for the initial division and final recombining

> T(n) is bounded by O(n^2)
> 

## Counting Inversions
Given a set of movies, measure how similar two rankings are.
> A natural method is to label movies from 1 to n, then see how many pairs are out of order.
> 

given a sequence of n numbers a1, . . . , an; we will assume that all the numbers are distinct. We want to define a measure that tells us how far this list is from being in ascending order; the value of the measure should be 0 if a1 < a2 < . . . < an, and should increase as the numbers become more scrambled

> A natural way to quantify this notion is by counting the number of inversions. We say that two indices i < j form an inversion if ai > aj, that is, if the two elements ai and aj are “out of order.” We will seek to determine the number of inversions in the sequence a1, . . . , an.
> 

##### Design & Analyzing the Algorithm
We set m = round_up(n/2) and divide the list into the two pieces a1, . . . , am and am+1, . . . , an. We first count the number of inversions in each of these two halves separately. Then we count the number of inversions (ai, aj), where the two numbers belong to different halves; the trick is that we must do this part in O(n) time.

crucial routine in this process is Merge-and-Count. Suppose we have recursively sorted the first and second halves of the list and counted the inversions in each. 

**Merge-and-Count** routine will walk through the sorted lists A and B, removing elements from the front and appending them to the sorted list C. In a given step, we have a Current pointer into each list, showing our current position. Suppose that these pointers are currently at elements ai and bj. In one step, we compare the elements ai and bj being pointed to in each list, remove the smaller one from its list, and append it to the end of list C.
 
How do we also count the number of inversions? Because A and B are sorted, it is actually very easy to keep track of the number of inversions we encounter. Every time the element ai is appended to C, no new inversions are encountered, since ai is smaller than everything left in list B, and it comes before all of them. On the other hand, if bj is appended to list C, then it is smaller than all the remaining items in A, and it comes after all of them, so we increase our count of the number of inversions by the number of elements remaining in A. 

**Merge-and-Count**
```
Merge-and-Count(A,B)
  Maintain a Current pointer into each list, initialized to point to the 
    front elements
  Maintain a variable Count for the number of inversions,
    initialized to 0
  While both lists are nonempty:
    Let ai and bj be the elements pointed to by the Current pointer
    Append the smaller of these two to the output list
    If bj is the smaller element then
      Increment Count by the number of elements remaining in A
    Endif
    Advance the Current pointer in the list from which the
      smaller element was selected.
  EndWhile
  Once one list is empty, append the remainder of the other list
    to the output
  Return Count and the merged list
```
Total running time is O(n).

```
Sort-and-Count(L)
  If the list has one element then
    there are no inversions
  Else
    Divide the list into two halves:
      A contains the first round_up(n/2) elements
      B contains the remaining round_down(n/2) elements
      (rA, A) = Sort-and-Count(A)
      (rB, B) = Sort-and-Count(B)
      (r, L) = Merge-and-Count(A, B)
  Endif
  Return r = rA + rB + r, and the sorted list L
```

> The Sort-and-Count algorithm correctly sorts the input list and counts the number of inversions; it runs in O(n log n) time for a list with n elements.

## Finding the Closest Pair of Points

 
