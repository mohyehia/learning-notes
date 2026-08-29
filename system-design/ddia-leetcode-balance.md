# DDIA + LeetCode Balance Plan

> **Goal:** Keep DDIA as the main engineering-growth track while maintaining LeetCode as a lightweight problem-solving fitness habit.
>
> **Principle:** DDIA should decide the week. LeetCode should fit around it — not compete with it.
>
> **Default weekly capacity:** ~5-8 hours/week.

---

## Table of Contents

- [Core Strategy](#core-strategy)
- [Weekly Time Allocation](#weekly-time-allocation)
- [Default Weekly Schedule](#default-weekly-schedule)
- [Busy Week Schedule](#busy-week-schedule)
- [High-Energy Week Schedule](#high-energy-week-schedule)
- [LeetCode Rules](#leetcode-rules)
- [DDIA Practical Rules](#ddia-practical-rules)
- [12-Week Combined Plan](#12-week-combined-plan)
- [Monthly Review Ritual](#monthly-review-ritual)
- [Priority Rules](#priority-rules)
- [What To Pause](#what-to-pause)
- [Success Criteria](#success-criteria)
- [Final Recommendation](#final-recommendation)

---

## Core Strategy

Run two tracks in parallel:

| Track                    | Purpose                                                                      | Priority           |
|--------------------------|------------------------------------------------------------------------------|--------------------|
| **DDIA**                 | Deep systems thinking, architecture judgment, distributed systems vocabulary | Primary            |
| **DDIA labs / KV store** | Practical implementation of DDIA ideas                                       | Primary-supporting |
| **LeetCode**             | Algorithmic sharpness, problem-solving, Go fluency                           | Secondary          |

The correct mental model:

```text
DDIA = deep engineering transformation
DDIA labs = practical systems learning
LeetCode = algorithmic fitness
Go infra projects = later applied infra mastery
```

---

## Weekly Time Allocation

For a normal week:

| Activity                      | Weekly Time | Purpose                       |
|-------------------------------|------------:|-------------------------------|
| DDIA reading                  |     3-4 hrs | Deep theory                   |
| DDIA notes/reflection         |   30-45 min | Convert reading into judgment |
| DDIA practical lab / KV-store |     1-2 hrs | Make concepts concrete        |
| LeetCode                      |   1.5-2 hrs | Problem-solving sharpness     |

Target ratio:

```text
70% DDIA
25% LeetCode
5% planning/review
```

---

## Default Weekly Schedule

Use this as the normal rhythm.

| Day       | Activity                                    |
|-----------|---------------------------------------------|
| Monday    | DDIA reading — 30-45 min                    |
| Tuesday   | LeetCode problem #1 in Go — 45-60 min       |
| Wednesday | DDIA reading — 30-45 min                    |
| Thursday  | DDIA reading + short note — 30-45 min       |
| Friday    | Rest / light review                         |
| Saturday  | DDIA practical lab or KV-store — 90-120 min |
| Sunday    | LeetCode problem #2 or re-solve — 45-60 min |

Weekly target:

```text
DDIA: 4-5 hours
LeetCode: 1.5-2 hours
Kubectl clone / Go infra: paused or tiny maintenance only
```

---

## Busy Week Schedule

When work/life is heavy, use the minimum viable version.

| Activity      | Minimum             |
|---------------|---------------------|
| DDIA          | 2 reading sessions  |
| LeetCode      | 1 problem           |
| Practical lab | Skip or 30 min only |

Minimum rule:

> Never let a week pass with zero DDIA.

If you only have 30 minutes, read DDIA.

---

## High-Energy Week Schedule

If you have extra time, do not start a new track. Deepen the current one.

| Activity  | Add                                                       |
|-----------|-----------------------------------------------------------|
| DDIA      | One extra reading session                                 |
| LeetCode  | One extra review/re-solve problem, not a new hard problem |
| Practical | Add one small KV-store feature                            |

Avoid using high-energy weeks to start:

- another Go infra project
- Kubernetes clone features beyond your current milestone
- a new book
- a new course

---

## LeetCode Rules

### Rule 1 — Two Problems Per Week

Normal week:

```text
2 problems/week
```

Busy week:

```text
1 problem/week
```

Do not regularly exceed:

```text
3 problems/week
```

Why: if LeetCode becomes 5-7 problems/week, DDIA will lose.

---

### Rule 2 — Use Go

Use Go for LeetCode unless a specific Java interview requires Java.

Benefits:

- Improves Go fluency under time pressure
- Reinforces slices, maps, structs, heaps, and custom types
- Supports your Go infra projects later
- Keeps problem-solving and systems programming aligned

---

### Rule 3 — Time-box Every Problem

Use the 60-minute structure:

```text
0-10 min: Understand the problem + examples
10-25 min: Design approach
25-45 min: Implement
45-60 min: Debug, optimize, write note
```

If stuck after 30 minutes, read a hint.

If still stuck after 45 minutes, read the solution idea, then reimplement from scratch.

Do not spend 2-3 hours on one problem during DDIA season.

---

### Rule 4 — Write a Tiny Post-Problem Note

For every problem, write only this:

```markdown
## Problem: <name>

Pattern:
Approach:
Time complexity:
Space complexity:
Mistake:
How to recognize this pattern next time:
```

Keep it short. The goal is pattern recognition, not blogging.

---

### Rule 5 — Re-solve, Don't Just Solve

Every 5 problems, pick 1 and re-solve it after 7 days.

If you cannot solve it again, you did not learn it deeply enough.

---

## DDIA Practical Rules

DDIA must not become passive reading.

Every week or every other week, produce at least one of:

- a short note
- a production question
- a benchmark
- a small lab
- a KV-store feature

### Practical DDIA Map

| DDIA Area      | Practical Action                                                           |
|----------------|----------------------------------------------------------------------------|
| Chapter 1      | Analyze one production service for reliability/scalability/maintainability |
| Chapter 2      | Model the same domain relational/document/event-style                      |
| Chapter 3      | Build append-only KV log                                                   |
| Chapter 4      | Add versioned records                                                      |
| Chapter 5      | Simulate replication lag                                                   |
| Chapter 6      | Build consistent hashing                                                   |
| Chapter 7      | Reproduce PostgreSQL transaction anomalies                                 |
| Chapter 8      | Inject latency/timeouts/retries                                            |
| Chapter 9      | Simulate leader election                                                   |
| Chapters 10-11 | Build tiny batch/stream processors                                         |

---

## 12-Week Combined Plan

This runs alongside early DDIA reading.

| Week | DDIA Focus                                         | LeetCode Pattern      | LeetCode Target      |
|------|----------------------------------------------------|-----------------------|----------------------|
| 1    | Chapter 1: reliability/scalability/maintainability | Arrays + HashMap      | 2 problems           |
| 2    | Chapter 1 notes + production reflection            | Sliding Window        | 2 problems           |
| 3    | Chapter 2: data models                             | Two Pointers          | 2 problems           |
| 4    | Chapter 2 practical modeling                       | Stack                 | 2 problems/re-solve  |
| 5    | Chapter 3: storage intro                           | Binary Search         | 2 problems           |
| 6    | KV-store Stage 1: append-only log                  | Heap / Priority Queue | 2 problems           |
| 7    | KV-store Stage 2: hash index                       | Intervals             | 2 problems           |
| 8    | KV-store Stage 3: compaction                       | LRU / Cache           | 2 problems/re-solve  |
| 9    | Chapter 4: encoding/evolution                      | BFS / DFS             | 2 problems           |
| 10   | Versioned records lab                              | Topological Sort      | 2 problems           |
| 11   | Chapter 5: replication                             | Union Find            | 2 problems           |
| 12   | Replication lag simulation                         | Review + mock         | 1 mock / 2 re-solves |

Notes:

- If DDIA pace differs, keep the LeetCode pattern progression independent.
- If work is busy, reduce LeetCode to 1 problem/week before reducing DDIA.

---

## Monthly Review Ritual

Every 4 weeks, spend 45-60 minutes reviewing.

### DDIA Review Questions

```markdown
## DDIA Monthly Review

What chapters did I read?
What concepts changed how I think?
What practical lab did I complete?
What production system did this connect to?
What decision would I now make differently?
```

### LeetCode Review Questions

```markdown
## LeetCode Monthly Review

Which patterns did I practice?
Which problems could I solve again without help?
Which pattern still feels weak?
What common mistake repeated?
What should I re-solve next month?
```

---

## Priority Rules

Use these whenever you feel overloaded.

### Rule 1

If you only have time for one thing:

```text
Do DDIA.
```

### Rule 2

If you have 30 minutes:

```text
Read DDIA, not LeetCode.
```

### Rule 3

If you have 60 minutes:

```text
Do one LeetCode problem OR DDIA notes, depending on weekly balance.
```

### Rule 4

If DDIA practical work is falling behind:

```text
Skip LeetCode for one week.
```

### Rule 5

If you miss LeetCode:

```text
No guilt. Resume with the next pattern.
```

### Rule 6

If LeetCode starts consuming more than 2-3 hours/week:

```text
Reduce it immediately.
```

---

## What To Pause

While DDIA is active, pause or strictly limit:

- new Go infra projects
- deeper kubectl-clone features after `describe` + `delete`
- new books
- long courses
- random LeetCode problem grinding

---

## Success Criteria

You are balancing well if, after 12 weeks:

- [ ] You are still reading DDIA consistently
- [ ] You have written short DDIA chapter notes
- [ ] You started the KV-store or at least one DDIA lab
- [ ] You solved ~18-24 LeetCode problems total
- [ ] You can explain 5-6 algorithm patterns clearly
- [ ] You did not let LeetCode replace DDIA
- [ ] You did not start another major track

You are off-track if:

- LeetCode becomes daily grinding
- DDIA is untouched for more than 2 weeks
- You keep starting side projects
- You write notes but build nothing
- You build code but never connect it to DDIA concepts

---

## Final Recommendation

For your current goal — becoming a better engineer — the priority is:

```text
1. DDIA reading
2. DDIA practical labs / KV-store
3. LeetCode in Go, 1-2 problems/week
4. Go infra projects later
```

Use LeetCode as a gym. Use DDIA as the main transformation path.

