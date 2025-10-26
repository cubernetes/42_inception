#!/bin/sh

#CREATE DATABASE IF NOT EXISTS test_db;
install -m=644 -D /dev/stdin /tmp/init.sql << 'EOF'
CREATE USER IF NOT EXISTS 'test_user'@'%' IDENTIFIED BY 'test_password';
GRANT ALL PRIVILEGES ON test_db.* TO 'test_user'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

exec "$@"
