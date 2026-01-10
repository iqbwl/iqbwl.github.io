---
title: How to Cancel a stuck task in Plesk Panel
layout: archive
author: iqbwl
---
Connect ke Plesk via SSH.

```bash
plesk db dump > /root/psa_dump.sql
```

```bash
plesk db "SELECT id,type,status,finishTime FROM longtasks WHERE status <> 'done'"
```

```bash
plesk db "SELECT id,type,status,finishTime FROM longtasks WHERE status <> 'done'"

+----+---------------------+---------+---------------------+
| id | type                | status  | finishTime          |
+----+---------------------+---------+---------------------+
| 13 | ext-catalog-install | started | 0000-00-00 00:00:00 |
+----+---------------------+---------+---------------------+
```

Catat id yang didapat.

```bash
plesk db "DELETE FROM longtasks WHERE id=13"
```
```bash
plesk db "DELETE FROM longtaskparams WHERE task_id=13"
```

```bash
pkill task-async-executor
```

```bash
service sw-engine stop
service sw-engine start
```

Semoga bermanfaat.

> Sc: archive [kuro.zone](http://kuro.zone)
