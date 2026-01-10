---
title: Fix Error [1932] Table doesn't exist in engine
layout: archive
author: iqbwl
---
Pada saat terdapat error **[1932] Table doesn't exist in engine**, backup database yang ada pada directory `/var/lib/mysql/` terlebih dahulu dengan mv atau copy ke directory lain.

```bash
mkdir /var/lib/mysql_backup
cp -a /var/lib/mysql/* /var/lib/mysql_backup/
```

Masuk ke mysql dan create database baru.

```bash
mysql> create database newdb;
mysql> quit;
```

Install mysql-utilities.

```bash
 Debian> apt install mysql-utilities -y
 Ubuntu> apt install mysql-utilities -y
 CentOs> yum install mysql-utilities -y
 Fedora> dnf install mysql-utilities -y
```

Jalankan perintah dibawah ini untuk mendapatkan schema table.
```bash
cd /root/
touch dump.sql
mysqlfrm --user=root --server=root\@localhost --port 3300 /var/lib/mysql/olddb/table_name.frm > dump.sql
```

Fix file sql dump dengan perintah dibawah.
```bash
sed -i 's/#.*//' dump.sql
sed -i "s/olddb/newdb/" dump.sql
sed -i 's/CHARSET=utf8.*/CHARSET=utf8;/' dump.sql
```

Import file dump.sql ke database baru.
```bash
mysql newdb < dump.sql
```

Discard table dengan perintah dibawah.
```bash
mysql> use newdb;
mysql> ALTER TABLE table_name DISCARD TABLESPACE;
```

Copy file .ibd dari olddb ke newdb.
```bash
cp /var/lib/mysql/olddb/table_name.ibd /var/lib/mysql/newdb/
chown mysql:mysql /var/lib/mysql/newdb/table_name
```

Import table dengan perintah dibawah.
```bash
mysql> use newdb;
mysql> ALTER TABLE table_name DISCARD TABLESPACE;
```

Catatan: Error [1932] Table doesn't exist in engine biasanya terjadi pada table dengan engine Innodb, Jika table dari database ada yang menggunakan MyISAM cukup copy file .frm, .MYD dan .MYI saja ke database baru.

Jika terlalu lama menggunakan perintah diatas, ubah saja menjadi shell script seperti berikut.

```bash
vim fix-table.sh
```

Masukan script berikut, ubah sesuai nama database nya.
```bash
#!/bin/bash
echo -e "\033[0;32mBenerin table...\033[0m"

msg="table"
if [ $# -eq 1 ]
  then msg="$1"
fi

table="$msg"
olddb="olddb_name"
newdb="newdb_name"

cat /dev/null > /root/fix-db/dump.sql

echo -e "Get Schema"
mysqlfrm --user=root --server=root\@localhost --port 3300 /var/lib/mysql/"$olddb"/"$table".frm > dump.sql

echo -e "Fix dump file"
sed -i 's/#.*//' dump.sql
sed -i "s/$olddb/$newdb/" dump.sql
sed -i 's/CHARSET=utf8.*/CHARSET=utf8;/' dump.sql

echo -e "Import database"
mysql --database="$newdb" < dump.sql

echo -e "Discard table"
mysql --database="$newdb" --execute="ALTER TABLE $newdb.$table DISCARD TABLESPACE;"

echo -e "Copy .ibd files"
cp /var/lib/mysql/"$olddb"/"$table".ibd /var/lib/mysql/"$newdb"/"$table".ibd

echo -e "Change permission for .ibd files"
chown mysql:mysql /var/lib/mysql/"$newdb"/"$table".ibd

echo -e "Import table"
mysql --database="$newdb" --execute="ALTER TABLE $newdb.$table IMPORT TABLESPACE;"

echo -e "Done..."
```

Jika sudah berikan hak execute.
```bash
chmod +x fix-table.sh
```

Jalankan dengan perintah berikut:
```
./fix-table.sh "table_name"
```

Selesai..