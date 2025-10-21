FROM debian:bookworm-slim

RUN <<EOF
# bail on error
set -ex
export DEBIAN_FRONTEND=noninteractive

# -qq is the same as -y but more silent
apt-get update --fix-missing -qq
apt-get upgrade -qq

# ok these -o options might be overkill
apt-get install \
        -o quiet::NoProgress=true \
        -o Dpkg::Options::="--force-confdef" \
        -o Dpkg::Options::="--force-confold" \
        -qq \
        mariadb-server
apt-get autoremove -qq
apt-get clean -qq

# sysvinit way, calls /etc/init.d/mariadb under the hood, which in turn calls mariadbd-safe, which in turn calls mariadbd, and then daemonizes
service mariadb start

# secure installation to remove test DBs and so on
# blank line REQUIRED
mariadb-secure-installation <<'EOM'

n
n
y
y
y
y
EOM
service mariadb stop

# revert apt update and clean other dirs
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* /usr/share/man/* /usr/share/locale/*
EOF

# default data dir
VOLUME ["/var/lib/mysql"]

# --console not really needed here, but it's a nice explicit way of saying "don't daemonize"
CMD ["mariadbd-safe", "--console", "--no-defaults", "--bind-address=*", "--init-file=/tmp/init.sql"]
