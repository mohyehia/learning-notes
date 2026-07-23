# O'Reilly Reading List (Priority Order)

> **7 books. Realistic timeline: ~18 months (1.5 years).**
> Each book has a hands-on project to cement the knowledge.
> Assumes ~5-8 hours/week with a full-time principal engineering job.
>
> | Book                                     | Estimated Duration |
> |------------------------------------------|--------------------|
> | 1. DDIA + KV store                       | 3-4 months         |
> | 2. Fundamentals SA + architecture review | 1.5 months         |
> | 3. Event-Driven + 3 services             | 2-3 months         |
> | 4. K8s + deployment                      | 1.5 months         |
> | 5. Observability + instrumentation       | 1.5-2 months       |
> | 6. DB Internals + LSM-tree               | 3-4 months         |
> | 7. Systems Go + TSDB                     | 2-3 months         |
>
> *Don't rush. Consistency beats intensity. 30 min of reading on a Tuesday night compounds.*

## 🔴 Tier 1 — Architecture & Distributed Systems (Core to Principal Role)

### ⭐ 1. Designing Data-Intensive Applications, 2nd Edition
By Martin Kleppmann and Chris Riccomini
> The #1 book for distributed systems engineers. Covers storage, replication, partitioning, transactions, and stream processing. Everything else builds on this.

**🎯 Learning Objectives:**
- [ ] Explain the trade-offs between B-Tree and LSM-Tree storage engines and when to choose each
- [ ] Compare single-leader, multi-leader, and leaderless replication — know failure modes of each
- [ ] Design a partitioning strategy (hash vs range) for a given dataset and access pattern
- [ ] Explain why distributed transactions are hard and what guarantees 2PC provides vs its costs
- [ ] Describe exactly-once vs at-least-once vs at-most-once semantics and when each is acceptable
- [ ] Articulate the difference between stream processing and batch processing and when to use each
- [ ] Draw a data pipeline from ingestion to query for a real system, labeling replication, partitioning, and consistency boundaries

**🛠 Project:** Build a mini key-value store in Java with:
- Two storage engines: hash index vs log-structured (LSM-tree-like) append-only engine
- Write-ahead log for crash recovery
- Basic compaction (merge SSTables, remove tombstones)
- Simple TCP server so you can `telnet` into it (`GET key`, `SET key value`, `DEL key`)
- Benchmark: compare write throughput, read latency, and space amplification between the two engines at 100K, 1M, and 10M keys
- Write a blog post or internal doc explaining which engine wins for which workload and why

> This makes Chapters 3-4 visceral and gives you a reference implementation you'll think about every time you choose a database.

---

### ⭐ 2. Fundamentals of Software Architecture, 2nd Edition
By Mark Richards and Neal Ford
> Shifts your mindset from implementation to architectural thinking — trade-off analysis, modularity, component design. Essential at principal level.

**🎯 Learning Objectives:**
- [ ] Identify and compare 8+ architecture styles (layered, microservices, event-driven, space-based, etc.) with their trade-offs
- [ ] Define architecture characteristics (the "-ilities") for a system and explain which ones conflict
- [ ] Use the architecture quantum concept to determine deployment boundaries
- [ ] Write Architecture Decision Records (ADRs) that capture context, decision, and consequences
- [ ] Design architecture fitness functions — automated tests that validate architectural properties
- [ ] Analyze component coupling and cohesion to determine where to draw module boundaries
- [ ] Present an architecture trade-off analysis to a non-technical stakeholder

**🛠 Project:** Conduct a mini architecture review of a real system at work:
- Identify its architecture style (layered? microservices? event-driven hybrid?)
- Document its top 3 architecture characteristics (scalability, availability, etc.) and which ones are being sacrificed
- Write 2-3 Architecture Decision Records (ADRs) for key decisions — including one you disagree with
- Define one architecture fitness function (automated test that validates an architectural property, e.g., "no service-to-service calls exceed 200ms p99")
- Present findings to your team. Start an ADR repository if one doesn't exist

> This exercises the book's full framework — not just writing docs, but evaluating real systems through an architectural lens.

---

### ⭐ 3. Building Event-Driven Microservices, 2nd Edition
By Adam Bellemare
> Redefines how you think about data ownership and service boundaries. Broker-agnostic patterns (event sourcing, CQRS, event-driven topologies) that apply to any message system.

**🎯 Learning Objectives:**
- [ ] Explain the difference between event notification, event-carried state transfer, and event sourcing — know when to use each
- [ ] Design data ownership boundaries: which service owns which data, and how others get access (events, not shared DBs)
- [ ] Implement a choreography-based saga with compensating transactions for distributed consistency
- [ ] Handle schema evolution in events without breaking existing consumers
- [ ] Design idempotent event consumers that handle at-least-once delivery safely
- [ ] Explain CQRS: when it adds value vs when it's over-engineering
- [ ] Identify when event-driven architecture is the WRONG choice (request-response is better)

**🛠 Project:** Build a small event-driven system with 3 Spring Boot services communicating via AWS SQS/SNS:
- Order Service → publishes `OrderPlaced` to SNS → SQS queues fan out to Inventory Service + Payment Service
- Implement a choreography-based saga with compensating transactions (payment fails → `PaymentFailed` → Inventory rolls back)
- Add idempotency handling (SQS delivers at-least-once — what if a message arrives twice?)
- Add dead-letter queues with a DLQ processor that alerts and retries
- Add message schema versioning (v1 → v2 of `OrderPlaced` — handle both without breaking consumers)
- Write integration tests that verify the full saga completes correctly (happy path + compensation path)
- Containerize everything with Docker Compose for one-command local startup

> This builds the HARD parts of event-driven systems: idempotency, schema evolution, and saga correctness — not just the happy path.

---

## 🟠 Tier 2 — Build & Operate (Deploy, Observe)


### ⭐ 4. Observability Engineering
By Charity Majors, Liz Fong-Jones and George Miranda
> You can't architect what you can't observe. Distributed tracing, metrics, SLOs, and debugging production systems. Non-negotiable for solutions architects owning distributed systems.

**🎯 Learning Objectives:**
- [ ] Explain the difference between monitoring and observability — why dashboards alone fail for distributed systems
- [ ] Define SLOs, SLIs, and error budgets — calculate whether a system is within budget or burning too fast
- [ ] Instrument a service with OpenTelemetry: traces (spans, context propagation), metrics (counters, histograms), and structured logs
- [ ] Correlate across the three pillars: go from alert → metric → trace → log to identify root cause
- [ ] Design high-cardinality observability (per-user, per-request) vs pre-aggregated dashboards — know when each matters
- [ ] Explain sampling strategies (head-based vs tail-based) and when to use each to control costs
- [ ] Debug a production latency issue using ONLY traces and metrics, without reading source code

**🛠 Project:** Instrument your event-driven system with the full observability stack (all three pillars):
- **Traces:** OpenTelemetry SDK → Grafana Tempo. Trace a request from Order Service through SNS/SQS to Inventory and Payment completion
- **Metrics:** Prometheus — message processing latency, queue depth, error rates per service
- **Logs:** Loki with structured JSON logging — inject trace IDs into every log line for correlation
- Define 1 SLO: "99.5% of orders fully processed (saga complete) within 2 seconds"
- Build a Grafana dashboard that answers: "why is the system slow RIGHT NOW?" (traces + metrics + logs on one screen)
- Build an alert that fires when error budget burns faster than 2% per hour
- **Debugging exercise:** Intentionally inject 500ms latency into Payment Service. Use ONLY your observability stack to identify the bottleneck without reading the code

> The debugging exercise proves your observability actually works. If you can't find the injected latency in under 5 minutes, your instrumentation has gaps.

---

### 5. The Kubernetes Book - Third Edition
By Nigel Poulton and Pushkar Joglekar
> Good for filling gaps in K8s knowledge. Covers networking, storage, RBAC, and operators. Practical enough to deepen your daily usage.

**🎯 Learning Objectives:**
- [ ] Explain K8s networking: how pod-to-pod, pod-to-service, and external traffic flows through kube-proxy, CNI, and Ingress
- [ ] Configure RBAC: create roles, bindings, and service accounts with least-privilege for multi-team clusters
- [ ] Design persistent storage: understand PV, PVC, StorageClasses, and when to use StatefulSets vs Deployments
- [ ] Implement autoscaling: HPA (CPU, custom metrics), VPA, and cluster autoscaler — know which to use when
- [ ] Write NetworkPolicies that enforce service isolation (default-deny + explicit allow)
- [ ] Design a zero-downtime deployment strategy (rolling update, blue-green, canary) and explain PodDisruptionBudgets
- [ ] Debug a failing pod: read events, describe resources, exec into containers, check logs — systematic troubleshooting

**🛠 Project:** Deploy your event-driven system (from book #3) to a local K8s cluster (kind or minikube) with LocalStack for SQS/SNS:
- Package services with Helm charts (templated, reusable across environments)
- Implement proper liveness/readiness probes (readiness fails during message processing backlog)
- HPA based on SQS queue depth (ApproximateNumberOfMessages via CloudWatch metrics or KEDA)
- NetworkPolicies isolating services (Inventory can't talk to Payment directly)
- RBAC per namespace (dev team can't access prod namespace)
- CronJob for data cleanup (purge processed messages older than 7 days)
- Chaos testing: kill pods mid-saga, verify compensating transactions still complete after recovery
- Rolling update with zero downtime — verify no messages are lost during deployment

> This separates "deployed to K8s" from "production-ready on K8s." The chaos testing proves your saga design actually works under failure.

---

## 🔵 Tier 3 — Deep Systems Knowledge (Go Systems Programming)

### ⭐ 6. Database Internals
By Alex Petrov
> Unique knowledge that 95% of engineers lack. B-Trees, LSM-Trees, consensus protocols, distributed storage internals. Gives you an unfair advantage when making data architecture decisions.

**🎯 Learning Objectives:**
- [ ] Explain how B-Trees store and retrieve data on disk — pages, splits, merges, and write amplification
- [ ] Explain the LSM-Tree write path (WAL → memtable → SSTable) and read path (bloom filters, merge strategy)
- [ ] Compare B-Tree vs LSM-Tree: write amplification, read amplification, space amplification trade-offs
- [ ] Explain Raft consensus: leader election, log replication, safety guarantees, and split-brain prevention
- [ ] Describe how distributed databases handle node failures: gossip protocols, failure detectors, anti-entropy
- [ ] Explain write-ahead logging: why it exists, how crash recovery works, and its performance implications
- [ ] Choose the right database for a given workload based on understanding of its internal storage engine

**🛠 Project:** Build a complete mini LSM-tree storage engine in Go:
- **Write path:** append to WAL → insert into memtable (sorted in-memory structure) → flush to SSTable when memtable hits size threshold
- **Read path:** check memtable → check bloom filter → scan SSTables (newest first)
- **Deletes:** tombstone markers, removed during compaction
- **Compaction:** merge overlapping SSTables, discard tombstones, reduce read amplification
- **Crash recovery:** replay WAL on startup to rebuild memtable
- Add a simple CLI: `put key value`, `get key`, `delete key`, `stats` (show SSTable count, memtable size)
- Benchmark: write 1M keys, measure write throughput, read latency for existing vs non-existing keys

> This is a complete storage engine — the same design underneath PostgreSQL, Cassandra, RocksDB, and LevelDB. You'll never look at a database the same way.

---

### 7. Practical Systems Programming in Go
By Mihalis Tsoukalos
> Apply Go to real systems work — networking, OS interaction, file I/O. Deepens your Go beyond CLIs and REST APIs into low-level systems territory.

**🎯 Learning Objectives:**
- [ ] Implement low-level file I/O: binary read/write, memory-mapped files, buffered vs direct I/O trade-offs
- [ ] Build network servers: TCP listeners, connection pooling, protocol parsing, graceful shutdown
- [ ] Manage OS-level resources: signals, process management, file descriptors, system calls
- [ ] Handle concurrency at the systems level: goroutines with shared file access, lock-free data structures, channel patterns for pipeline processing
- [ ] Implement custom binary serialization formats: encoding/decoding with minimal allocations
- [ ] Profile and optimize: pprof for CPU/memory, benchmarks, reducing GC pressure in hot paths
- [ ] Design a complete systems tool from requirements to shipping: architecture decisions, error handling strategy, configuration, and testing

**🛠 Project:** Build a time-series database in Go (your capstone):
- **Ingestion:** Accept metrics via HTTP (`POST /write` with metric name, tags, timestamp, value). Handle concurrent writes from multiple goroutines safely
- **Storage:** Custom binary format with time-based partitioning (one file per hour). Use delta encoding for timestamps and XOR compression for float values (this is how Prometheus stores data)
- **Queries:** Support basic queries via HTTP (`GET /query?metric=cpu&from=now-5m&fn=avg`). Implement: avg, max, min, count over time ranges
- **Retention:** Auto-delete partitions older than configurable TTL (goroutine runs every hour)
- **Benchmarks:** Measure write throughput (points/sec), query latency, compression ratio vs raw JSON storage
- Publish to GitHub with a README explaining the architecture choices

> This is a real systems project that ties together: Go concurrency (goroutines for writes + retention), file I/O, binary encoding, and DB internals (partitioning, compression, time-based access patterns). It's portfolio-worthy and demonstrates systems thinking.

---

**Removed from list (low ROI or learnable through practice):**
- ~~Kafka: The Definitive Guide~~ — Tool-specific; you use AWS SQS/SNS at work, not Kafka. Event-driven patterns from book #3 are broker-agnostic.
- ~~Learning Go~~ — Already know Go; built CLI tools and REST APIs
- ~~Software Architecture: The Hard Parts~~ — Decomposition decisions covered by Fundamentals + Event-Driven Microservices combined; pick up later if you need deeper trade-off frameworks
- ~~Learning Domain-Driven Design~~ — Strategic concepts already covered in Fundamentals; watch Khononov's conference talk instead (45 min vs 342 pages)
- ~~Modern Concurrency in Java~~ — Virtual threads are simple enough to learn from JEP docs + Baeldung + conference talks
- ~~The Effective Software Engineer~~ — General productivity tips, too introductory at principal level
- ~~Learning DevSecOps~~ — Too broad/introductory, better learned through AWS + CI/CD docs
- ~~Security and Microservice Architecture on AWS~~ — Replaced then removed; learn through AWS IAM + service mesh docs
- ~~Java Microservices and Containers in the Cloud~~ — You already live this daily
- ~~Designing Distributed Systems (Brendan Burns)~~ — Redundant with DDIA + K8s Book + DB Internals
- ~~Building Resilient Distributed Systems (Sam Newman)~~ — Overlaps with DDIA + Fundamentals SA; resilience patterns learned through production experience
- ~~System Design on AWS~~ — You already design on AWS daily; Well-Architected Framework (free) is more current
- ~~Site Reliability Engineering~~ — 500+ pages, Google-specific; key concepts (SLOs, error budgets) covered in Observability Engineering
- ~~Amazon DynamoDB Guide~~ — Reference book; read only when you start a DynamoDB project
- ~~Prompt Engineering for LLMs~~ — Better learned hands-on through Spring AI exploration
- ~~Zero Trust Networks~~ — Important concept but learnable through AWS security docs + service mesh practice
