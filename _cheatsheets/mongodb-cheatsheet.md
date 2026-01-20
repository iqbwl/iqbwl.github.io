---
layout: cheatsheet
title: MongoDB Command Cheatsheet
description: MongoDB is a source-available cross-platform document-oriented database program.
---


MongoDB is a source-available cross-platform document-oriented database program.


## Database Operations

### Database Commands
```javascript
show dbs                                 // List all databases
use database_name                        // Switch/create database
db                                       // Show current database
db.dropDatabase()                        // Delete current database
db.stats()                               // Database statistics
```

### Collection Operations
```javascript
show collections                         // List collections
db.createCollection("users")             // Create collection
db.users.drop()                          // Delete collection
db.users.renameCollection("customers")   // Rename collection
```

## CRUD Operations

### Insert Documents
```javascript
db.users.insertOne({ name: "John", age: 30 })
db.users.insertMany([
  { name: "Alice", age: 25 },
  { name: "Bob", age: 35 }
])
```

### Find Documents
```javascript
db.users.find()                          // All documents
db.users.find().pretty()                 // Formatted output
db.users.find({ age: 30 })               // Exact match
db.users.find({ age: { $gt: 25 } })      // Greater than
db.users.findOne({ name: "John" })       // First match
```

### Update Documents
```javascript
db.users.updateOne(
  { name: "John" },
  { $set: { age: 31 } }
)
db.users.updateMany(
  { age: { $lt: 25 } },
  { $set: { status: "young" } }
)
db.users.replaceOne(
  { name: "John" },
  { name: "John Doe", age: 31 }
)
```

### Delete Documents
```javascript
db.users.deleteOne({ name: "John" })
db.users.deleteMany({ age: { $lt: 25 } })
db.users.deleteMany({})                  // Delete all
```

## Query Operators

### Comparison
```javascript
$eq, $ne, $gt, $gte, $lt, $lte, $in, $nin

db.users.find({ age: { $gte: 25, $lte: 35 } })
db.users.find({ status: { $in: ["active", "pending"] } })
```

### Logical
```javascript
db.users.find({
  $and: [{ age: { $gte: 25 } }, { status: "active" }]
})
db.users.find({
  $or: [{ age: { $lt: 25 } }, { age: { $gt: 35 } }]
})
```

### Element
```javascript
db.users.find({ email: { $exists: true } })
db.users.find({ age: { $type: "number" } })
```

## Update Operators

### Field Updates
```javascript
$set, $unset, $inc, $mul, $rename, $min, $max

db.users.updateOne(
  { name: "John" },
  { $set: { age: 31 }, $inc: { score: 10 } }
)
```

### Array Updates
```javascript
$push, $pull, $addToSet, $pop

db.users.updateOne(
  { name: "John" },
  { $push: { tags: "mongodb" } }
)
db.users.updateOne(
  { name: "John" },
  { $addToSet: { tags: "database" } }
)
```

## Projection & Sorting

### Field Selection
```javascript
db.users.find({}, { name: 1, age: 1 })   // Include
db.users.find({}, { password: 0 })       // Exclude
db.users.find({}, { _id: 0, name: 1 })   // Exclude _id
```

### Sort & Limit
```javascript
db.users.find().sort({ age: -1 })        // Descending
db.users.find().limit(10)
db.users.find().skip(20).limit(10)       // Pagination
db.users.countDocuments()
```

## Indexes

### Index Operations
```javascript
db.users.createIndex({ email: 1 })       // Ascending
db.users.createIndex({ age: 1, name: 1 }) // Compound
db.users.createIndex({ email: 1 }, { unique: true })
db.users.createIndex({ description: "text" })
db.users.getIndexes()
db.users.dropIndex("email_1")
```

## Aggregation

### Pipeline Stages
```javascript
db.users.aggregate([
  { $match: { age: { $gte: 25 } } },
  { $group: { _id: "$status", count: { $sum: 1 } } },
  { $sort: { count: -1 } },
  { $limit: 10 }
])
```

### Common Examples
```javascript
// Count by field
db.users.aggregate([
  { $group: { _id: "$status", count: { $sum: 1 } } }
])

// Average
db.users.aggregate([
  { $group: { _id: null, avgAge: { $avg: "$age" } } }
])

// Unwind array
db.users.aggregate([
  { $unwind: "$tags" },
  { $group: { _id: "$tags", count: { $sum: 1 } } }
])

// Join collections
db.orders.aggregate([
  {
    $lookup: {
      from: "users",
      localField: "userId",
      foreignField: "_id",
      as: "user"
    }
  }
])
```

## Text Search

```javascript
db.articles.createIndex({ content: "text" })
db.articles.find({ $text: { $search: "mongodb" } })
db.articles.find({ $text: { $search: "\"exact phrase\"" } })
```

## Administration

### User Management
```javascript
db.createUser({
  user: "admin",
  pwd: "password",
  roles: ["readWrite", "dbAdmin"]
})
db.getUsers()
db.dropUser("username")
```

### Performance
```javascript
db.users.find({ age: 30 }).explain()
db.setProfilingLevel(2)
db.system.profile.find()
```

## Backup & Restore

```bash
mongoexport --db=mydb --collection=users --out=users.json
mongoimport --db=mydb --collection=users --file=users.json
mongodump --db=mydb --out=/backup/
mongorestore --db=mydb /backup/mydb/
```

## Best Practices

1. **Use indexes** for frequently queried fields
2. **Use projection** to limit returned fields
3. **Use aggregation pipeline** for complex queries
4. **Monitor performance** with explain()
5. **Enable authentication** in production
6. **Regular backups** are essential
7. **Avoid large documents** (max 16MB)
8. **Use appropriate data types**

## Resources

- Documentation: https://docs.mongodb.com
- MongoDB University: https://university.mongodb.com
- MongoDB Compass: https://www.mongodb.com/products/compass
