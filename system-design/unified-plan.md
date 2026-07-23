# Unified Learning Plan: Books + System Design Topics

> **Goal:** Become a better engineer — not just learn more, but think and decide differently.
>
> **Structure:** 7 books drive the learning. README topics slot in as reinforcement reading + selective builds.
> Each phase has ONE theme, ONE book project, and at most ONE extra README build.
>
> **Timeline:** ~20-22 months | ~5-8 hours/week | No rushing. Buffer included for life.
>
> **The Principle:** Read theory (book) → Reinforce with articles (README) → Build something hard → Write about it → Apply at work.
>
> **Key dependency:** Phases 3→4→5 build one progressive system (saga → observe it → deploy it). See the escape hatch note below if Phase 3 stalls.

### 🚀 Start Today

1. Read the 3 Phase 1 prerequisites (~2-3 hours total)
2. Open DDIA Chapter 1
3. Read 20 pages
4. Done. You're in motion.

---

## Table of Contents

- [Overview](#overview)
- [Milestone Checkpoints](#milestone-checkpoints)
- [Escape Hatch](#escape-hatch-if-phases-345-stall)
- [Phase 1: Data & Storage Foundations (DDIA)](#phase-1-data--storage-foundations)
- [Phase 2: Architectural Thinking (Fundamentals SA)](#phase-2-architectural-thinking)
- [Phase 3: Event-Driven Systems (Event-Driven Microservices)](#phase-3-event-driven-systems)
- [Phase 4: Observability (Observability Engineering)](#phase-4-observability)
- [Phase 5: Kubernetes (The Kubernetes Book)](#phase-5-kubernetes-production-grade)
- [Phase 6: Database Internals (DB Internals)](#phase-6-database-internals)
- [Phase 7: Systems Programming in Go (Capstone)](#phase-7-systems-programming-in-go-capstone)
- [On-Demand Topics](#on-demand-topics-not-attached-to-any-phase)
- [The Compound Loop](#the-compound-loop-why-this-works)
- [Writing Standards](#writing-standards-what-write-about-it-means)
- [Rules to Protect Execution](#rules-to-protect-execution)
- [Final Self-Assessment](#final-self-assessment-after-all-7-phases)

---

## Overview

| Phase | Months | Book                       | README Build (1 max)           | Writing Output                                  |
|-------|--------|----------------------------|--------------------------------|-------------------------------------------------|
| 1     | 1–4    | DDIA                       | Consistent Hashing             | "How this changes my production thinking" notes |
| 2     | 5–6    | Fundamentals SA            | API Gateway / BFF              | ADRs for real production system                 |
| 3     | 7–10   | Event-Driven Microservices | Rate Limiter                   | Design doc (before) + post-mortem (after)       |
| 4     | 10–12  | Observability Engineering  | DB Replication + observability | SLO proposal for a real service                 |
| 5     | 12–14  | Kubernetes Book            | None (book project is enough)  | Chaos test runbook                              |
| 6     | 14–18  | Database Internals         | Bloom Filter service           | Blog post: LSM-tree vs B-tree benchmarks        |
| 7     | 18–22  | Systems Programming in Go  | None (TSDB is the capstone)    | GitHub README with architecture decisions       |

---

## Milestone Checkpoints

> Every 3 months, stop and ask yourself these questions. If you can't answer "yes" to at least 2, recalibrate.

| Month | Checkpoint                                                                                         |
|-------|----------------------------------------------------------------------------------------------------|
| 3     | "I can explain DDIA concepts to a colleague without looking at the book."                          |
| 6     | "I've written ADRs at work and they influenced a real decision."                                   |
| 9     | "My saga handles duplicate messages and compensating transactions correctly under test."           |
| 12    | "I can debug a latency issue in my system using only traces and metrics in under 10 minutes."      |
| 13    | "I can explain K8s networking (CNI → Service → Ingress) and debug a pod failure systematically."   |
| 15    | "I can explain why PostgreSQL uses B-trees and Cassandra uses LSM-trees — and when I'd pick each." |
| 18    | "My LSM-tree engine passes crash recovery tests and I understand every line."                      |
| 22    | "My TSDB is on GitHub, benchmarked, and I can walk someone through every architecture decision."   |

---

## Escape Hatch: If Phases 3→4→5 Stall

Phases 3, 4, and 5 build progressively on one system (saga → observe → deploy). If Phase 3 takes too long or life intervenes:

- **Option A:** Reduce Phase 3's project scope — build 2 services instead of 3, skip schema versioning, keep idempotency + saga as the core. Then continue to Phase 4.
- **Option B:** For Phase 4, instrument an existing service at work instead of the saga. The book's value is the *mental model*, not which system you instrument.
- **Option C:** Skip Phase 5's project (you already do K8s daily). Read the book for gap-filling, do the chaos testing mentally with your production system.

### If Phase 1 (DDIA) or Phase 6 (DB Internals) Stall

These are the longest phases (3-4 months each). If you get stuck:

- **DDIA stalling on the project:** Simplify the KV store — build only ONE engine (the LSM-tree-like append-only log). Skip the hash index engine. You'll still learn the core concepts. The comparison can be done by benchmarking your engine against Redis or LevelDB instead of your own second implementation.
- **DB Internals stalling on the project:** Build the LSM-tree incrementally: first just WAL + memtable + flush to file. Get that working. Then add bloom filters. Then add compaction. Don't try to build it all at once — each layer is a meaningful milestone.
- **Either book feeling too dense:** Slow down. Read 10 pages instead of 20. Re-read a chapter. The depth matters more than the pace. These two books are the ones where slowing down has the highest ROI.

The rule: **Never let a stalled project block you from reading the next book.** Reading can always continue. Projects can catch up.

---

## Phase 1: Data & Storage Foundations

### Prerequisites (1–2 days)

> Refresh these before opening DDIA. The book assumes you have an intuition for how data moves and how hash-based structures work.

| Parent Topic (README Section)   | Topic                    | What to Read (from README)                                                                                                                                                                                    | Why                                                                                                                                                          |
|---------------------------------|--------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Hashing                         | Hashing fundamentals     | [Hashing in Data Structure](https://www.scaler.com/topics/data-structures/hashing-in-data-structure/) + [Load Factor and Rehashing](https://www.scaler.com/topics/data-structures/load-factor-and-rehashing/) | DDIA Ch. 3 opens with hash indexes, Ch. 6 uses hash partitioning. You need to feel *why* key distribution matters.                                           |
| Back-of-the-Envelope Estimation | Latency numbers          | [Latency Numbers Every Programmer Should Know](https://gist.github.com/jboner/2841832)                                                                                                                        | DDIA constantly argues "sequential disk > random disk", "memory > disk", "network = unreliable." Internalize the orders of magnitude.                        |
| Database Indexing               | Basic DB indexing (skim) | [An in-depth look at Database Indexing](https://www.freecodecamp.org/news/database-indexing-at-a-glance-bb50809d48bd/)                                                                                        | Gives you user-level context so Ch. 3 becomes "here's what's happening *underneath*" rather than learning two things at once. Skip if nothing surprises you. |

---

**Book:** Designing Data-Intensive Applications, 2nd Edition — Martin Kleppmann & Chris Riccomini
**Duration:** 3–4 months

> The #1 book for distributed systems engineers. Covers storage, replication, partitioning, transactions, and stream processing. Everything else builds on this.

### Learning Objectives

- [ ] Explain the trade-offs between B-Tree and LSM-Tree storage engines and when to choose each
- [ ] Compare single-leader, multi-leader, and leaderless replication — know failure modes of each
- [ ] Design a partitioning strategy (hash vs range) for a given dataset and access pattern
- [ ] Explain why distributed transactions are hard and what guarantees 2PC provides vs its costs
- [ ] Describe exactly-once vs at-least-once vs at-most-once semantics and when each is acceptable
- [ ] Articulate the difference between stream processing and batch processing and when to use each
- [ ] Draw a data pipeline from ingestion to query for a real system, labeling replication, partitioning, and consistency boundaries

### Book Project: Mini Key-Value Store (Java)

- Two storage engines: hash index vs log-structured (LSM-tree-like) append-only engine
- Write-ahead log for crash recovery
- Basic compaction (merge SSTables, remove tombstones)
- Simple TCP server (`GET key`, `SET key value`, `DEL key`)
- Benchmark: compare write throughput, read latency, and space amplification at 100K, 1M, and 10M keys
- Write an internal doc explaining which engine wins for which workload and why

### README Topics to Read Alongside

| DDIA Chapter                    | README Section                   |
|---------------------------------|----------------------------------|
| Ch. 3 – Storage & Retrieval     | Database Indexing                |
| Ch. 5 – Replication             | Database Replication             |
| Ch. 6 – Partitioning            | Database Partitioning & Sharding |
| Ch. 7 – Transactions            | ACID Principles                  |
| Ch. 8 – Distributed Problems    | CAP Theorem                      |
| Ch. 9 – Consistency & Consensus | Leader Election & Consensus      |
| Ch. 10-11 – Batch & Stream      | Message Queues (read only)       |

### README Build: Consistent Hashing

- Build a hash ring with virtual nodes in Java
- Place keys, add/remove nodes, measure data movement on rebalance
- Why now: DDIA Ch. 6 teaches you *why* consistent hashing matters. Building it makes partitioning visceral.
- Scope: A weekend project — small but high-impact.

### Writing Output

After each Part (I, II, III), write a 1-page note:
> "How this changes my thinking about our production systems. What decision would I now make differently?"

---

## Phase 2: Architectural Thinking

### Prerequisites (2–3 days)

> Phase 1 (DDIA) is your main prerequisite — it gives you the distributed systems vocabulary this book builds on. These additional reads prime your thinking for architecture-level concerns.

| Parent Topic (README Section)   | Topic                                         | What to Read (from README)                                                                                                                                                | Why                                                                                                                                                                                |
|---------------------------------|-----------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| API Gateway                     | Load Balancer vs Reverse Proxy vs API Gateway | [Load Balancer vs. Reverse Proxy vs. API Gateway](https://www.designgurus.io/blog/load-balancer-reverse-proxy-api-gateway)                                                | The book discusses deployment boundaries and infrastructure topology. You need to know *which component belongs where* before evaluating architecture styles.                      |
| Networking                      | Networking essentials                         | [System Design Concepts: Networking Essentials](https://levelup.gitconnected.com/system-design-concepts-networking-essentials-09798e0ff7b4)                               | Architecture styles are constrained by network realities (latency, bandwidth, failure domains). Refresh how requests traverse infrastructure.                                      |
| Back-of-the-Envelope Estimation | Back-of-envelope estimation                   | [System Design Interview Questions: The Ultimate Crash Course](https://levelup.gitconnected.com/system-design-interview-questions-the-ultimate-crash-course-d1f17da93faa) | The book asks you to evaluate architecture trade-offs. Being able to quickly estimate QPS, storage, bandwidth helps you assess which "-ilities" actually matter for a given scale. |

---


**Book:** Fundamentals of Software Architecture, 2nd Edition — Mark Richards & Neal Ford
**Duration:** 1.5 months

> Shifts your mindset from implementation to architectural thinking — trade-off analysis, modularity, component design.

### Learning Objectives

- [ ] Identify and compare 8+ architecture styles with their trade-offs
- [ ] Define architecture characteristics (the "-ilities") and explain which ones conflict
- [ ] Use the architecture quantum concept to determine deployment boundaries
- [ ] Write Architecture Decision Records (ADRs) that capture context, decision, and consequences
- [ ] Design architecture fitness functions — automated tests that validate architectural properties
- [ ] Analyze component coupling and cohesion to determine where to draw module boundaries
- [ ] Present an architecture trade-off analysis to a non-technical stakeholder

### Book Project: Architecture Review of a Real System at Work

- Identify its architecture style (layered? microservices? event-driven hybrid?)
- Document its top 3 architecture characteristics and which ones are being sacrificed
- Write 2-3 ADRs for key decisions — including one you disagree with
- Define one architecture fitness function (e.g., "no service-to-service calls exceed 200ms p99")
- Present findings to your team. Start an ADR repository if one doesn't exist

### README Topics to Read Alongside

| Book Theme             | README Section                                                  |
|------------------------|-----------------------------------------------------------------|
| Architecture styles    | API Gateway articles (see the BFF pattern article specifically) |
| Scalability trade-offs | Load Balancing algorithms + strategies articles                 |
| Trade-off analysis     | General System Design resources (skim)                          |

### README Build: API Gateway / BFF

- Build a Spring Cloud Gateway with routing to user, order, and catalog services
- Add JWT auth, request aggregation, and rate-limiting filters
- Why now: Direct application of "architecture quantum" — forces you to decide what lives at the edge vs. inside services.

### Writing Output

- 2-3 ADRs for real production decisions
- Start an ADR repo at work if one doesn't exist

---

## Phase 3: Event-Driven Systems

### Prerequisites (2–3 days)

> You need a basic mental model of message brokers and async patterns before diving into event-driven architecture theory.

| Parent Topic (README Section)              | Topic                       | What to Read (from README)                                                                                                                                                                                                                                    | Why                                                                                                                                                                                                |
|--------------------------------------------|-----------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Message Queues & Event-Driven Architecture | Message queues fundamentals | [Message Queues in System Design](https://levelup.gitconnected.com/message-queues-in-system-design-0440a1221023) + [When to Use Kafka or RabbitMQ in System Design](https://rushi1807.medium.com/when-to-use-kafka-or-rabbitmq-in-system-design-f69723331b31) | The book assumes you know what a broker does. Understand pub/sub vs point-to-point, at-least-once delivery, and why message ordering is hard — so the book can teach you *patterns*, not plumbing. |
| Message Queues & Event-Driven Architecture | Push vs Pull architecture   | [System Design: Push vs Pull architecture paradigms](https://medium.com/@guptaabhinav206/system-design-push-vs-pull-architecture-paradigms-d9803b87419a)                                                                                                      | Event-driven systems are fundamentally about push. Understanding the contrast with pull (request/response) helps you identify *when events are the wrong choice* — a key learning objective.       |
| Caching                                    | Caching strategies (skim)   | [Mastering the Art of Caching for System Design Interviews](https://www.designgurus.io/blog/caching-system-design-interview) + [In-Depth Guide to Cache Invalidation Strategies](https://www.designgurus.io/blog/cache-invalidation-strategies)               | Cache invalidation is an event-driven problem. Understanding write-through, write-behind, and cache-aside patterns helps you see how events solve (or complicate) state consistency.               |

---

**Book:** Building Event-Driven Microservices, 2nd Edition — Adam Bellemare
**Duration:** 2–3 months (project may extend to month 4 — that's OK)

> Redefines how you think about data ownership and service boundaries. Broker-agnostic patterns that apply to any message system.
> ⚠️ This is the hardest project phase. The saga + idempotency + schema versioning combination is where most engineers underestimate scope. Budget extra time.

### Learning Objectives

- [ ] Explain the difference between event notification, event-carried state transfer, and event sourcing — know when to use each
- [ ] Design data ownership boundaries: which service owns which data, and how others get access
- [ ] Implement a choreography-based saga with compensating transactions
- [ ] Handle schema evolution in events without breaking existing consumers
- [ ] Design idempotent event consumers that handle at-least-once delivery safely
- [ ] Explain CQRS: when it adds value vs when it's over-engineering
- [ ] Identify when event-driven architecture is the WRONG choice

### Book Project: 3-Service Event-Driven Saga (Java/Spring Boot + SQS/SNS)

- Order Service → publishes `OrderPlaced` to SNS → SQS queues fan out to Inventory + Payment
- Choreography-based saga with compensating transactions (payment fails → rollback)
- Idempotency handling (SQS at-least-once delivery)
- Dead-letter queues with a DLQ processor that alerts and retries
- Message schema versioning (v1 → v2 without breaking consumers)
- Integration tests for happy path + compensation path
- Docker Compose for one-command local startup

### README Topics to Read Alongside

| Book Theme             | README Section                                          |
|------------------------|---------------------------------------------------------|
| Event types & patterns | Message Queues & Event-Driven Architecture              |
| Async communication    | WebSockets (contrast: events vs. real-time push)        |
| Data ownership         | Caching (cache invalidation as an event-driven problem) |

### README Build: Rate Limiter (Token Bucket + Sliding Window)

- Implement both algorithms in Java
- Back them with Redis for distributed coordination
- Integrate into your saga system: rate-limit retries from the DLQ processor and protect the Payment Service from burst traffic
- Why now: Your saga system needs backpressure. Rate limiting teaches distributed coordination — a skill you'll immediately use inside the saga to throttle retries and protect downstream services.
- **Bonus:** Plug the rate limiter into Spring Cloud Gateway as a reusable filter if time permits

### Writing Output

- Design doc *before* building (problem, options, decision, trade-offs)
- Post-mortem *after* building (what broke, what surprised you, what you'd change)

---

## Phase 4: Observability

### Prerequisites (1–2 days)

> You already use Prometheus, Grafana, and OpenTelemetry. These reads sharpen the *why* behind what you already do, so the book deepens rather than introduces.

| Parent Topic (README Section)   | Topic                           | What to Read (from README)                                                                                                                                                                                                                                                                                                                                  | Why                                                                                                                                                                                 |
|---------------------------------|---------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Networking                      | Networking: where latency hides | [Comprehensive Overview of HTTP Caching Mechanisms](https://medium.com/@mbanaee61/comprehensive-overview-of-http-caching-mechanisms-3381c7041682) + [Ace Your System Design Interview: Essential Application Protocols Explained](https://levelup.gitconnected.com/ace-your-system-design-interview-essential-application-protocols-explained-996e425128d3) | The book teaches you to *find* latency. Understanding where it hides (DNS resolution, TLS handshake, connection pooling, HTTP caching layers) helps you interpret traces correctly. |
| Back-of-the-Envelope Estimation | Latency numbers (revisit)       | [Latency Numbers Every Programmer Should Know](https://gist.github.com/jboner/2841832)                                                                                                                                                                                                                                                                      | Revisit with fresh eyes. After DDIA + Event-Driven, you now understand *what* you're measuring. These numbers become your SLO intuition — "is 200ms reasonable for this operation?" |
| General System Design Resources | Reliability vs Availability     | [Reliability vs Availability: What's the Difference in System Design?](https://medium.com/stackademic/reliability-vs-availability-whats-the-difference-in-system-design-8994dd15dab5)                                                                                                                                                                       | SLOs, SLIs, and error budgets require clear thinking about what "reliable" and "available" mean differently. This short read primes you for the book's SLO framework.               |

---

**Book:** Observability Engineering — Charity Majors, Liz Fong-Jones & George Miranda
**Duration:** 1.5–2 months

> You can't architect what you can't observe. Distributed tracing, metrics, SLOs, and debugging production systems.

### Learning Objectives

- [ ] Explain the difference between monitoring and observability — why dashboards alone fail
- [ ] Define SLOs, SLIs, and error budgets — calculate burn rate
- [ ] Instrument a service with OpenTelemetry: traces, metrics, and structured logs
- [ ] Correlate across three pillars: alert → metric → trace → log to root cause
- [ ] Design high-cardinality observability vs pre-aggregated dashboards
- [ ] Explain sampling strategies (head-based vs tail-based) and cost implications
- [ ] Debug a production latency issue using ONLY traces and metrics

### Book Project: Full Observability Stack on the Saga System

- **Traces:** OpenTelemetry SDK → Grafana Tempo. Trace requests across all 3 services through SQS/SNS
- **Metrics:** Prometheus — message processing latency, queue depth, error rates per service
- **Logs:** Loki with structured JSON logging — trace IDs in every log line
- Define 1 SLO: "99.5% of orders fully processed within 2 seconds"
- Grafana dashboard: "why is the system slow RIGHT NOW?"
- Alert on error budget burning faster than 2% per hour

### Failure Lab (Critical — This Is What Principals Actually Do)

> The ability to diagnose production issues using only observability tooling separates seniors from principals. Dedicate 2-3 sessions to this AFTER instrumentation is complete.

| Injection                                                     | What You're Practicing                                                                          |
|---------------------------------------------------------------|-------------------------------------------------------------------------------------------------|
| Add 500ms latency to Payment Service                          | Finding the slow span in a distributed trace                                                    |
| Return 50% errors from Inventory Service                      | Correlating error rate spike → metric → trace → root cause                                      |
| Simulate SQS message duplication (publish same message twice) | Verifying idempotency works AND that your metrics show the duplicate was handled                |
| Kill Payment Service mid-saga (pod crash)                     | Verifying compensating transactions fire AND observing the saga state in traces                 |
| Introduce 2s GC pause in Order Service                        | Distinguishing application latency from infrastructure latency using JVM metrics vs trace spans |

**Success criteria:** Can you identify each injected failure using ONLY your Grafana dashboards + Tempo traces in under 5 minutes, without reading source code?

### README Topics to Read Alongside

| Book Theme          | README Section                                                             |
|---------------------|----------------------------------------------------------------------------|
| SLOs/SLIs           | Back-of-the-Envelope Estimation (capacity planning connects to burn rates) |
| Distributed tracing | Networking (where latency hides: DNS, TLS, connection pooling)             |

### README Build: DB Replication with Read/Write Splitting + Observability

- Set up PostgreSQL primary/replica with Docker Compose
- Build a Spring Boot app that routes reads to replicas
- **Use your observability stack to detect stale reads** (trace the lag, alert on it)
- Why now: Replication lag is the most common production issue you'll debug. This ties Phase 1 knowledge (replication) to Phase 4 tooling (traces + metrics).

### Writing Output

- Document your SLO definition process
- Present it to your team as a proposal for one real production service

---

## Phase 5: Kubernetes (Production-Grade)

### Prerequisites (1 day)

> You already run 20+ services on EKS. These reads fill specific conceptual gaps the book will build on — networking internals and deployment strategy nuances.

| Parent Topic (README Section) | Topic                   | What to Read (from README)                                                                                                                                                                                                                                                                   | Why                                                                                                                                                                                                 |
|-------------------------------|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Load Balancing                | Load balancing in depth | [The Essential Guide to Load Balancing Strategies and Techniques](https://levelup.gitconnected.com/the-essential-guide-to-load-balancing-strategies-and-techniques-cb17f0d219ee) + [How NGINX Handles MILLIONS of Requests With Just 1 Process](https://www.youtube.com/watch?v=I6dpN0geIb4) | K8s networking (kube-proxy, Ingress controllers) is essentially L4/L7 load balancing. Understanding NGINX's event loop helps you reason about Ingress controller performance and connection limits. |
| Load Balancing                | Sticky sessions         | [Sticky Sessions: An In-Depth Overview](https://medium.com/@aditimishra_541/sticky-sessions-an-in-depth-overview-4ec19bd7e22a)                                                                                                                                                               | Relevant for understanding why StatefulSets and headless services exist, and what breaks when K8s routes traffic to a different pod mid-session.                                                    |
| Networking                    | Data centers            | [Data Centers in System Design](https://levelup.gitconnected.com/data-centers-in-system-design-ad5c17ace22d)                                                                                                                                                                                 | The K8s book covers multi-zone scheduling, node affinity, and topology-aware routing. Understanding data center topology gives physical context to these abstractions.                              |

---

**Book:** The Kubernetes Book, 3rd Edition — Nigel Poulton & Pushkar Joglekar
**Duration:** 1.5 months

> Fill gaps in K8s networking, storage, RBAC, and operators. Deepen your daily operational knowledge.

### Learning Objectives

- [ ] Explain K8s networking: pod-to-pod, pod-to-service, and external traffic flows (kube-proxy, CNI, Ingress)
- [ ] Configure RBAC: roles, bindings, service accounts with least-privilege
- [ ] Design persistent storage: PV, PVC, StorageClasses, StatefulSets vs Deployments
- [ ] Implement autoscaling: HPA (CPU, custom metrics), VPA, cluster autoscaler
- [ ] Write NetworkPolicies: default-deny + explicit allow
- [ ] Design zero-downtime deployments and PodDisruptionBudgets
- [ ] Systematic pod debugging: events, describe, exec, logs

### Book Project: Deploy Saga System to K8s

- Deploy to kind/minikube with LocalStack for SQS/SNS
- Package services with Helm charts
- Liveness/readiness probes (readiness fails during message processing backlog)
- HPA based on SQS queue depth (KEDA)
- NetworkPolicies isolating services
- RBAC per namespace
- CronJob for data cleanup
- **Chaos testing:** Kill pods mid-saga, verify compensating transactions still complete
- Rolling update with zero downtime — verify no messages lost during deployment

### README Topics to Read Alongside

| Book Theme           | README Section                                    |
|----------------------|---------------------------------------------------|
| Networking & Ingress | Load Balancing (revisit: L4 vs L7 in K8s context) |

### README Build: None

The book project is already substantial. Focus on operational excellence, not new concepts.

### Writing Output

- A chaos test runbook: "When X fails, we expect Y behavior. Here's how to verify."

---

## Phase 6: Database Internals

### Prerequisites (2–3 days)

> DDIA (Phase 1) is the main prerequisite — it introduced storage engines at a conceptual level. These reads prepare you for the *mechanical* deep dive this book provides.

| Parent Topic (README Section) | Topic                               | What to Read (from README)                                                                                                                                                                  | Why                                                                                                                                                                                                                                                  |
|-------------------------------|-------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Hashing                       | Hashing (revisit for bloom filters) | [Separate Chaining](https://www.scaler.com/topics/data-structures/separate-chaining/) + [Double Hashing](https://www.scaler.com/topics/data-structures/double-hashing/)                     | DB Internals uses hash-based structures everywhere — bloom filters, hash indexes, hash joins. Revisit collision handling and probability of false positives.                                                                                         |
| Bloom Filters                 | Bloom filters intro                 | [How Big Tech Checks Your Username in Milliseconds](https://www.youtube.com/watch?v=_l5Q5kKHtR8) + [Bloom Filters - Hashtable - System Design](https://www.youtube.com/watch?v=GT0En1dGntY) | The book dives into bloom filters as part of LSM-tree read optimization. Watching these short videos first gives you a visual mental model before the formal treatment.                                                                              |
| Consistent Hashing            | Consistent hashing (revisit)        | [Consistent Hashing - explanation and implementation](https://arpitbhayani.me/blogs/consistent-hashing/)                                                                                    | The book covers distributed storage, data placement, and rebalancing. If you built the consistent hashing project in Phase 1, revisit your implementation. If not, read this article — the book assumes you understand hash-ring-based distribution. |
| Database Indexing             | DB indexing deep dive               | [DB Indexing in System Design Interviews - B-tree, Geospatial, Inverted Index](https://www.youtube.com/watch?v=BHCSL_ZifI0)                                                                 | This video covers B-tree structure visually. The book goes much deeper (page splits, merges, write amplification), but having the visual foundation makes the text easier to follow.                                                                 |

---

**Book:** Database Internals — Alex Petrov
**Duration:** 3–4 months

> Unique knowledge that 95% of engineers lack. B-Trees, LSM-Trees, consensus protocols, distributed storage internals.
>
> **Connection to Phase 1:** You already built a simpler KV store in Java (hash index + append-only log). This time you build a *complete* LSM-tree in Go — with bloom filters, proper compaction, and crash recovery. The conceptual overlap is intentional: Phase 1 gave you intuition, Phase 6 gives you mechanical understanding. Different language forces you to relearn instead of copy-paste.

### Learning Objectives

- [ ] Explain how B-Trees store data on disk — pages, splits, merges, write amplification
- [ ] Explain the LSM-Tree write path (WAL → memtable → SSTable) and read path (bloom filters, merge strategy)
- [ ] Compare B-Tree vs LSM-Tree: write/read/space amplification trade-offs
- [ ] Explain Raft consensus: leader election, log replication, safety, split-brain prevention
- [ ] Describe distributed database failure handling: gossip, failure detectors, anti-entropy
- [ ] Explain WAL: why it exists, crash recovery, performance implications
- [ ] Choose the right database for a workload based on storage engine internals

### Book Project: LSM-Tree Storage Engine (Go)

- **Write path:** WAL → memtable → flush to SSTable at size threshold
- **Read path:** memtable → bloom filter → SSTables (newest first)
- **Deletes:** Tombstone markers, removed during compaction
- **Compaction:** Merge overlapping SSTables, discard tombstones
- **Crash recovery:** Replay WAL on startup
- CLI: `put key value`, `get key`, `delete key`, `stats`
- Benchmark: 1M keys — write throughput, read latency (existing vs non-existing keys)

### README Topics to Read Alongside

| Book Theme              | README Section                                        |
|-------------------------|-------------------------------------------------------|
| B-trees & LSM-trees     | Database Indexing (revisit with deeper understanding) |
| Consensus (Raft, Paxos) | Leader Election (revisit)                             |
| Distributed storage     | Hashing + Bloom Filters                               |

### README Build: Bloom Filter Service

- Build a username-availability or cache-miss filter using a Bloom filter in front of PostgreSQL/Redis
- Measure false positive rates at different filter sizes
- Why now: DB Internals explains bloom filters in the context of LSM-tree reads. Building one makes the false-positive trade-off concrete, and your LSM-tree project uses one internally.

### Writing Output

- Technical blog post: Compare your LSM-tree's performance to PostgreSQL's B-tree engine, with benchmarks and analysis of when each wins.

---

## Phase 7: Systems Programming in Go (Capstone)

### Prerequisites (2–3 days)

> Your Go CLI tools and REST API experience cover the basics. These reads bridge the gap from application-level Go to systems-level Go.

| Parent Topic (README Section)   | Topic                                                  | What to Read (from README)                                                                                                                                                                                                                             | Why                                                                                                                                                                                                                                              |
|---------------------------------|--------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Networking                      | Networking protocols (revisit at implementation level) | [Top 20 Network Protocols You Must Know in System Design](https://interviewnoodle.com/top-20-network-protocols-you-must-know-in-system-design-81eaab4b0c36) + [System design of DNS](https://medium.com/@lazygeek78/system-design-of-dns-6a7532bdf0a0) | You're now *implementing* a network server (the TSDB accepts metrics via HTTP). Understanding TCP connection lifecycle, keep-alive, and protocol design at the wire level matters.                                                               |
| General System Design Resources | Time Series Databases                                  | [Time Series Databases and InfluxDB](https://dilipkumar.medium.com/time-series-databases-and-influxdb-2df5f5b06175)                                                                                                                                    | Your capstone IS a TSDB. Understanding how InfluxDB and Prometheus approach ingestion, storage, and retention gives you reference architectures to study before designing your own.                                                              |
| Back-of-the-Envelope Estimation | Back-of-envelope: storage math                         | [Latency Numbers Every Programmer Should Know](https://gist.github.com/jboner/2841832) (revisit final time)                                                                                                                                            | For your TSDB design, you need to calculate: "If I ingest 100K points/sec, how much disk do I need per day? What's the write amplification of my compression scheme?" Revisit these numbers one final time — now you're *designing* around them. |

---

**Book:** Practical Systems Programming in Go — Mihalis Tsoukalos
**Duration:** 2–3 months

> Low-level systems work: networking, file I/O, binary formats, OS interaction. Deepens Go beyond CLIs and REST APIs.

### Learning Objectives

- [ ] Implement low-level file I/O: binary read/write, memory-mapped files, buffered vs direct I/O
- [ ] Build network servers: TCP listeners, connection pooling, protocol parsing, graceful shutdown
- [ ] Manage OS resources: signals, process management, file descriptors, system calls
- [ ] Handle systems-level concurrency: goroutines with shared file access, channel pipelines
- [ ] Implement custom binary serialization with minimal allocations
- [ ] Profile and optimize: pprof, benchmarks, reducing GC pressure
- [ ] Design a complete systems tool end-to-end

### Book Project: Time-Series Database (Go) — The Capstone

- **Ingestion:** HTTP `POST /write` — metric name, tags, timestamp, value. Concurrent writes via goroutines
- **Storage:** Custom binary format, time-based partitioning (one file per hour). Delta encoding for timestamps, XOR compression for floats (same as Prometheus)
- **Queries:** HTTP `GET /query?metric=cpu&from=now-5m&fn=avg` — support avg, max, min, count
- **Retention:** Auto-delete partitions older than configurable TTL
- **Benchmarks:** Write throughput (points/sec), query latency, compression ratio vs raw JSON
- **Constraint:** No external dependencies beyond stdlib (except HTTP router). Forces you to confront every systems problem directly.

### README Topics to Read Alongside

| Book Theme      | README Section                                           |
|-----------------|----------------------------------------------------------|
| Network servers | Networking (revisit: now implementing, not just reading) |

### README Build: None

The TSDB *is* the capstone. It combines everything: Go concurrency, storage internals from Phase 6, binary encoding, HTTP serving, and partitioning from Phase 1.

### Writing Output

- GitHub repo with README documenting architecture decisions, benchmarks, trade-offs, and what you'd do differently at scale. Portfolio-level work.

---

## On-Demand Topics (Not Attached to Any Phase)

Read or build these **only when a work project demands it:**

| Topic                     | Trigger to Start                                           |
|---------------------------|------------------------------------------------------------|
| Elasticsearch & Search    | You get a search feature assigned                          |
| OAuth2 server             | You need to customize auth beyond Spring Security defaults |
| Object Storage / S3       | You're designing a file-heavy system                       |
| Multi-Tenancy             | You're building a SaaS product                             |
| Distributed ID Generation | UUID perf issues in PostgreSQL indexes                     |
| WebSocket builds          | You're implementing real-time features                     |

---

## The Compound Loop (Why This Works)

```
┌─────────────────────────────────────────────────────────┐
│                                                         │
│   READ (book)                                           │
│     ↓                                                   │
│   REINFORCE (README articles, same theme)               │
│     ↓                                                   │
│   BUILD (book project + 1 README build max)             │
│     ↓                                                   │
│   WRITE (doc, ADR, blog post — forces clarity)          │
│     ↓                                                   │
│   APPLY AT WORK (the real test)                         │
│     ↓                                                   │
│   "What decision would I make differently now?"         │
│     └──────────────── if no answer → revisit phase ─────┘
│
└─────────────────────────────────────────────────────────┘
```

---

## Writing Standards (What "Write About It" Means)

> Writing is thinking. Every phase requires output. Here's what counts:

| Format                  | When to Use                                 | Length                                                    | Example                                                                                    |
|-------------------------|---------------------------------------------|-----------------------------------------------------------|--------------------------------------------------------------------------------------------|
| **Reflection note**     | After each book Part or major chapter       | 1 page max                                                | "DDIA Part II changed how I think about our Aurora replication. Here's what I'd change..." |
| **ADR**                 | When you make or evaluate a design decision | Template: Context → Decision → Consequences               | "We chose choreography over orchestration because..."                                      |
| **Design doc / RFC**    | Before building a project                   | 1-2 pages: Problem → Options → Decision → Trade-offs      | Written BEFORE code. Forces you to think before typing.                                    |
| **Post-mortem**         | After completing a project                  | 1 page: What worked → What surprised me → What I'd change | Honest assessment of what you actually learned vs planned.                                 |
| **Technical blog post** | After Phase 6 & 7 (deep systems work)       | 1500-2500 words with benchmarks/diagrams                  | Publishable quality. Forces you to explain to others.                                      |

**Rule:** If you can't explain it in writing, you don't understand it well enough to apply it at work.

---

## Rules to Protect Execution

1. **One book at a time.** Never start book N+1 until book N's reading is done. The project can spill into the next phase's first week — but the *reading* must be complete before moving on.
2. **One README build per phase max.** Resist scope creep. The book project is the priority.
3. **30 min on a Tuesday night counts.** Consistency > intensity. Don't skip a day because you can't do 2 hours.
4. **If you finish a phase and can't answer "what would I do differently at work?" — the phase didn't land.** Revisit before moving on.
5. **It's a menu, not a checklist.** If a README section doesn't resonate during the phase, skip it. Come back later or never.
6. **Writing is non-negotiable.** If you didn't write about it, you didn't learn it deeply enough for principal-level work.
7. **A stalled project doesn't block reading within the current book.** If your build is stuck, keep reading the next chapters. Come back to the code with fresh context. See the escape hatch section for cross-phase stalls.
8. **Review this plan quarterly.** Your priorities at work will shift. A topic in "On-Demand" might become urgent. A phase might become less relevant. Adjust — but don't abandon the structure.

---

## Final Self-Assessment (After All 7 Phases)

> After ~22 months, use this checklist to verify the plan actually worked. These map to the "Principal-Level Distributed Systems Understanding" section from the README.
> For each item, you should be able to **explain it to a staff engineer, give a real example from your work or projects, and articulate the trade-offs involved.**

- [ ] CAP Theorem and PACELC — explain with a real system example (e.g., your Aurora cluster during a partition)
- [ ] Consistency models: strong, eventual, causal, read-your-writes — know which your production services use and why
- [ ] Consensus, quorums, and leader election — explain Raft from your Go LSM-tree or reference your KV store
- [ ] Distributed transactions: 2PC, Saga, compensation — built and tested this in Phase 3
- [ ] Idempotency, retries, deduplication — implemented in your saga; can explain the "exactly-once" myth
- [ ] Failure detection, split-brain, and network partitions — observed in your failure lab (Phase 4)
- [ ] Logical time and ordering: Lamport clocks, vector clocks — explain why SQS message ordering is hard
- [ ] Backpressure, flow control, and load shedding — implemented via your rate limiter (Phase 3)
- [ ] Multi-region architecture and disaster recovery — can design one even if you haven't built one
- [ ] Data distribution: sharding keys, hot partitions, rebalancing — built consistent hashing (Phase 1), understand from DDIA
- [ ] Reliability engineering: SLIs, SLOs, SLAs, error budgets — defined and proposed at work (Phase 4)
- [ ] Graceful degradation, fault isolation, and chaos engineering — tested in Phases 4 and 5
- [ ] Capacity planning, cost modeling, and trade-off analysis — can do back-of-envelope for any system

**If you can check off 11+ of 13:** The plan worked. You've internalized principal-level distributed systems thinking.
**If 8-10:** Good progress. Identify the gaps and revisit the relevant phase's book/project.
**If <8:** Something went wrong with depth. You read but didn't apply. Go back to the compound loop.

