FROM alpine:3.21.5

WORKDIR /var/www/html/wordpress/

RUN <<EOF
set -ex
apk add --no-cache php84 php84-common php84-curl php84-phar php84-mysqli php84-fpm php84-mbstring curl mariadb-client
sed -i 's/^memory_limit = 128M$/memory_limit = 1024M/' /etc/php84/php.ini
sed -i 's/^listen = 127.0.0.1:9000$/listen = 0.0.0.0:9000/' /etc/php84/php-fpm.d/www.conf
#cat -n /etc/php84/php.ini
#false
ln -sf /usr/bin/php84 /usr/bin/php
curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x /usr/local/bin/wp
EOF

COPY --chmod=755 entrypoint /

ENTRYPOINT ["/entrypoint"]

CMD ["php-fpm84", "-F"]
