FROM alpine:3.21.5

WORKDIR /opt

COPY entrypoint.sh /entrypoint.sh

RUN <<EOF
set -ex
apk add --no-cache php84 php84-common php84-curl php84-phar php84-mysqli php84-fpm curl
sed -i 's/^memory_limit = 128M$/memory_limit = 1024M/' /etc/php84/php.ini
#cat -n /etc/php84/php.ini
#false
ln -sf /usr/bin/php84 /usr/bin/php
curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x /usr/local/bin/wp
EOF

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm84", "-F"]
