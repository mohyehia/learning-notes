# Infra Project Ideas

## **🗺️ The 9-Project Infra Roadmap**

## **📦 Project 1: goku (The Concurrent HTTP Load-Tester)** _(Done)_

- **The Core Focus:** Pure concurrency speed, synchronization, and CLI interface basics.
- **What you master:** * The **Worker Pool Pattern** (chan, sync.WaitGroup).
- Real-time terminal UI manipulation (\r carriage returns).
- Graceful OS interruption (os/signal handling for Ctrl+C).
- **SRE telemetry computation (calculating P50/P90/P99 latencies mathematically from scratch).**

---

## **🛠️ Project 2: Kubectl Clone (Control Plane Client / Cobra)**

### 📋 Key Features & Commands to Implement:

- Global Config Handling: `stridectl --kubeconfig`
    - **The Tech Challenge:** Parse the standard `~/.kube/config` YAML file. You must implement code that reads the current context, extracts the TLS certificate authority, client keys, or bearer tokens, and dynamically configures an encrypted Go HTTP client.
- `stridectl get <resource_type>` (e.g., `get pods`, `get services`)
    - **The Tech Challenge:** *Do not hardcode a pod struct.* Learn to use Go's `dynamic.Interface` or unmarshal payloads into `unstructured.Unstructured` maps.
    - **Sub-flag Requirements to Implement:** * `o json` / `o yaml` (Teaches data serialization engines).
        - `n <namespace>` or `A` (Teaches URL path construction patterns).
- `stridectl describe <type> <name>`
    - **The Tech Challenge:** This requires you to execute **Resource Graph Traversal**. When a user types `describe pod my-pod`, your engine must fetch the pod, scan its metadata, and then issue secondary asynchronous API calls to fetch associated Events or Services, stitching them together into a structured, plain-text tree view.
- `stridectl apply -f <file.yaml>`
    - **The Tech Challenge:** Implement the **Server-Side Apply** or **Two-Way Merge Patch** mechanism. Your tool must read a local YAML layout configuration, figure out if the resource already exists on the cluster, calculate a delta patch, and send a `PATCH` request with the correct content-type header (`application/apply-patch+yaml`).

---

## **📐 Project 3: terrafake (Algorithmic Graph Execution Engine)**

**The Core Concept:** Deep-dive into cloud-native control plane automation, declarative dependency graphs, and multi-process network coordination. Instead of hardcoding steps sequentially, you will build a local infrastructure-as-code automation tool from scratch that maps configurations into memory trees, optimizes execution pathways via parallel thread dispatching, and interfaces directly with local cloud emulators like `Floci` or `LocalStack`.

## **🏛️ The Choice of Track:**

- **The Graph Compiler & Simulator Track:** Focuses purely on computer science parsing data structures, tree-sorting algorithms, and managing intricate thread synchronization mechanics using localized text simulations.
- **The Emulator Ingress Track (Recommended):** Extends the core simulator by wrapping workers inside raw HTTP/REST protocol clients that interact with local cloud emulators to dynamically create and audit actual system resources.

## **🧠 Architectural Patterns You'll Master:**

- **Directed Acyclic Graph (DAG) Compiling:** Parsing declarative template structures into memory vertices and validating structural boundaries to guarantee clean, loop-free execution pathways.
- **Topological Sorting (Cycle Detection):** Implementing graph traversal algorithms (like Kahn’s Algorithm or Post-Order Depth-First Search) to automatically detect circular logic errors and determine exact resource creation order.
- **Concurrent Fan-Out/Fan-In Graph Walking:** Architecting a high-performance worker pool utilizing Go channels and synchronization primitives (`sync.WaitGroup`) to deploy completely independent resources in parallel while explicitly stalling dependent elements.
- **Wire-Protocol Client Engineering:** Bypassing heavy cloud vendor SDKs to construct raw HTTP standard-library requests (`PUT`, `POST`, `DELETE`), exposing the true underlying API schemas that run global infrastructure systems.
- **Graceful Error Circuit-Breaking:** Engineering fault-tolerant traversal routines that safely interrupt the entire runtime pipeline, cancel active routines via Go context propagation, and protect downstream systems from cascading failures if a parent deployment task drops off the wire.

---

## **🔍 Project 4: Log-Shipper (Data Plane File Tailing)**

**The Core Focus:** High-throughput Data Plane file streaming, bounded memory buffering, and real-time observability.

### 🏛️ The 4-Stage Architecture

- **The Input Engine (Harvester):** A single-threaded disk tracker using native `os.File` and `bufio.Reader` to stream data and track file pointers.
- **The Bounded Buffer:** A memory-bounded Go channel acting as a shock absorber to decouple disk reads from processing.
- **The Parser Pool:** A concurrent worker pool that pulls raw bytes from the buffer, decodes dynamic JSON rows, and handles malformed data.
- **The Network Shipper:** An HTTP client that batches parsed logs by count or timeout threshold to optimize network efficiency.

### 🧠 Core Mastery

- **File-Tailing Mechanics:** Managing OS file descriptors, handling truncation/rotation, and tracking state checkpoints.
- **Producer-Consumer Patterns:** Coordinating multi-threaded pipelines cleanly using channels and wait groups.
- **Memory Optimization:** Reusing byte allocations via `sync.Pool` to prevent garbage collection spikes under heavy load.
- **Observability:** Instrumenting the pipeline with the Prometheus client library to expose real-time metrics (e.g., total logs parsed, buffer saturation, shipment latency) via a `/metrics` endpoint.

---

## 🛡️ Project 5: L7 API Gateway, Load Balancer & Service Proxy

**The Core Focus:** Layer 7 request routing, reverse proxy multiplexing, traffic isolation, edge security, AND east-west service resilience patterns (circuit breaking, mTLS, retry budgets).

> This project combines API Gateway (north-south) and Service Mesh proxy (east-west) concepts into ONE codebase with two operating modes. You build it once, learn both traffic patterns.

### 🏛️ The 5-Stage Architecture

- **The Listener:** A high-performance HTTP/TCP entry point that terminates client connections and parses inbound protocol headers.
- **The Middleware Chain:** A sequential pipeline that intercepts requests to enforce edge policies (Rate-Limiting, Authentication, mTLS termination) before they reach the router.
- **The Dynamic Router:** An abstraction layer that inspects request paths (e.g., `/v1/auth/*`) or service identity headers and selects an optimal backend node using thread-safe balancing algorithms.
- **The Resilience Layer:** Per-upstream circuit breakers, retry budgets, and timeout propagation — ensuring one failing backend doesn't cascade into the entire system.
- **The Reverse Proxy Engine:** The outbound transport layer that forwards requests to upstream servers, manages connection pools, and emits per-request observability metrics.

### 🏛️ The Choice of Mode:

- **Gateway Mode (North-South):** Listens on a public port, routes by URL path, enforces JWT auth and rate limiting at the edge.
- **Sidecar Mode (East-West):** Listens on localhost, routes by service name via config, enforces mTLS and circuit breaking between services. Application doesn't know the proxy exists.

### 🧠 Core Mastery

- **Reverse Proxy Mechanics:** Deeply understanding connection multiplexing, manipulating HTTP headers (X-Forwarded-For, X-Request-ID), and streaming request/response bodies without memory leaks.
- **Connection Hijacking & WebSockets Protocol Upgrades**: Intercepting connection upgrade headers (e.g., `Connection: Upgrade`), utilizing Go’s `http.Hijacker` interface to gain direct ownership of the raw underlying TCP network socket, and bidirectionally piping raw bits between the client and upstream server.
- **Thread-Safe Load Balancing:** Implementing concurrent Round-Robin or Weighted Least-Connection algorithms across dynamic backend pools using Go atomic operations.
- **Edge Throttling & Security:** Building an in-memory Token-Bucket rate limiter to reject traffic at the door, alongside JWT cryptographic verification middleware.
- **Circuit Breaking (Service Mesh Pattern):** Track error rates per upstream over a sliding window. When failures exceed threshold (e.g., 50% in 10s), open the circuit — return errors immediately without forwarding. After a cooldown, half-open: send one probe request to test recovery.
- **Retry Budgets (Service Mesh Pattern):** Limit total retries to 20% of original request volume. If the system is already retrying too much, stop — prevent retry storms that amplify failures across the mesh.
- **Timeout Propagation (Service Mesh Pattern):** Read incoming deadline headers (e.g., `X-Request-Timeout: 2000ms`). If remaining time is less than the upstream's expected latency, fail fast locally instead of wasting a request that will timeout anyway.
- **Mutual TLS (Service Mesh Pattern):** In sidecar mode, the proxy terminates inbound TLS and initiates outbound TLS to backends using short-lived certificates. Services communicate in plaintext to localhost; the proxy handles all crypto.
- **Per-Request Observability:** Emit Prometheus histograms for every proxied request (latency, status code, upstream name) — without the application emitting anything. The proxy is the observability source.
- **Active Health Checking & Connection Draining:** Background goroutines ping each upstream on a configurable interval. Unhealthy backends are placed into a Draining State, allowing active, in-flight client socket connections to finish processing normally while instantly shielding them from new incoming request vectors.

### 🎯 Learning Objectives

- [ ] Explain the difference between north-south (gateway) and east-west (sidecar) traffic management — implement both in one codebase
- [ ] Implement transparent reverse proxying: forward requests without the client or backend knowing a proxy sits between them
- [ ] Build connection pooling with keep-alive management to reduce TCP handshake overhead
- [ ] Implement a circuit breaker state machine (closed → open → half-open) with configurable thresholds
- [ ] Implement retry budgets that prevent retry storms across the system
- [ ] Add timeout propagation: forward remaining deadline to downstream services via headers
- [ ] Implement mutual TLS between proxy and backends using Go's `crypto/tls` + `x509` packages
- [ ] Emit per-upstream metrics (latency p50/p99, error rate, circuit state) via Prometheus endpoint
- [ ] Implement active + passive health checking with automatic backend pool updates
- [ ] Benchmark: measure added latency of the proxy layer (should be <1ms for localhost sidecar mode)
---

## 🔌 Project 6: A Custom Redis Clone & Protocol Parser

- **The Core Concept:** High-concurrency network polling and memory-first architecture. You will write an in-memory database that speaks the actual, real-world **RESP (Redis Serialization Protocol)**.
- **Architectural Patterns You'll Master:**
    - **Zero-Copy Network Parsing:** Writing an state-machine parser that can decode raw TCP byte streams without allocating memory for every incoming command string.
    - **The Event Loop vs. Thread-per-Connection:** Learning why Redis uses a single-threaded multiplexed event loop (`epoll`) instead of a multi-threaded worker pool, and how that eliminates race conditions completely.
    - **Cache Eviction Mechanics:** Designing and benchmarking deterministic data cleaning algorithms like LRU (Least Recently Used) under massive concurrent connection limits.

---

## **📬 Project 7: Custom Distributed Message Broker (AWS SQS Clone)**

**The Core Concept:** Master asynchronous message passing, horizontal scaling boundaries, and fault-tolerant storage mechanics. Instead of relying on a localized, single-thread queue, you will build a standalone message broker designed to safely orchestrate multi-client queue access. It will allow independent consumer microservices to concurrently poll, process, acknowledge, or quarantine message frames over network sockets without data corruption, message loss, or duplication.

## **🏛️ The Choice of Track:**

- **The Standalone Core Broker Track:** Focuses on engineering the central server pipeline using a custom raw TCP state coordinator or your Project 6 Redis engine layout to handle concurrent memory allocations and state transitions.
- **The Client SDK Framework Track:** Focuses on writing both the core broker engine and a highly reusable Go client library package that developers can import to automatically manage background long-polling loops, backoff retries, and multi-threaded worker allocations.

## **🧠 Architectural Patterns You'll Master:**

- **Message Visibility Timeouts (In-Flight Ledger):** Architecting a non-blocking, two-phase state engine. When a consumer requests a message, the broker marks it invisible to other clients and initiates a localized timer. If the client fails to return a success signal before the window expires, the engine automatically rolls the message state back to "Ready" for other workers to claim.
- **Horizontal Competing Consumers Pattern:** Engineering thread-safe, atomic polling chokepoints. This guarantees that if multiple independent server instances hammer your broker simultaneously, messages are distributed evenly without a single record ever being picked up twice or triggering a data race condition.
- **Dead-Letter Queue (DLQ) Quarantine Routing:** Designing automatic retry-exhaustion traps. You will track a message-specific `ReceiveCount` metadata counter. Once a poisoned message causes worker failures that breach a strict threshold limit (e.g., 3 failed processing attempts), your engine dynamically strips it from the main stream and moves its pointer to an isolated DLQ bucket.
- **Network-Efficient Long Polling:** Eliminating CPU-burning empty loops by engineering blocking network polls. When the queue is dry, instead of immediately returning an empty response, the server utilizes Go's native channel selectors to hold the client's socket connection open for up to 20 seconds, pushing new payloads down the wire the exact millisecond a producer publishes them.
- **At-Least-Once Delivery Guarantees:** Structuring explicit verification tokens (`ReceiptHandles`). Messages are never deleted upon initial read; they are only permanently purged from the storage layer when the consumer successfully issues a secondary cryptographic acknowledgment command back to the broker.

---

## 💾 Project 8: Embedded Storage Engine (LSM-Tree or Time-Series TSDB)

**The Core Concept:** Deep-dive time-series database internals and physical disk block architecture. Instead of storing arbitrary data, you will build a highly specialized, crash-resilient time-series storage engine from scratch that mirrors how Prometheus handles millions of metrics per second.

### 🏛️ The Choice of Track:

- **The LSM-Tree Track (e.g., Mini-RocksDB):** Optimizes for high-throughput, arbitrary Key-Value string writes using a sorted memory-to-disk architecture.
- **The TSDB Track (e.g., Mini-Prometheus):** Optimizes for sequential metric appends using Gorilla compression chunks and time-windowed block segmentation.

### 🧠 Architectural Patterns You'll Master:

- **Write-Ahead Logging (WAL):** Ensuring absolute data durability by sequentially appending raw, incoming time-series samples directly to an on-disk binary journal file before modifying hot memory tiers.
- **In-Memory Head Block Roll-Overs:** Orchestrating an active, concurrent memory layer that buffers live metrics and seamlessly flushes them down into immutable, time-segmented disk directories whenever a strict timeline window expires.
- **Bitwise Gorilla Data Compression:** Implementing advanced bitwise operations (like Delta-of-Deltas integer timestamp tracking and XOR floating-point metric value compression) to drastically reduce the application's disk footprint.
- **Multi-Dimensional Inverted Indexing:** Designing internal search maps that resolve string label matchers (e.g., `status="500"`) straight to a compressed array of internal metric identification numbers for ultra-fast query execution.
- **Time-Windowed Block Compaction:** Building concurrent background workers that continuously merge adjacent, older time-block directories into larger historical segments to maximize disk space without stalling live read or write paths.
- **Kernel Page Cache Control:** Mastering the Linux file-writing lifecycle by executing explicit kernel flushes (`syscall.Fsync`) to force the OS cache down onto physical hard disk blocks for strict data consistency.

---

## 📅 Project 9: Mini Scheduler & Orchestrator

**The Core Focus:** Distributed resource placement, declarative reconciliation loops, cluster state management, and scheduling algorithms. You will build a simplified version of what `kube-scheduler` and `controller-manager` do — deciding WHERE to place workloads across a fleet of worker nodes and maintaining systemic desired states.

### 🏛️ The 3-Component Architecture

- **The Scheduler & Controller (Control Plane):** A central server that accepts task declarations, maintains an active cluster topology map, and runs multi-phase scheduling algorithms to assign tasks to nodes.
- **The Node Agent:** A lightweight process running on each worker node that reports local capacity slots, executes assigned tasks (as system subprocesses), and broadcasts periodic telemetry.
- **The CLI Client:** A command-line tool to submit declarative task manifests (`run 3 replicas of web-server`), inspect live cluster states, and gracefully drain nodes.

### 🏛️ The Choice of Track:

- **The Multi-Process Network Track (Recommended):** The Scheduler and node agents operate as completely separate binaries communicating over secure gRPC or HTTP networks. Tasks are executed as real host subprocesses. Nodes can be forcefully killed to test real-world cluster state failure recovery.

### 🧠 Architectural Patterns You'll Master:

- **Heartbeat-Based Node Registration:** Node agents register themselves on startup and emit periodic heartbeats. The scheduler tracks last-seen timestamps and dynamically transitions nodes across states (`Ready`, `NotReady`, or `Dead`) based on strict timeout thresholds.
- **Resource Accounting & Capacity Tracking:** Each node monitors allocated vs. available CPU/memory slots. The scheduler maintains an active cluster capacity ledger and gracefully rejects task submissions that exceed overall infrastructure limits.
- **Two-Phase Scheduling (Filter & Score):** Optimizing placement latency by replicating production scheduling design. You will implement a fast **Filter Phase (Predicates)** to instantly eliminate dead, full, or constraint-violating nodes, followed by a heavy **Score Phase (Priorities)** to rank the remaining candidate nodes using your chosen algorithms (Bin-Packing or Spread).
- **Optimistic State Reservations (Anti-Racing):** Designing safe concurrency guardrails. When multiple parallel scheduler threads evaluate the graph simultaneously, your engine will execute atomic local state reservations to claim a node's slots *before* the network RPC call is sent to the Node Agent, preventing over-allocation race conditions under sudden placement surges.
- **Pending Queues with Exponential Backoff:** Managing unschedulable workloads. If a high-priority task arrives but the cluster is entirely saturated, your engine will route the task to a specialized waiting queue that backs off exponentially rather than continuously spinning and exhausting host CPU cycles.
- **The Reconciliation Loop (Desired vs. Actual State):** Every N seconds, a background controller evaluates what the user declared ("3 replicas") against what is actually running across the nodes. If a node drops offline and takes a replica with it, the scheduler automatically identifies the delta and triggers a placement execution loop elsewhere.
- **Preemption & Priority Eviction:** When a critical task arrives into a fully saturated cluster, the scheduler identifies low-priority tasks to evict. It issues termination signals to the victim, claims the freed slot for the high-priority task, and re-enqueues the evicted task.
- **Graceful Node Drain:** Implementing zero-downtime maintenance operations. Marking a node for eviction safely transitions its state to unschedulable, smoothly migrates all active subprocesses to alternative nodes across the network, and shuts down the target without dropping live work.

### 🎯 Learning Objectives

- [ ] Implement node registration and heartbeat-based failure detection with configurable timeout windows
- [ ] Build a resource accounting model: track allocated vs. available CPU/memory per node
- [ ] Implement a two-phase scheduler: Filter nodes first via predicates, then Score them via placement strategies
- [ ] Implement a bin-packing scheduling algorithm to maximize individual node utilization
- [ ] Implement a spread scheduling algorithm to maximize cluster fault tolerance and availability
- [ ] Handle scheduling edge cases using Optimistic State Reservations to eliminate concurrent over-allocation races
- [ ] Implement a pending queue with exponential backoff for workloads that cannot immediately find space
- [ ] Build a continuous reconciliation loop: converge actual cluster states toward user-declared desired states
- [ ] Handle node failure scenarios: detect missed heartbeats, isolate dead nodes, and reschedule orphaned tasks automatically
- [ ] Implement task preemption and priority-based eviction mechanics
- [ ] Implement graceful node draining loops to safely evacuate workloads before a node shutdown
- [ ] Expose a purely declarative API: users submit the desired state, and the scheduler converges it—zero imperative manipulation
- [ ] Benchmark: measure scheduling latency (time from submission to node assignment) for 100, 1,000, and 10,000 concurrent pending tasks
---

## 🏎️ Project 10: A Distributed, Replicated Key-Value Store

- **The Core Concept:** Move from single-node systems to distributed networks. You will build a basic Key-Value store (like a mini-Consul or Etcd) that runs across 3 separate terminal nodes.
- **Architectural Patterns You'll Master:**
    - **Network Consensus:** Implementing a simplified version of the Raft consensus algorithm or active-passive replication to ensure all 3 nodes agree on data state.
    - **Network Partition Isolation (Split-Brain):** Designing how your cluster behaves when Node 3 suddenly loses network connection to Node 1 and 2.
    - **RPC Communication:** Moving away from standard JSON HTTP clients and implementing high-efficiency gRPC or raw TCP communication layers.
    - `Distributed Tracing & Context Propagation:` Implementing OpenTelemetry context carriers to track request execution lifecycles across multiple independent nodes over the network.
