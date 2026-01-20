---
layout: cheatsheet
title: Redis Command Cheatsheet
description: Redis is an open source, in-memory data structure store, used as a database, cache, and message broker.
---


Redis is an open source, in-memory data structure store, used as a database, cache, and message broker.


## Connection & Server

### Connection
```bash
redis-cli                                # Connect to local Redis
redis-cli -h host -p port                # Connect to remote
redis-cli -a password                    # With password
redis-cli --raw                          # Raw output format
AUTH password                            # Authenticate
PING                                     # Test connection
QUIT                                     # Close connection
```

### Server Commands
```bash
INFO                                     # Server information
INFO stats                               # Statistics
CONFIG GET *                             # Get all config
CONFIG SET parameter value               # Set config
DBSIZE                                   # Number of keys
FLUSHDB                                  # Clear current database
FLUSHALL                                 # Clear all databases
SAVE                                     # Save to disk (blocking)
BGSAVE                                   # Background save
SHUTDOWN                                 # Shutdown server
```

### Database Selection
```bash
SELECT 0                                 # Select database 0-15
SWAPDB 0 1                               # Swap databases
```

## Keys

### Key Operations
```bash
SET key value                            # Set key
GET key                                  # Get value
DEL key                                  # Delete key
EXISTS key                               # Check if exists
KEYS pattern                             # Find keys (use with caution)
SCAN 0 MATCH pattern COUNT 100           # Iterate keys (preferred)
RENAME oldkey newkey                     # Rename key
TYPE key                                 # Get key type
TTL key                                  # Time to live (seconds)
PTTL key                                 # Time to live (milliseconds)
EXPIRE key seconds                       # Set expiration
EXPIREAT key timestamp                   # Expire at timestamp
PERSIST key                              # Remove expiration
```

### Key Patterns
```bash
KEYS *                                   # All keys (dangerous!)
KEYS user:*                              # Keys starting with user:
KEYS *:email                             # Keys ending with :email
KEYS user:?00                            # ? matches single char
KEYS user:[123]*                         # Character class
```

## Strings

### String Operations
```bash
SET key value                            # Set value
GET key                                  # Get value
MSET key1 val1 key2 val2                 # Set multiple
MGET key1 key2                           # Get multiple
SETNX key value                          # Set if not exists
SETEX key seconds value                  # Set with expiration
GETSET key value                         # Set and return old value
APPEND key value                         # Append to value
STRLEN key                               # String length
GETRANGE key start end                   # Get substring
SETRANGE key offset value                # Set substring
```

### Numeric Operations
```bash
INCR key                                 # Increment by 1
INCRBY key amount                        # Increment by amount
INCRBYFLOAT key amount                   # Increment float
DECR key                                 # Decrement by 1
DECRBY key amount                        # Decrement by amount
```

## Lists

### List Operations
```bash
LPUSH key value                          # Push to left
RPUSH key value                          # Push to right
LPOP key                                 # Pop from left
RPOP key                                 # Pop from right
LLEN key                                 # List length
LRANGE key start stop                    # Get range
LINDEX key index                         # Get by index
LSET key index value                     # Set by index
LINSERT key BEFORE|AFTER pivot value     # Insert
LREM key count value                     # Remove elements
LTRIM key start stop                     # Trim list
```

### Blocking Operations
```bash
BLPOP key timeout                        # Blocking left pop
BRPOP key timeout                        # Blocking right pop
BRPOPLPUSH source dest timeout           # Blocking move
```

## Sets

### Set Operations
```bash
SADD key member                          # Add member
SREM key member                          # Remove member
SMEMBERS key                             # Get all members
SISMEMBER key member                     # Check membership
SCARD key                                # Set size
SPOP key                                 # Remove random member
SRANDMEMBER key count                    # Get random members
SMOVE source dest member                 # Move member
```

### Set Operations (Multiple Sets)
```bash
SUNION key1 key2                         # Union
SINTER key1 key2                         # Intersection
SDIFF key1 key2                          # Difference
SUNIONSTORE dest key1 key2               # Union and store
SINTERSTORE dest key1 key2               # Intersection and store
SDIFFSTORE dest key1 key2                # Difference and store
```

## Sorted Sets

### Sorted Set Operations
```bash
ZADD key score member                    # Add member with score
ZREM key member                          # Remove member
ZSCORE key member                        # Get score
ZINCRBY key increment member             # Increment score
ZCARD key                                # Set size
ZCOUNT key min max                       # Count in score range
ZRANK key member                         # Rank (ascending)
ZREVRANK key member                      # Rank (descending)
```

### Range Operations
```bash
ZRANGE key start stop                    # Get range (ascending)
ZREVRANGE key start stop                 # Get range (descending)
ZRANGE key start stop WITHSCORES         # With scores
ZRANGEBYSCORE key min max                # By score range
ZREVRANGEBYSCORE key max min             # By score (descending)
ZREMRANGEBYRANK key start stop           # Remove by rank
ZREMRANGEBYSCORE key min max             # Remove by score
```

## Hashes

### Hash Operations
```bash
HSET key field value                     # Set field
HGET key field                           # Get field
HMSET key f1 v1 f2 v2                    # Set multiple fields
HMGET key field1 field2                  # Get multiple fields
HGETALL key                              # Get all fields
HDEL key field                           # Delete field
HEXISTS key field                        # Check field exists
HKEYS key                                # Get all field names
HVALS key                                # Get all values
HLEN key                                 # Number of fields
HINCRBY key field increment              # Increment field
HINCRBYFLOAT key field increment         # Increment float
HSETNX key field value                   # Set if not exists
```

## Pub/Sub

### Publish/Subscribe
```bash
SUBSCRIBE channel                        # Subscribe to channel
UNSUBSCRIBE channel                      # Unsubscribe
PSUBSCRIBE pattern                       # Subscribe to pattern
PUNSUBSCRIBE pattern                     # Unsubscribe from pattern
PUBLISH channel message                  # Publish message
PUBSUB CHANNELS                          # List active channels
PUBSUB NUMSUB channel                    # Number of subscribers
```

## Transactions

### Transaction Commands
```bash
MULTI                                    # Start transaction
EXEC                                     # Execute transaction
DISCARD                                  # Cancel transaction
WATCH key                                # Watch key for changes
UNWATCH                                  # Unwatch all keys
```

### Transaction Example
```bash
MULTI
SET key1 value1
SET key2 value2
INCR counter
EXEC
```

## Lua Scripting

### Script Commands
```bash
EVAL script numkeys key [key ...] arg [arg ...]
EVALSHA sha1 numkeys key [key ...] arg [arg ...]
SCRIPT LOAD script                       # Load script
SCRIPT EXISTS sha1                       # Check if exists
SCRIPT FLUSH                             # Remove all scripts
SCRIPT KILL                              # Kill running script
```

### Script Example
```bash
EVAL "return redis.call('SET', KEYS[1], ARGV[1])" 1 mykey myvalue
```

## Persistence

### RDB (Snapshot)
```bash
SAVE                                     # Synchronous save
BGSAVE                                   # Background save
LASTSAVE                                 # Last save timestamp
CONFIG SET save "900 1 300 10"           # Auto-save config
```

### AOF (Append Only File)
```bash
BGREWRITEAOF                             # Rewrite AOF
CONFIG SET appendonly yes                # Enable AOF
CONFIG SET appendfsync everysec          # Sync policy
```

## Replication

### Replication Commands
```bash
REPLICAOF host port                      # Set master
REPLICAOF NO ONE                         # Promote to master
ROLE                                     # Show replication role
INFO replication                         # Replication info
```

## Cluster

### Cluster Commands
```bash
CLUSTER INFO                             # Cluster information
CLUSTER NODES                            # List nodes
CLUSTER SLOTS                            # Slot allocation
CLUSTER MEET ip port                     # Add node
CLUSTER FORGET node-id                   # Remove node
CLUSTER FAILOVER                         # Manual failover
```

## Memory Management

### Memory Commands
```bash
MEMORY USAGE key                         # Memory used by key
MEMORY STATS                             # Memory statistics
MEMORY DOCTOR                            # Memory analysis
MEMORY PURGE                             # Purge memory
```

### Eviction Policies
```bash
CONFIG SET maxmemory 100mb               # Set max memory
CONFIG SET maxmemory-policy allkeys-lru  # Set eviction policy
# Policies: noeviction, allkeys-lru, volatile-lru, allkeys-random,
#           volatile-random, volatile-ttl, allkeys-lfu, volatile-lfu
```

## Performance

### Benchmarking
```bash
redis-benchmark                          # Run benchmark
redis-benchmark -q                       # Quick mode
redis-benchmark -t set,get -n 100000     # Specific tests
redis-benchmark -c 50 -n 10000           # 50 clients, 10k requests
```

### Monitoring
```bash
MONITOR                                  # Monitor all commands
SLOWLOG GET 10                           # Get slow queries
SLOWLOG LEN                              # Slow log length
SLOWLOG RESET                            # Clear slow log
CLIENT LIST                              # List clients
CLIENT KILL ip:port                      # Kill client
```

## Data Types Summary

| Type | Use Case | Commands |
|------|----------|----------|
| String | Simple values, counters | SET, GET, INCR |
| List | Queues, stacks | LPUSH, RPUSH, LPOP |
| Set | Unique items, tags | SADD, SMEMBERS, SINTER |
| Sorted Set | Leaderboards, rankings | ZADD, ZRANGE, ZRANK |
| Hash | Objects, records | HSET, HGET, HGETALL |

## Common Patterns

### Caching
```bash
SET user:1000 '{"name":"John"}' EX 3600  # Cache for 1 hour
GET user:1000                            # Get cached data
```

### Counter
```bash
INCR page:views                          # Increment counter
INCRBY user:1000:points 10               # Add points
```

### Rate Limiting
```bash
SET rate:user:1000 1 EX 60 NX            # Allow once per minute
INCR rate:user:1000
GET rate:user:1000
```

### Session Store
```bash
SETEX session:abc123 3600 '{"user_id":1000}'
GET session:abc123
```

### Queue
```bash
LPUSH queue:tasks '{"task":"send_email"}'
BRPOP queue:tasks 0                      # Blocking pop
```

### Leaderboard
```bash
ZADD leaderboard 100 user1
ZADD leaderboard 200 user2
ZREVRANGE leaderboard 0 9 WITHSCORES     # Top 10
```

## Best Practices

1. **Use SCAN instead of KEYS** in production
2. **Set expiration** for temporary data
3. **Use pipelining** for multiple commands
4. **Monitor memory usage** regularly
5. **Use appropriate data structures**
6. **Enable persistence** (RDB or AOF)
7. **Use connection pooling** in applications
8. **Avoid large keys** (split if needed)
9. **Use Redis Cluster** for scalability
10. **Regular backups** are essential

## CLI Tips

```bash
redis-cli --scan --pattern 'user:*'     # Safe key scanning
redis-cli --bigkeys                      # Find large keys
redis-cli --memkeys                      # Memory usage by key
redis-cli --latency                      # Latency monitoring
redis-cli --stat                         # Real-time stats
redis-cli --csv                          # CSV output
```

## Resources

- Official Documentation: https://redis.io/documentation
- Commands Reference: https://redis.io/commands
- Redis University: https://university.redis.com
- Try Redis: https://try.redis.io
