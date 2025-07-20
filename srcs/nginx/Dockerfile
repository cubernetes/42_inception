FROM alpine:3.21.4

RUN apk add --no-cache --virtual .build-deps openssl && \
		apk add --no-cache nginx && \
		openssl req           \
			-x509             \
			-newkey ed448     \
			-noenc            \
			-keyout /cert.pem \
			-out /cert.pem    \
			-days 365         \
			-sha256           \
			-subj /           \
			-addext 'subjectAltName = DNS:tischmid.42.fr;' && \
		mkdir -p /var/log/nginx /var/lib/nginx /run/nginx && \
		chown -R 1000:1000 /cert.pem /var/log/nginx /var/lib/nginx /run/nginx && \
		chmod 400 /cert.pem && \
		sed -i '/[[:space:]]*user[[:space:]]\+[[:alnum:]-]\+;$/d' /etc/nginx/nginx.conf && \
		apk del .build-deps

USER 1000

CMD ["nginx", "-g", "daemon off;"]
