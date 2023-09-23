### To configure replicaset for the mongodb statefulSet
- exec to the mongo container and use this command : `mongosh` 
- execute the below command to enable the replica:
```shell
rs.initiate( {
  _id : "rs0",
  members: [
    { _id: 0, host: "mongo-sts-0.mongo-svc.default.svc.cluster.local:27017" },
    { _id: 1, host: "mongo-sts-1.mongo-svc.default.svc.cluster.local:27017" },
    { _id: 2, host: "mongo-sts-2.mongo-svc.default.svc.cluster.local:27017" }
  ]
})

```

- To display the replica set configuration object: `rs.conf()`
- To ensure that the replica set has a primary replica: `rs.status()`
- To configure the secondary replications to read the data from the primary replica we need to execute this command from the secondary replica : `db.getMongo().setSecondaryOk()`
- To add new replica to the rs use this command: `rs.add( { host: "mongo-sts-3.mongo-svc.default.svc.cluster.local:27017", priority: 0, votes: 1 } )`
- To remove an existing replica use this command: `rs.remove("mongo-sts-3.mongo-svc.default.svc.cluster.local:27017")`