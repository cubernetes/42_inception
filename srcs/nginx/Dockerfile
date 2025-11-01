FROM alpine:3.21.5

RUN apk add --no-cache --virtual .build-deps openssl && \
		apk add --no-cache nginx && \
		# Unfortunately cannot use `-newkey ed448` because browsers don't know it
		openssl req           \
			-x509             \
			-newkey rsa:4096  \
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

COPY ./inception.conf /etc/nginx/http.d/default.conf

# USER 1000
USER 0

CMD ["nginx", "-g", "daemon off;"]
