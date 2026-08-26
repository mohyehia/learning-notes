# LeetCode Problem-Solving Plan

> **Goal:** Improve problem-solving ability, pattern recognition, implementation speed, and algorithmic confidence without distracting from the main DDIA/system-design learning path.
>
> **Audience:** Principal engineer with strong production experience who wants sharper problem solving, not competitive-programming obsession.
>
> **Timeline:** 24 weeks (~6 months)
>
> **Time budget:** 3-4 hours/week
>
> **Main rule:** LeetCode supports your engineering growth; it must not replace DDIA, architecture study, or practical systems projects.

---

## Table of Contents

- [Principles](#principles)
- [Weekly Routine](#weekly-routine)
- [Difficulty Mix](#difficulty-mix)
- [Phase Overview](#phase-overview)
- [Phase 1: Arrays, Hashing, Two Pointers, Sliding Window](#phase-1-arrays-hashing-two-pointers-sliding-window)
- [Phase 2: Stack, Queue, Linked List, Binary Search, Intervals](#phase-2-stack-queue-linked-list-binary-search-intervals)
- [Phase 3: Trees, Heaps, Tries](#phase-3-trees-heaps-tries)
- [Phase 4: Graphs, Union Find, Topological Sort](#phase-4-graphs-union-find-topological-sort)
- [Phase 5: Dynamic Programming, Backtracking, Greedy](#phase-5-dynamic-programming-backtracking-greedy)
- [Phase 6: Mixed Practice and Interview Simulation](#phase-6-mixed-practice-and-interview-simulation)
- [Review System](#review-system)
- [Problem Journal Template](#problem-journal-template)
- [Rules to Avoid Wasting Time](#rules-to-avoid-wasting-time)

---

## Principles

1. **Patterns over problem count.** Solving 120 problems deeply is better than rushing 400.
2. **Explain before coding.** For every problem, first state the pattern, invariant, and complexity.
3. **Review mistakes aggressively.** Your improvement comes from revisiting failed problems.
4. **Use one primary language.** Prefer **Java** if your goal includes interviews or algorithm fluency. Use **Go occasionally** only when you want extra implementation practice.
5. **No memorized solutions.** You are training reasoning, not recall.
6. **Timed practice starts later.** First build pattern fluency; then add pressure.
7. **LeetCode is secondary to DDIA.** If the week is busy, do fewer problems — do not abandon the main learning track.

---

## Weekly Routine

Recommended weekly schedule:

| Session   |  Duration | Activity                                                 |
|-----------|----------:|----------------------------------------------------------|
| Session 1 | 45-60 min | Learn/review the week's pattern + solve 1 problem slowly |
| Session 2 | 60-75 min | Solve 2 focused problems                                 |
| Session 3 | 60-75 min | Solve 1-2 focused problems + review mistakes             |
| Optional  |    30 min | Re-solve one old failed problem from memory              |

Minimum viable week:

```text
2 problems + 1 review problem
```

Strong week:

```text
4-5 problems + 1 review problem
```

Do not exceed 7 problems/week unless you are on vacation or intentionally doing a sprint.

---

## Difficulty Mix

| Phase   | Easy | Medium | Hard |
|---------|-----:|-------:|-----:|
| Phase 1 |  40% |    60% |   0% |
| Phase 2 |  30% |    65% |   5% |
| Phase 3 |  25% |    70% |   5% |
| Phase 4 |  20% |    70% |  10% |
| Phase 5 |  20% |    65% |  15% |
| Phase 6 |  10% |    70% |  20% |

Hard problems are for learning pattern boundaries, not ego.

---

## Phase Overview

| Phase | Weeks | Focus                                               | Main Objective                                                            |
|-------|------:|-----------------------------------------------------|---------------------------------------------------------------------------|
| 1     |   1-4 | Arrays, Hashing, Two Pointers, Sliding Window       | Build fast recognition of the most common patterns                        |
| 2     |   5-8 | Stack, Queue, Linked List, Binary Search, Intervals | Master pointer/state manipulation and ordered search                      |
| 3     |  9-12 | Trees, Heaps, Tries                                 | Become comfortable with recursive structures and priority-based retrieval |
| 4     | 13-16 | Graphs, Union Find, Topological Sort                | Build confidence with traversal, connectivity, and dependency problems    |
| 5     | 17-21 | DP, Backtracking, Greedy                            | Learn to reason about choices, states, and optimal substructure           |
| 6     | 22-24 | Mixed Practice                                      | Simulate interviews and improve speed under pressure                      |

---

# Phase 1: Arrays, Hashing, Two Pointers, Sliding Window

**Duration:** Weeks 1-4

## Phase Objectives

- [ ] Recognize when a hash map turns an O(n²) search into O(n)
- [ ] Use two pointers for sorted arrays, pair search, and in-place transforms
- [ ] Use sliding window for contiguous subarray/substring problems
- [ ] Clearly explain window invariants
- [ ] Avoid off-by-one errors in indexes and boundaries

---

## Week 1 — Hash Map Fundamentals

**Patterns:**

- Frequency map
- Index map
- Complement lookup
- Counting occurrences

**Objectives:**

- [ ] Know when to use `Map<Value, Count>` vs `Map<Value, Index>`
- [ ] Convert brute force pair search to one-pass hash lookup
- [ ] Handle duplicates correctly

**Sample Problems:**

- Two Sum
- Valid Anagram
- Contains Duplicate
- Group Anagrams
- Top K Frequent Elements

**Reflection Question:**

> What exact information do I need to remember while scanning once?

---

## Week 2 — Prefix Sum and Counting

**Patterns:**

- Prefix sum
- Prefix sum + hash map
- Difference between sum-so-far and previous sums

**Objectives:**

- [ ] Use prefix sums to answer range/count questions
- [ ] Understand why `currentSum - target` matters
- [ ] Handle negative numbers where sliding window fails

**Sample Problems:**

- Subarray Sum Equals K
- Range Sum Query - Immutable
- Product of Array Except Self
- Find Pivot Index
- Continuous Subarray Sum

**Reflection Question:**

> Why does sliding window fail when negative numbers exist?

---

## Week 3 — Two Pointers

**Patterns:**

- Left/right pointers on sorted arrays
- Fast/slow pointers
- In-place array modification
- Palindrome checks

**Objectives:**

- [ ] Move pointers based on a clear invariant
- [ ] Avoid nested loops when the input is sorted
- [ ] Handle in-place overwrite correctly

**Sample Problems:**

- Valid Palindrome
- Two Sum II - Input Array Is Sorted
- 3Sum
- Container With Most Water
- Remove Duplicates from Sorted Array

**Reflection Question:**

> What condition tells me which pointer to move?

---

## Week 4 — Sliding Window

**Patterns:**

- Fixed-size window
- Variable-size window
- Window frequency map
- Longest/shortest valid window

**Objectives:**

- [ ] Define the window invariant before coding
- [ ] Know when to expand right and shrink left
- [ ] Track best answer incrementally

**Sample Problems:**

- Best Time to Buy and Sell Stock
- Longest Substring Without Repeating Characters
- Minimum Size Subarray Sum
- Permutation in String
- Minimum Window Substring

**Reflection Question:**

> What makes the current window valid or invalid?

---

# Phase 2: Stack, Queue, Linked List, Binary Search, Intervals

**Duration:** Weeks 5-8

## Phase Objectives

- [ ] Use stacks for monotonic relationships and nested structure validation
- [ ] Manipulate linked list pointers safely
- [ ] Apply binary search beyond simple sorted arrays
- [ ] Merge and reason about intervals

---

## Week 5 — Stack and Monotonic Stack

**Patterns:**

- Stack for matching/open-close structures
- Monotonic increasing/decreasing stack
- Previous/next greater element

**Objectives:**

- [ ] Use stack to preserve unresolved elements
- [ ] Explain what the stack represents at every step
- [ ] Recognize nearest-greater/smaller problems

**Sample Problems:**

- Valid Parentheses
- Min Stack
- Daily Temperatures
- Next Greater Element I
- Largest Rectangle in Histogram

**Reflection Question:**

> What does each item in the stack still need to find?

---

## Week 6 — Linked Lists

**Patterns:**

- Dummy node
- Fast/slow pointer
- Reverse list
- Merge lists
- Cycle detection

**Objectives:**

- [ ] Use dummy nodes to simplify edge cases
- [ ] Reverse pointers without losing the rest of the list
- [ ] Detect cycles and middle nodes with fast/slow pointers

**Sample Problems:**

- Reverse Linked List
- Merge Two Sorted Lists
- Linked List Cycle
- Remove Nth Node From End of List
- Reorder List

**Reflection Question:**

> Which pointer changes first, and what could be lost if I update in the wrong order?

---

## Week 7 — Binary Search

**Patterns:**

- Standard binary search
- Lower bound / upper bound
- Search on answer space
- Rotated sorted array

**Objectives:**

- [ ] Write binary search without infinite loops
- [ ] Distinguish index search from answer-space search
- [ ] Define monotonic predicate clearly

**Sample Problems:**

- Binary Search
- Search Insert Position
- Search in Rotated Sorted Array
- Find Minimum in Rotated Sorted Array
- Koko Eating Bananas

**Reflection Question:**

> What monotonic condition lets me discard half the search space?

---

## Week 8 — Intervals and Sweep Line Basics

**Patterns:**

- Sort by start/end
- Merge overlapping intervals
- Meeting room counting
- Event sweep

**Objectives:**

- [ ] Sort intervals according to the decision needed
- [ ] Merge or count overlaps correctly
- [ ] Recognize when starts/ends should be processed separately

**Sample Problems:**

- Merge Intervals
- Insert Interval
- Non-overlapping Intervals
- Meeting Rooms
- Meeting Rooms II

**Reflection Question:**

> Am I trying to merge intervals, count overlaps, or choose a maximum compatible set?

---

# Phase 3: Trees, Heaps, Tries

**Duration:** Weeks 9-12

## Phase Objectives

- [ ] Traverse trees recursively and iteratively
- [ ] Use DFS/BFS appropriately
- [ ] Use heaps for top-k and scheduling-like problems
- [ ] Understand trie-based prefix lookup

---

## Week 9 — Binary Tree DFS

**Patterns:**

- Recursive DFS
- Preorder/inorder/postorder thinking
- Return values from children
- Path accumulation

**Objectives:**

- [ ] Decide what each recursive call returns
- [ ] Avoid global mutable state unless intentional
- [ ] Solve tree depth/path problems cleanly

**Sample Problems:**

- Maximum Depth of Binary Tree
- Diameter of Binary Tree
- Balanced Binary Tree
- Same Tree
- Path Sum

**Reflection Question:**

> What information does a parent need from its children?

---

## Week 10 — Tree BFS and BSTs

**Patterns:**

- Level-order traversal
- Queue-based BFS
- BST invariant
- Validate/search/insert in BST

**Objectives:**

- [ ] Use BFS when levels matter
- [ ] Use min/max bounds for BST validation
- [ ] Avoid local-only BST checks

**Sample Problems:**

- Binary Tree Level Order Traversal
- Binary Tree Right Side View
- Validate Binary Search Tree
- Lowest Common Ancestor of a BST
- Kth Smallest Element in a BST

**Reflection Question:**

> Does the problem care about depth/levels or subtree properties?

---

## Week 11 — Heaps and Priority Queues

**Patterns:**

- Min heap / max heap
- Top K
- Merge K sorted streams
- Scheduling by priority

**Objectives:**

- [ ] Know when sorting once is enough vs heap is needed
- [ ] Use heap size constraints for top-k
- [ ] Model repeated extraction efficiently

**Sample Problems:**

- Kth Largest Element in an Array
- Last Stone Weight
- Top K Frequent Elements
- Merge K Sorted Lists
- Task Scheduler

**Reflection Question:**

> Do I need the next best item repeatedly?

---

## Week 12 — Tries and Prefix Search

**Patterns:**

- Prefix tree
- Word dictionary
- DFS over trie
- Prefix pruning

**Objectives:**

- [ ] Implement trie insert/search/startsWith
- [ ] Understand memory trade-offs of tries
- [ ] Use trie to prune search space

**Sample Problems:**

- Implement Trie
- Design Add and Search Words Data Structure
- Word Search II
- Replace Words
- Longest Word in Dictionary

**Reflection Question:**

> What repeated prefix work am I avoiding?

---

# Phase 4: Graphs, Union Find, Topological Sort

**Duration:** Weeks 13-16

## Phase Objectives

- [ ] Model problems as graphs confidently
- [ ] Choose DFS, BFS, Dijkstra, Union Find, or Topological Sort intentionally
- [ ] Handle visited state and cycles correctly
- [ ] Connect graph thinking to infra systems: dependency graphs, schedulers, service graphs

---

## Week 13 — Graph BFS/DFS

**Patterns:**

- Adjacency list
- Visited set
- Connected components
- Grid traversal

**Objectives:**

- [ ] Convert input into graph representation
- [ ] Avoid revisiting nodes
- [ ] Count components/islands correctly

**Sample Problems:**

- Number of Islands
- Clone Graph
- Max Area of Island
- Flood Fill
- Rotting Oranges

**Reflection Question:**

> What are the nodes and edges in this problem?

---

## Week 14 — Topological Sort

**Patterns:**

- Dependency graph
- Indegree queue
- Cycle detection
- Course/task ordering

**Objectives:**

- [ ] Detect cycles in dependency graphs
- [ ] Use Kahn's algorithm confidently
- [ ] Explain why topological sort only works on DAGs

**Sample Problems:**

- Course Schedule
- Course Schedule II
- Alien Dictionary
- Minimum Height Trees
- Find Eventual Safe States

**Reflection Question:**

> Which tasks must happen before others?

---

## Week 15 — Union Find

**Patterns:**

- Disjoint set union
- Path compression
- Union by rank/size
- Connectivity over time

**Objectives:**

- [ ] Implement DSU from memory
- [ ] Know when DSU is better than repeated DFS
- [ ] Detect redundant edges/cycles

**Sample Problems:**

- Number of Connected Components in an Undirected Graph
- Redundant Connection
- Accounts Merge
- Graph Valid Tree
- Number of Provinces

**Reflection Question:**

> Am I repeatedly asking whether two things belong to the same group?

---

## Week 16 — Shortest Path and Weighted Graphs

**Patterns:**

- BFS for unweighted shortest path
- Dijkstra for non-negative weights
- Priority queue state expansion

**Objectives:**

- [ ] Distinguish weighted vs unweighted shortest path
- [ ] Use priority queue for best-first expansion
- [ ] Track distances and avoid stale heap entries

**Sample Problems:**

- Network Delay Time
- Path With Minimum Effort
- Cheapest Flights Within K Stops
- Shortest Path in Binary Matrix
- Swim in Rising Water

**Reflection Question:**

> What is the cost of moving from one state to another?

---

# Phase 5: Dynamic Programming, Backtracking, Greedy

**Duration:** Weeks 17-21

## Phase Objectives

- [ ] Identify overlapping subproblems
- [ ] Define DP state and transition clearly
- [ ] Use backtracking for exhaustive search with pruning
- [ ] Recognize greedy-choice properties

---

## Week 17 — 1D Dynamic Programming

**Patterns:**

- Fibonacci-like recurrence
- House robber pattern
- Min/max ending at index
- Include/exclude decisions

**Objectives:**

- [ ] Define `dp[i]` clearly
- [ ] Convert recursion to tabulation
- [ ] Optimize space when only previous states matter

**Sample Problems:**

- Climbing Stairs
- House Robber
- Min Cost Climbing Stairs
- Maximum Subarray
- Decode Ways

**Reflection Question:**

> What does `dp[i]` mean in one precise sentence?

---

## Week 18 — 2D Dynamic Programming

**Patterns:**

- Grid DP
- Sequence DP
- Longest common subsequence
- Edit distance-style transitions

**Objectives:**

- [ ] Define row/column meaning clearly
- [ ] Initialize base cases correctly
- [ ] Understand transition dependencies

**Sample Problems:**

- Unique Paths
- Minimum Path Sum
- Longest Common Subsequence
- Edit Distance
- Interleaving String

**Reflection Question:**

> Which smaller subproblems must be solved before this cell?

---

## Week 19 — Knapsack and Subset DP

**Patterns:**

- 0/1 knapsack
- Subset sum
- Target sum
- Boolean DP

**Objectives:**

- [ ] Recognize choose/not-choose problems
- [ ] Track capacity/target dimensions
- [ ] Avoid double-counting when compressing space

**Sample Problems:**

- Partition Equal Subset Sum
- Target Sum
- Coin Change
- Coin Change II
- Last Stone Weight II

**Reflection Question:**

> Is this asking whether a target is reachable, or how many ways it is reachable?

---

## Week 20 — Backtracking

**Patterns:**

- Generate subsets/permutations/combinations
- Constraint search
- Pruning invalid choices

**Objectives:**

- [ ] Implement choose/explore/unchoose cleanly
- [ ] Use pruning to reduce search space
- [ ] Avoid duplicate results

**Sample Problems:**

- Subsets
- Permutations
- Combination Sum
- Word Search
- N-Queens

**Reflection Question:**

> What choice am I making at this recursion level?

---

## Week 21 — Greedy

**Patterns:**

- Local optimal choice
- Sorting by key
- Interval greedy
- Heap-assisted greedy

**Objectives:**

- [ ] Identify when greedy is valid
- [ ] Explain the exchange argument informally
- [ ] Avoid using greedy when DP is required

**Sample Problems:**

- Jump Game
- Jump Game II
- Gas Station
- Partition Labels
- Hand of Straights

**Reflection Question:**

> Why does the local choice not hurt the global optimum?

---

# Phase 6: Mixed Practice and Interview Simulation

**Duration:** Weeks 22-24

## Phase Objectives

- [ ] Improve pattern recall under time pressure
- [ ] Practice explaining before coding
- [ ] Identify weak areas
- [ ] Build confidence across mixed problem sets

---

## Week 22 — Mixed Medium Set

**Patterns:**

- Random mix from Phases 1-3
- Arrays, strings, trees, heaps

**Objectives:**

- [ ] Identify pattern in under 5 minutes
- [ ] Solve medium problems in 30-40 minutes
- [ ] Explain complexity clearly

**Sample Problems:**

- Longest Substring Without Repeating Characters
- Search in Rotated Sorted Array
- Binary Tree Right Side View
- Kth Largest Element in an Array
- Merge Intervals

---

## Week 23 — Mixed Graph/DP Set

**Patterns:**

- Graph traversal
- Topological sort
- Union Find
- 1D/2D DP

**Objectives:**

- [ ] Distinguish graph vs DP state-space problems
- [ ] Avoid overcomplicating medium problems
- [ ] Practice writing clean helper functions

**Sample Problems:**

- Course Schedule
- Number of Islands
- Partition Equal Subset Sum
- Longest Common Subsequence
- Network Delay Time

---

## Week 24 — Mock Interview Week

**Patterns:**

- Full mixed practice
- Timed explanations
- Review and remediation

**Objectives:**

- [ ] Complete 2 timed mock sessions
- [ ] Identify top 3 weakest patterns
- [ ] Re-solve 5 previously failed problems
- [ ] Write final retrospective

**Mock Format:**

```text
5 min: clarify problem and examples
5 min: propose approach
25 min: code
5 min: test and complexity
```

**Sample Problems:**

- One array/string medium
- One tree/graph medium
- One DP/backtracking medium
- One interval/binary-search medium
- One hard problem for learning only

---

# Review System

Use spaced repetition for failed or slow problems.

| Result                     | Action                                               |
|----------------------------|------------------------------------------------------|
| Solved easily under 20 min | Mark green; revisit in 30 days                       |
| Solved with hints          | Mark yellow; retry in 7 days                         |
| Could not solve            | Mark red; retry in 2 days, then 7 days, then 21 days |
| Buggy implementation       | Add to bug-pattern list                              |

Maintain a simple tracker:

```markdown
| Date | Problem | Pattern | Result | Mistake | Retry Date |
|---|---|---|---|---|---|
| 2026-08-26 | Subarray Sum Equals K | Prefix Sum | Yellow | Forgot currentSum-target logic | 2026-09-02 |
```

---

# Problem Journal Template

For each non-trivial problem, write this:

```markdown
## Problem: <name>

### Pattern

### Why this pattern fits

### Key invariant / state

### Edge cases

### Complexity

### Mistake I made

### One-sentence takeaway
```

Example takeaway:

```text
Prefix sum problems usually ask: have I seen a previous prefix that makes the current range valid?
```

---

# Rules to Avoid Wasting Time

1. **Do not spend more than 35 minutes stuck.** If stuck, read a hint, not the full solution.
2. **After seeing a solution, close it and re-implement from memory.** Otherwise it does not count.
3. **Every failed problem must be retried.** Failure without review is wasted time.
4. **Do not chase hard problems early.** Hard problems are useful only after the pattern is familiar.
5. **Do not solve random problems before Week 22.** Stay pattern-focused.
6. **Prefer depth over streaks.** A streak can become vanity; understanding is the goal.
7. **Keep DDIA primary.** If time is limited, do the minimum viable LeetCode week.

---

# Monthly Checkpoints

| Month | You should be able to...                                                  |
|-------|---------------------------------------------------------------------------|
| 1     | Recognize hash map, two pointers, and sliding window quickly              |
| 2     | Solve stack, linked list, binary search, and interval mediums confidently |
| 3     | Traverse trees and use heaps/tries without fear                           |
| 4     | Model graph problems and choose BFS/DFS/DSU/toposort correctly            |
| 5     | Define DP states and backtracking recursion clearly                       |
| 6     | Solve mixed mediums under time pressure and explain trade-offs clearly    |

---

# Final Target

After 24 weeks, target this capability:

- [ ] Solve most easy problems in 10-15 minutes
- [ ] Solve common medium patterns in 25-40 minutes
- [ ] Identify the correct pattern quickly
- [ ] Explain complexity and edge cases clearly
- [ ] Re-solve failed problems without hints
- [ ] Maintain LeetCode as a 1-2 problem/week habit after the plan ends

This is enough for strong problem-solving maintenance without sacrificing your main engineering-growth path.

