FROM alpine:3.21.3

WORKDIR /var/www/html

RUN apk update && \
  apk add --no-cache \
  nginx \
  curl \
  && rm -rf /var/cache/apk/*

RUN addgroup appgroup && \
  adduser -S -D -H -G appgroup appuser

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/html /var/log/nginx /var/cache/nginx /var/lib/nginx/tmp /run/nginx \
  && chown -R appuser:appgroup /var/www/html /var/log/nginx /var/cache/nginx /var/lib/nginx /etc/nginx /run/nginx

USER appuser

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
