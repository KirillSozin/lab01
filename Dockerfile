FROM nginx:alpine

WORKDIR /var/www/html

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

RUN addgroup -S appgroup && \
  adduser -S appuser -G appgroup && \
  chown -R appuser:appgroup /var/cache/nginx && \
  chown -R appuser:appgroup /var/www/html && \
  chown -R appuser:appgroup /var/log/nginx && \
  touch /var/run/nginx.pid && \
  chown appuser:appgroup /var/run/nginx.pid

USER appuser

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
