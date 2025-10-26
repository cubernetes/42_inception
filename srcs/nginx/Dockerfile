FROM alpine:3.21.5

RUN apk add --no-cache --virtual .build-deps openssl && \
		apk add --no-cache nginx && \
		# Unfortunately cannot use `-newkey ed448` because it's too uncommon
		openssl req           \
			-x509             \
			-newkey rsa:4096  \
			-noenc            \
			-keyout /cert.pem \
			-out /cert.pem    \
			-days 365         \
			-sha256           \
			-subj /           \
			-addext 'subjectAltName = DNS:localhost;' && \
		mkdir -p /var/log/nginx /var/lib/nginx /run/nginx && \
		chown -R 1000:1000 /cert.pem /var/log/nginx /var/lib/nginx /run/nginx && \
		chmod 400 /cert.pem && \
		sed -i '/[[:space:]]*user[[:space:]]\+[[:alnum:]-]\+;$/d' /etc/nginx/nginx.conf && \
		apk del .build-deps

# TODO revert and localhost -> tischmid.42.fr
# USER 1000

CMD ["nginx", "-g", "daemon off;"]
