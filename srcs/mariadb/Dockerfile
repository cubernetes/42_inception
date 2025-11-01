FROM debian:bookworm-slim

RUN <<EOF
# bail on error
set -ex
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get upgrade -y
apt-get install -y mariadb-server
apt-get autoremove -y
apt-get clean -y

# Create missing directories and set correct perms & owners
mkdir -p /var/lib/mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql /run/mysqld
chmod 777 /run/mysqld

# sysvinit way, calls /etc/init.d/mariadb under the hood, which in turn calls mariadbd-safe, which in turn calls mariadbd, and then daemonizes
service mariadb start

# secure installation to remove test DBs and so on
# blank line REQUIRED
mariadb-secure-installation <<'EOM'
y
n
n
y
y
y
y
EOM

mariadb-install-db --user=mysql --skip-test-db

# sleep needed because otherwise, `service mariadb stop` prints an error
sleep 1

# stop the service again
service mariadb stop

# revert apt update and clean other dirs
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* /usr/share/man/* /usr/share/locale/*
EOF

# default data dir
VOLUME ["/var/lib/mysql"]

COPY --chmod=755 entrypoint /

USER mysql

ENTRYPOINT ["/entrypoint"]

CMD ["mariadbd-safe", "--no-defaults", "--bind-address=*", "--init-file=/tmp/init.sql"]
