FROM alpine:3.21.4

RUN apk add --no-cache mariadb

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["entrypoint.sh"]

USER mysql

CMD ["mariadbd"]
