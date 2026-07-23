## Database Replication

### Replication Strategies
- [SQL-Based Replication](#sql-based-replication)
- [Log-Based Replication](#log-based-replication)
- [Logical Replication](#logical-replication)
- [References](#references)

#### SQL-Based Replication
- With SQL-based replication middleware, a program intercepts every SQL query and sends it to one or all servers.
- Each server operates independently.
- Read-write queries must be sent to all servers, so that every server receives any changes.
- But read-only queries can be sent to just one server, allowing the read workload to be distributed among them.
- If queries are simply broadcast unmodified, functions like `random()`, `CURRENT_TIMESTAMP`, and `sequences` can have different values on different servers.
- This is because each server operates independently, and because SQL queries are broadcast rather than actual data changes.
- If this is unacceptable, either the middleware or the application must determine such values from a single source and then use those values in write queries.
- Care must also be taken that all transactions either commit or abort on all servers.
- `Pgpool-II` is an example of this type of replication.

### Log-Based Replication
- Warm and hot standby servers can be kept current by reading a stream of `write-ahead log (WAL)` records.
- If the main server fails, the standby contains almost all the data of the main server, and can be quickly made the new primary database server.
- This can be synchronous or asynchronous and can only be done for the entire database server.

### Logical Replication
- Logical replication allows a database server to send a stream of data modifications to another server.
- `PostgreSQL` logical replication constructs a stream of logical data modifications from the `WAL`.
- Logical replication allows replication of data changes on `a per-table basis`.
- In addition, a server that is publishing its own changes can also subscribe to changes from another server, allowing data to flow in multiple directions.

#### References
- [High Availability, Load Balancing, and Replication](https://www.postgresql.org/docs/current/different-replication-solutions.html)
- [Bitnami package for Pgpool-II](https://hub.docker.com/r/bitnami/pgpool)