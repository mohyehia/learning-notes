## System Design — Reading List & References

### Back-of-the-Envelope Estimation
- [ ] [Latency Numbers Every Programmer Should Know](https://gist.github.com/jboner/2841832)
- [ ] [System Design Interview Questions: The Ultimate Crash Course](https://levelup.gitconnected.com/system-design-interview-questions-the-ultimate-crash-course-d1f17da93faa)
- [ ] [The Complete System Design Interview Guide 2026](https://atul4u.medium.com/the-complete-system-design-interview-guide-2026-1784f8beb092)
- [ ] [43 System Design Concepts Every Engineer Should Know](https://medium.com/@YodgorbekKomilo/43-system-design-concepts-every-engineer-should-know-5a08ef8441b8)
- [ ] **Build project:** Create a capacity-planning worksheet or small Spring Boot/CLI calculator for URL shortener, chat, and video-streaming sizing (QPS, storage, bandwidth, server count)

### Networking
- [ ] [System Design Concepts: Networking Essentials](https://levelup.gitconnected.com/system-design-concepts-networking-essentials-09798e0ff7b4)
- [ ] [Top 20 Network Protocols You Must Know in System Design](https://interviewnoodle.com/top-20-network-protocols-you-must-know-in-system-design-81eaab4b0c36)
- [ ] [Comprehensive Overview of HTTP Caching Mechanisms](https://medium.com/@mbanaee61/comprehensive-overview-of-http-caching-mechanisms-3381c7041682)
- [ ] [Ace Your System Design Interview: Essential Application Protocols Explained](https://levelup.gitconnected.com/ace-your-system-design-interview-essential-application-protocols-explained-996e425128d3)
- [ ] [System design of DNS](https://medium.com/@lazygeek78/system-design-of-dns-6a7532bdf0a0)
- [ ] [A Beginner's Guide to CDN: What it is and How it Works](https://medium.com/@techsuneel99/a-beginners-guide-to-cdn-what-it-is-and-how-it-works-b6e1c1f5dda4)
- [ ] [Data Centers in System Design](https://levelup.gitconnected.com/data-centers-in-system-design-ad5c17ace22d)
- [ ] **Build project:** Build a Spring Boot app exposing REST + gRPC endpoints, add HTTP caching headers, and compare latency/throughput using k6 or Gatling

### Load Balancing
- [ ] [Load Balancing Algorithms](https://www.geeksforgeeks.org/load-balancing-algorithms/)
- [ ] [Essential Load Balancing Algorithms](https://blog.stackademic.com/essential-load-balancing-algorithms-to-master-for-system-design-success-b2d3613437b2)
- [ ] [The Essential Guide to Load Balancing Strategies and Techniques](https://levelup.gitconnected.com/the-essential-guide-to-load-balancing-strategies-and-techniques-cb17f0d219ee)
- [ ] [Load Balancer vs. Reverse Proxy vs. API Gateway](https://www.designgurus.io/blog/load-balancer-reverse-proxy-api-gateway)
- [ ] [Introduction to Load Balancing](https://www.designgurus.io/course-play/grokking-system-design-fundamentals/doc/introduction-to-load-balancing)
- [ ] [How NGINX Handles MILLIONS of Requests With Just 1 Process](https://www.youtube.com/watch?v=I6dpN0geIb4)
- [ ] [Scale Docker containers using Nginx](https://www.youtube.com/watch?v=9aOpRhm33oM)
- [ ] [Building a Simple Load Balancer with Spring Boot](https://medium.com/@sandeepkv93/building-a-simple-load-balancer-with-spring-boot-a-step-by-step-guide-a8b0dfcfb103)
- [ ] [Java Concurrency with Load Balancer Simulation](https://turkogluc.com/java-concurrency-with-load-balancer-simulation/)
- [ ] [System Design Of Loadbalancer](https://medium.com/@lazygeek78/system-design-of-loadbalancer-9b67283703f3)
- [ ] [Sticky Sessions: An In-Depth Overview](https://medium.com/@aditimishra_541/sticky-sessions-an-in-depth-overview-4ec19bd7e22a)
- [ ] **Build project:** Run 3 Spring Boot instances behind Nginx, implement health checks + sticky sessions, and also code a small Java round-robin/least-connections load balancer simulator

### API Gateway
- [ ] [The API Gateway Pattern: Design, Tradeoffs, and the Failure Modes Nobody Warns You About](https://joudwawad.medium.com/api-gateway-pattern-in-microservices-when-and-how-62a0bf0ea93b)
- [ ] [Understanding API Gateways vs Load Balancer — A Perspective with mobile and Web Apps](https://medium.com/google-cloud/understanding-api-gateways-vs-load-balancer-a-perspective-with-mobile-and-web-apps-4623cc1289c7)
- [ ] [Mastering API Gateway: 30+ Interview Q&A](https://medium.com/@vadadoriyavivek5/mastering-api-gateway-30-interview-q-a-b4932ba1491c)
- [ ] [Architecture Patterns: Backend For Frontend (BFF) Pattern](https://lab.scub.net/backend-for-frontend-bff-pattern-57de57683264)
- [ ] **Build project:** Create a Spring Cloud Gateway/BFF that routes to user, order, and catalog services with JWT auth, request aggregation, and rate-limiting filters

### Rate Limiting
- [ ] [API Rate Limiting from Scratch: Token Bucket, Sliding Window, and Distributed Strategies](https://blog.stackademic.com/api-rate-limiting-from-scratch-token-bucket-sliding-window-and-distributed-strategies-4c3d58924513)
- [ ] [Designing a Rate Limiter: A Comprehensive Guide](https://medium.com/@anil.goyal0057/designing-a-rate-limiter-a-comprehensive-guide-cebfa82089e1)
- [ ] [Rate Limiter using Token Bucket Algorithm](https://medium.com/@anil.goyal0057/rate-limiter-using-token-bucket-algorithm-9911f27ba182)
- [ ] [Rate Limiter Design: Distributed vs. Single Instance](https://medium.com/@goyalarchana17/rate-limiter-design-why-what-how-and-the-case-for-distributed-vs-single-instance-3b4f09418b7d)
- [ ] [Mastering Traffic Control: Designing a High-Scale Rate Limiter](https://medium.com/@RobuRishabh/system-design-chapter-2-mastering-traffic-control-designing-a-high-scale-rate-limiter-9cf72e200e1a)
- [ ] [How Spring Boot Implements Rate Limiting for APIs](https://medium.com/@AlexanderObregon/how-spring-boot-implements-rate-limiting-for-apis-918103d6acff)
- [ ] [API Throttling and Rate Limiting](https://medium.com/@priyasrivastava18official/api-throttling-and-rate-limiting-e3cf36d9bc56)
- [ ] [Rate limiter system design](https://dilipkumar.medium.com/rate-limiter-system-design-c67f74e78771)
- [ ] **Build project:** Implement token-bucket and sliding-window rate limiters in Java, then back them with Redis and plug them into Spring Cloud Gateway

---

### WebSockets
- [ ] [Websockets: Scaling Over a Distributed System](https://medium.com/@taycode/websockets-scaling-over-a-distributed-system-ea567d8372e5)
- [ ] [System design: Scaling WebSocket Applications](https://medium.com/@dinh.nt/system-design-scaling-websocket-applications-c7827ec82afb)
- [ ] [HTTP Long Polling vs WebSockets](https://medium.com/@dmosyan/http-long-polling-vs-websockets-dadab8f7f26f)
- [ ] **Build project:** Build a real-time notification or chat service using Spring WebSocket/STOMP and Redis Pub/Sub so it works across multiple instances

---

### Database Indexing
- [ ] [An in-depth look at Database Indexing](https://www.freecodecamp.org/news/database-indexing-at-a-glance-bb50809d48bd/)
- [ ] [How to Implement and Use Database Indexes](https://www.progress.com/tutorials/odbc/using-indexes)
- [ ] [DB Indexing in System Design Interviews - B-tree, Geospatial, Inverted Index](https://www.youtube.com/watch?v=BHCSL_ZifI0)
- [ ] **Build project:** Load millions of rows into PostgreSQL and benchmark queries with B-tree, composite, partial, and GIN indexes using `EXPLAIN ANALYZE`

### CAP Theorem
- [ ] [CAP Theorem Explained (with Diagrams)](https://arslan-ahmad.medium.com/cap-theorem-explained-with-diagrams-57a591de4e91)
- [ ] [CAP Theorem Explained: Consistency, Availability, and Partition Tolerance in Distributed Systems](https://interviewnoodle.com/cap-theorem-explained-consistency-availability-and-partition-tolerance-in-distributed-systems-a630b3034834)

### ACID Principles
- [ ] [ACID Properties Explained: A Complete Guide with PostgreSQL Implementation](https://medium.com/@shivambhadani_/acid-properties-explained-a-complete-guide-with-postgresql-implementation-071afa6aaf8a)
- [ ] **Build project:** Build a bank-transfer service in Spring Boot that demonstrates rollback, optimistic locking, pessimistic locking, and transaction isolation anomalies

### Database Replication
- [ ] [How is Data Replicated in Distributed Systems?](https://medium.com/@_sidharth_m_/how-is-data-replicated-in-distributed-systems-0fe7dd8af904)
- [ ] [Database replication: Definition, types and setup](https://www.fivetran.com/learn/database-replication)
- [ ] [Database Replication: Single Leader, Multi-Leader, and Leaderless Explained](https://medium.com/stackademic/database-replication-single-leader-multi-leader-and-leaderless-explained-3192a9bbe4ae)
- [ ] [Best Practices for Postgres Database Replication](https://medium.com/timescale/best-practices-for-postgres-database-replication-b5ed69caf96d)
- [ ] [Database Replication & Sharding Explained](https://levelup.gitconnected.com/database-replication-sharding-explained-3bc0ae3e0780)
- [ ] **Build project:** Set up PostgreSQL primary/replica with Docker Compose and build a read/write-splitting Spring Boot app that exposes replication lag and stale-read scenarios

### Database Partitioning & Sharding
- [ ] [Guide to PostgreSQL Table Partitioning](https://rasiksuhail.medium.com/guide-to-postgresql-table-partitioning-c0814b0fbd9b)
- [ ] [When to Consider Postgres Partitioning](https://www.timescale.com/learn/when-to-consider-postgres-partitioning)
- [ ] [What is Database Sharding?](https://aws.amazon.com/what-is/database-sharding/)
- [ ] [Understanding Database Sharding](https://www.digitalocean.com/community/tutorials/understanding-database-sharding)
- [ ] [Sharding](https://hazelcast.com/glossary/sharding/)
- [ ] [Scaling Databases with Replication, Partitioning, and Sharding](https://medium.com/@vinodbokare0588/scaling-databases-with-replication-partitioning-and-sharding-4d0a006adfe3)
- [ ] [Strategies for Scaling Databases: A Comprehensive Guide](https://medium.com/@anil.goyal0057/strategies-for-scaling-databases-a-comprehensive-guide-b69cda7df1d3)
- [ ] [Data Partitioning and Sharding in Spring Microservices](https://medium.com/@AlexanderObregon/data-partitioning-and-sharding-in-spring-microservices-7e13dec7b92a)
- [ ] **Build project:** Build a shard-router service for tenant or order data, partition PostgreSQL tables by date/tenant, and measure cross-shard query costs

### Caching
- [ ] [Mastering the Art of Caching for System Design Interviews](https://www.designgurus.io/blog/caching-system-design-interview)
- [ ] [In-Depth Guide to Cache Invalidation Strategies](https://www.designgurus.io/blog/cache-invalidation-strategies)
- [ ] [Caching Strategies and Cache Eviction Policies](https://medium.com/@vijaynathv/caching-strategies-and-cache-eviction-policies-768351e25f1f)
- [ ] [Understanding Cache Eviction Policies](https://blog.stackademic.com/understanding-cache-eviction-policies-d9b8f06fb039)
- [ ] [Introduction to LRU and LFU Caching: Concepts, Implementations, and Practical Use Cases](https://medium.com/@alxkm/introduction-to-lru-and-lfu-caching-concepts-implementations-and-practical-use-cases-ab90f2e168bd)
- [ ] [Understanding Distributed Cache: Benefits, Challenges, and Use Cases](https://leonidasgorgo.medium.com/understanding-distributed-cache-benefits-challenges-and-use-cases-a5a753f18231)
- [ ] [Starting from Scratch: System Design Lesson 4 (Cache)](https://medium.com/@priyasrivastava18official/starting-from-scratch-system-design-lesson-4-cache-5703c8a60499)
- [ ] **Build project:** Implement cache-aside with Spring Boot + Redis, then extend it with multi-level caching (Caffeine + Redis) and cache-stampede protection

---

### Hashing
- [ ] [Hashing in Data Structure](https://www.scaler.com/topics/data-structures/hashing-in-data-structure/)
- [ ] [Separate Chaining](https://www.scaler.com/topics/data-structures/separate-chaining/)
- [ ] [Open Addressing | Closed Hashing](https://www.scaler.com/topics/data-structures/open-addressing/)
- [ ] [Double Hashing](https://www.scaler.com/topics/data-structures/double-hashing/)
- [ ] [Load Factor and Rehashing](https://www.scaler.com/topics/data-structures/load-factor-and-rehashing/)
- [ ] **Build project:** Implement your own `HashMap` in Java with chaining and open addressing, then benchmark it against `HashMap` and `ConcurrentHashMap`

### Consistent Hashing
- [ ] [Consistent hashing algorithm](https://highscalability.com/consistent-hashing-algorithm/)
- [ ] [Consistent Hashing - explanation and implementation](https://arpitbhayani.me/blogs/consistent-hashing/)
- [ ] [What Is Consistent Hashing?](https://www.baeldung.com/cs/consistent-hashing)
- [ ] [Consistent Hashing: A hash ring to rule them all](https://medium.com/@sylvain.tiset/consistent-hashing-a-hash-ring-to-rule-them-all-ab1b3154e795)
- [ ] [Consistent Hashing Simplified: Visual Guide and Basic Implementation](https://blog.stackademic.com/consistent-hashing-simplified-visual-guide-and-basic-implementation-d488f62f93b5)
- [ ] [Understanding Consistent Hashing: A Robust Approach to Data Distribution](https://medium.com/@anil.goyal0057/understanding-consistent-hashing-a-robust-approach-to-data-distribution-in-distributed-systems-0e4a0e770897)
- [ ] [Consistent Hashing: An Overview and Implementation in Java](https://ishan-aggarwal.medium.com/consistent-hashing-an-overview-and-implementation-in-java-6b47c718558a)
- [ ] **Build project:** Build a simple distributed key-value store in Java that places keys on a hash ring with virtual nodes and measures data movement on rebalance

### Distributed ID Generation
- [ ] [UUID Alternatives for Cloud Apps](https://medium.com/@csjcode/uuid-alternatives-for-cloud-apps-9410f194b4d1)
- [ ] **Build project:** Implement a Snowflake-style ID generator service in Spring Boot and compare UUID vs ULID vs Snowflake performance in PostgreSQL indexes

### Bloom Filters
- [ ] [How Big Tech Checks Your Username in Milliseconds](https://www.youtube.com/watch?v=_l5Q5kKHtR8)
- [ ] [Bloom Filters | Hashtable | System Design](https://www.youtube.com/watch?v=GT0En1dGntY)
- [ ] **Build project:** Build a username-availability or cache-miss filter service using a Bloom filter in front of PostgreSQL/Redis and measure false positives

---

### Message Queues & Event-Driven Architecture
- [ ] [Message Queues in System Design](https://levelup.gitconnected.com/message-queues-in-system-design-0440a1221023)
- [ ] [System Design: Message Deduplication System](https://medium.com/@aditimishra_541/system-design-message-deduplication-system-afb4679c3c00)
- [ ] [Common Problems in Message Queues [With Solutions]](https://medium.com/@vinciabhinav7/common-problems-in-message-queues-with-solutions-f0703c0bd5af)
- [ ] [When to Use Kafka or RabbitMQ in System Design](https://rushi1807.medium.com/when-to-use-kafka-or-rabbitmq-in-system-design-f69723331b31)
- [ ] [System Design: Push vs Pull architecture paradigms](https://medium.com/@guptaabhinav206/system-design-push-vs-pull-architecture-paradigms-d9803b87419a)
- [ ] **Build project:** Build an order-processing workflow with Kafka or RabbitMQ including producer/consumer, DLQ, retry policy, and an outbox-based publisher


---

### Leader Election & Consensus
- [ ] [Leader Election in Distributed Systems](https://aws.amazon.com/builders-library/leader-election-in-distributed-systems/)
- [ ] [Understanding Raft Algorithm: Consensus and Leader Election Explained](https://medium.com/@jitenderkmr/understanding-raft-algorithm-consensus-and-leader-election-explained-faadf28fd047)
- [ ] **Build project:** Build a singleton scheduler that runs on only one node using Kubernetes Lease API or a simple Java Raft leader-election simulation

---

### Elasticsearch & Search
- [ ] [Beginner's Crash Course to Elastic Stack](https://www.youtube.com/playlist?list=PL_mJOmq4zsHZYAyK606y7wjQtC0aoE6Es)
- [ ] [ElasticSearch: Understanding Full-Text Search](https://shambhavishandilya.medium.com/elasticsearch-understanding-full-text-search-eb08d272f97e)
- [ ] [Mastering Elasticsearch](https://luvstechtalk.medium.com/mastering-elasticsearch-cab8407262a2)
- [ ] [System Design Series: ElasticSearch, Architecting for search](https://medium.com/better-programming/system-design-series-elasticsearch-architecting-for-search-5d5e61360463)
- [ ] **Build project:** Build a product-search service with Elasticsearch autocomplete, custom analyzers, ranking tweaks, and PostgreSQL-to-Elastic sync

---

### OAuth2
- [ ] [OAuth 2.0](https://auth0.com/intro-to-iam/what-is-oauth-2)
- [ ] [An Introduction to OAuth2](https://www.digitalocean.com/community/tutorials/an-introduction-to-oauth-2)
- [ ] [Testing Spring OAuth2 Access-Control](https://www.baeldung.com/spring-oauth-testing-access-control)
- [ ] **Build project:** Build an OAuth2 authorization server + resource server setup in Spring Security with JWT, refresh tokens, and client-credentials flow for service-to-service auth

---

### Object Storage
- [ ] [Object Storage (BLOBs) Explained for System Design](https://levelup.gitconnected.com/object-storage-blobs-in-system-design-4d6ddf0241d1)
- [ ] **Build project:** Build a file-upload service with S3 pre-signed URLs, multipart uploads, metadata persistence, and CloudFront-backed downloads

### Multi-Tenancy
- [ ] [Single-Tenant vs. Multi-Tenant Applications: Design Principles & Best Practices](https://medium.com/@aruns89/single-tenant-vs-multi-tenant-applications-design-principles-best-practices-ede619c295ac)
- [ ] **Build project:** Build a schema-per-tenant SaaS service in Spring Boot with tenant-aware routing, tenant-scoped caching, and onboarding automation

---

### General System Design Resources
- [ ] [The System Design Interview Reading List I Send to Every Engineer Who Emails Me](https://interviewnoodle.com/the-system-design-interview-reading-list-i-send-to-every-engineer-who-emails-me-2772aeaf6e16)
- [ ] [10 Beginner System Design Interview Questions to Master First](https://interviewnoodle.com/10-beginner-system-design-interview-questions-to-master-first-8f405b463ba6)
- [ ] [Ultimate System Design Interview Guide for 2026](https://medium.com/@fahimulhaq/ultimate-system-design-interview-guide-for-2025-c5dfa0ca6557)
- [ ] [System Design Articles](https://medium.com/silenttech/system-design-articles-3c37564ff926)
- [ ] [Reliability vs Availability: What’s the Difference in System Design?](https://medium.com/stackademic/reliability-vs-availability-whats-the-difference-in-system-design-8994dd15dab5)
- [ ] [Designing an Infinitely Scalable Key-Value Store on a Relational Database](https://daminibansal.medium.com/designing-an-infinitely-scalable-key-value-store-on-a-relational-database-7353c82ce91e)
- [ ] [Time Series Databases and InfluxDB](https://dilipkumar.medium.com/time-series-databases-and-influxdb-2df5f5b06175)
- [ ] [Gossip Protocol Explained: How Distributed Systems Spread Information](https://interviewnoodle.com/gossip-protocol-explained-how-distributed-systems-spread-information-2e58b93be28c)
- [ ] [AMAZON: 1 Million Users Clicked Checkout At Once. The Real Problem Wasn’t Scaling.](https://levelup.gitconnected.com/amazon-1-million-users-clicked-checkout-at-once-the-real-problem-wasnt-scaling-f7956a102f9c)
- [ ] **Build plan:** Pick one end-to-end system design problem per month and write a 1-page design + PoC

#### Beginner builds
- [ ] **Build project:** Design and build a URL Shortener with base62 encoding, caching, analytics, and rate limiting
- [ ] **Build project:** Build a document or media sharing platform with upload, metadata indexing, search, access control, and audit logs

#### Intermediate builds
- [ ] **Build project:** Build a notification platform supporting email, SMS, and in-app delivery with retry, DLQ, and user preferences
- [ ] **Build project:** Build a metrics ingestion pipeline that accepts high-volume events, batches them, stores aggregates, and exposes dashboards
- [ ] **Build project:** Build a distributed job-processing platform with scheduling, retries, idempotency, and per-tenant throttling

#### Advanced / Principal-level builds
- [ ] **Build project:** Build a social feed or activity timeline service and compare fan-out-on-write vs fan-out-on-read approaches
- [ ] **Build project:** Build a multi-tenant e-commerce order platform with checkout, inventory reservation, payment workflow, retries, DLQ, and observability
- [ ] **Build project:** Build a global notification or messaging platform with multi-region failover, idempotency, backpressure handling, and documented trade-offs

---

### Principal-Level Distributed Systems Understanding

> Use this section as a synthesis checklist after you finish the core topics above. These are the areas that usually separate strong senior engineers from principal-level system thinkers.

- [ ] CAP Theorem and PACELC
- [ ] Consistency models: strong, eventual, causal, monotonic, read-your-writes
- [ ] Consensus, quorums, and leader election
- [ ] Distributed transactions: 2PC, 3PC, Saga, and compensation
- [ ] Idempotency, retries, deduplication, and the “exactly-once” myth
- [ ] Failure detection, split-brain, and network partitions
- [ ] Logical time and ordering: Lamport clocks, vector clocks, hybrid logical clocks
- [ ] Conflict resolution strategies and CRDTs
- [ ] Backpressure, flow control, and load shedding
- [ ] Multi-region architecture, geo-replication, and disaster recovery
- [ ] Data distribution strategy: sharding keys, hot partitions, rebalancing
- [ ] Reliability engineering: SLIs, SLOs, SLAs, error budgets, burn-rate alerts
- [ ] Graceful degradation, fault isolation, and chaos engineering
- [ ] Capacity planning, cost modeling, and trade-off analysis
- [ ] **Build project:** Design and implement a production-style microservices platform that combines Kafka, Redis, PostgreSQL, Elasticsearch, OAuth2, observability, failures, and a documented set of trade-offs for scale, cost, and reliability

