# Designing Data Intensive Applications

## Checklist for getting maximum value:

- [ ] Read DDIA slowly and actively, not like a normal book
- [ ] Tie every chapter to one production system you know
- [ ] Write short “so what?” notes after each major topic
- [ ] Build the KV-store project gradually, not after finishing the whole book
- [ ] Discuss/apply concepts at work as soon as possible
- [ ] Avoid over-studying prerequisites or side quests

---

## My main advice

Treat DDIA as an **architecture operating system**, not as a book.

You already have real experience with:

- PostgreSQL
- Aurora/RDS
- SQS/SNS
- EKS
- microservices
- distributed tracing
- production incidents
- scaling issues

So for you, DDIA should not be “new information only”. It should become a way to **rename, structure, and sharpen things you already experienced in production**.

The best question after each chapter is:

> “Where have I seen this problem at work, and what would I design differently now?”

---

## 1. Don’t read it passively

For every chapter, use this structure:

```text
1. What is the core idea?
2. What trade-off is being explained?
3. Where have I seen this in production?
4. What mistake would a weaker engineer make here?
5. What decision would I make differently now?
```

This is much more valuable than highlighting paragraphs.

---

## 2. Use a very lightweight note format

Do not create huge summaries. You will burn out.

Use this template per chapter:

```markdown
# DDIA Chapter X — Title

## Core ideas
- ...

## Important trade-offs
- ...

## Production connections
- In our systems, this reminds me of...
- A failure mode I have seen is...

## Design implications
- Next time I design X, I should consider...

## Open questions
- ...
```

Keep each chapter note to **1 page max**.

If you cannot fit it into 1 page, you are summarizing too much.

---

## 3. Read with “trade-off detection” mode

DDIA is mostly a book about trade-offs.

When you read, keep asking:

| Topic           | Trade-off to look for                                 |
|-----------------|-------------------------------------------------------|
| Storage engines | Read latency vs write throughput                      |
| Indexes         | Query speed vs write amplification                    |
| Replication     | Availability vs consistency vs operational complexity |
| Partitioning    | Scalability vs hot partitions vs query flexibility    |
| Transactions    | Simplicity vs performance vs distributed coordination |
| Event streams   | Decoupling vs ordering/idempotency complexity         |
| Consistency     | User guarantees vs latency/availability               |

The book is not trying to tell you “use X”. It is training you to say:

> “Given this workload and failure model, X is better than Y because…”

That is principal-level thinking.

---

## 4. Connect every chapter to your existing stack

Use your real systems as mental anchors.

### When reading storage engines

Ask:

- Why does PostgreSQL use B-trees?
- Why do Cassandra/RocksDB/LevelDB use LSM-trees?
- What does this imply for write-heavy vs read-heavy workloads?
- How do indexes affect write latency in our services?

### When reading replication

Ask:

- What consistency guarantees do we actually get from Aurora read replicas?
- Where can stale reads happen?
- Do any of our services assume read-after-write consistency incorrectly?
- How would we expose replication lag as a metric?

### When reading partitioning

Ask:

- What would be a bad shard key for our domain?
- Which tenants/users/orders could become hot partitions?
- Which queries would break if we partitioned this table?

### When reading transactions

Ask:

- Where do we rely on database transactions today?
- Where do we fake distributed transactions through events?
- Where do we need idempotency keys?
- Where could retries cause duplicate effects?

### When reading stream processing

Ask:

- How do our SQS/SNS flows map to at-least-once delivery?
- Where do we need deduplication?
- Are our consumers truly idempotent?
- What is our DLQ recovery story?

---

## 5. Start the KV-store project early, but keep it tiny at first

Do not wait until you finish DDIA to build.

Start after or during Chapter 3.

But begin with the smallest possible implementation.

### Milestone 1 — Append-only log

Build:

```text
SET key value
GET key
DEL key
```

Store records in a plain append-only file.

Example internal format:

```text
SET user:1 Ahmed
SET user:2 Sara
DEL user:1
```

At startup, replay the file into an in-memory map.

This teaches:

- append-only logs
- crash recovery
- write amplification
- compaction motivation

### Milestone 2 — Compaction

Add a compaction command:

```text
compact
```

It rewrites only the latest value for each key.

This teaches:

- tombstones
- stale records
- disk space amplification

### Milestone 3 — Basic indexing

Keep an in-memory map:

```text
key -> byte offset in file
```

This teaches:

- hash indexes
- why memory limits matter
- why range queries are hard with hash indexes

### Milestone 4 — SSTable-like files

Only then move toward sorted segments.

This teaches:

- sorted string tables
- merge files
- sparse indexes
- LSM-tree intuition

Do not over-engineer it from day one.

---

## 6. Use “explain it to a staff engineer” as your test

For every big topic, test yourself like this:

> “Can I explain this clearly to another senior/staff engineer in 3 minutes without sounding vague?”

Examples:

- “Why are LSM-trees good for write-heavy workloads?”
- “Why does replication lag cause stale reads?”
- “Why is exactly-once delivery mostly a myth?”
- “Why are distributed transactions expensive?”
- “Why is partitioning not just ‘split the database’?”
- “Why can retry logic make an outage worse?”

If you can explain it simply, you understand it.

If you need jargon, you probably don’t yet.

---

## 7. Don’t chase every reference

DDIA has many references and rabbit holes.

For now:

- Do not pause to read every paper
- Do not start Kafka deeply
- Do not start consensus implementation yet
- Do not jump into Database Internals early
- Do not start another Go infra project during DDIA

Use this rule:

> If DDIA mentions a topic, understand the idea now; build/read deeper only when your current phase says so.

---

## 8. Create a “Production Questions” list

This is very useful for someone at your level.

As you read, maintain a simple list:

```markdown
# Questions DDIA makes me ask about our systems

- Do we depend on read-after-write consistency anywhere while reading from replicas?
- Are our SQS consumers idempotent under duplicate delivery?
- Which tables would suffer most from poor index write amplification?
- What is our actual consistency model between service A and service B?
- Do our dashboards show replication lag, queue lag, and consumer lag clearly?
```

This list becomes extremely valuable at work.

It can drive:

- architecture reviews
- ADRs
- tech debt discussions
- observability improvements
- incident postmortems

---

## 9. Turn each chapter into one work conversation

After each major chapter, try to bring one idea into work.

Not as “I read in a book…”, but as a practical question.

Examples:

### After storage/indexing

> “For this table, are we optimizing for write throughput or read flexibility? Are all these indexes still worth the write cost?”

### After replication

> “Do we expose replica lag anywhere? Could this API return stale data after a write?”

### After transactions

> “Is this retry safe? What prevents duplicate side effects?”

### After event streams

> “Is this consumer idempotent if SQS redelivers the same message?”

This is where the book turns into career leverage.

---

## 10. Suggested DDIA rhythm for you

Given your job level, I’d use this weekly rhythm:

| Day          | Activity                                    |
|--------------|---------------------------------------------|
| 3–4 weekdays | Read 20–30 minutes                          |
| 1 weekday    | Write notes / questions                     |
| Weekend      | 1–2 hours KV-store project or deeper review |

That is enough.

You do not need heroic 4-hour sessions.

Consistency matters more.

---

## 11. How to know you are doing DDIA correctly

You are doing it right if:

- You start seeing your production systems differently
- You use more precise language in architecture discussions
- You question hidden assumptions about consistency and failure
- You can explain trade-offs without hand-waving
- Your KV-store project makes storage internals feel concrete
- Your notes are short but insightful
- You produce at least a few work-relevant questions per chapter

You are doing it wrong if:

- You only highlight text
- You try to memorize definitions
- You write huge summaries
- You keep postponing the project
- You chase every reference paper
- You stop applying it to your real systems

---

## My concrete recommendation for this week

Since you already started Chapter 1:

### This week

1. Finish Chapter 1
2. Write a half-page note:
    - “What does reliability/scalability/maintainability mean in systems I work on?”
3. Start Chapter 2
4. Do not touch kubectl-clone unless you finish your DDIA sessions first

### After Chapter 3

Start the tiny KV-store:

```text
append-only file
SET / GET / DEL
replay on startup
manual compaction
```

That is your first real DDIA implementation milestone.

---

## Final advice

Read DDIA like a principal engineer, not like a student.

A student asks:

> “What does this chapter say?”

You should ask:

> “What production decision does this chapter make me better at?”

If you keep that question in front of you, DDIA will be one of the highest-ROI books you read.