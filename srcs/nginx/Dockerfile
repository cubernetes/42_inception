FROM alpine:3.21.5

ARG SITE

COPY ./inception.conf /etc/nginx/http.d/default.conf

RUN apk add --no-cache --virtual .build-deps openssl envsubst moreutils && \
        envsubst '$SITE' < /etc/nginx/http.d/default.conf | sponge /etc/nginx/http.d/default.conf && \
		apk add --no-cache nginx && \
		mkdir -p /var/log/nginx /var/lib/nginx /run/nginx && \
		chown -R 1000:1000 /var/log/nginx /var/lib/nginx /run/nginx && \
		sed -i '/[[:space:]]*user[[:space:]]\+[[:alnum:]-]\+;$/d' /etc/nginx/nginx.conf && \
		apk del .build-deps

USER 1000

CMD ["nginx", "-g", "daemon off;"]
