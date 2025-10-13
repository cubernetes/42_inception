FROM alpine:3.21.5

WORKDIR /opt

ADD https://wordpress.org/latest.tar.gz /opt

RUN tar xf *.gz && rm *.gz && apk add --no-cache php84-fpm

CMD ["php-fpm84", "-F"]
