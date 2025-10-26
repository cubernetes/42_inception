#!/bin/sh

set -eux

wp core download
wp config create --dbname=test_db --dbhost=mariadb:3306 --dbuser=test_user --prompt=dbpass<<'EOPASS'
test_password
EOPASS
wp db create
wp core install --url=localhost --title="WP-CLI" --admin_user=wpcli --admin_password=wpcli --admin_email=info@wp-cli.org

exec "$@"
