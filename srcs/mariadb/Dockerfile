FROM debian:bookworm-slim

RUN <<EOF
set -ex
export DEBIAN_FRONTEND=noninteractive
apt-get update --fix-missing -qq
apt-get upgrade -qq
apt-get install \
        -o quiet::NoProgress=true \
        -o Dpkg::Options::="--force-confdef" \
        -o Dpkg::Options::="--force-confold" \
        -qq \
        mariadb-server
apt-get autoremove -qq
apt-get clean -qq
sed -i 's/^bind-address[[:space:]]\+.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
/etc/init.d/mariadb start
mariadb-secure-installation <<'EOM'

n
n
y
y
y
y
EOM
/etc/init.d/mariadb stop
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* /usr/share/man/* /usr/share/locale/*
EOF

VOLUME ["/var/lib/mysql"]

CMD ["mariadbd-safe"]
