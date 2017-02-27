FROM nginx:stable-alpine

RUN apk add --no-cache certbot

VOLUME /etc/letsencrypt

EXPOSE 80

CMD nginx && \
    /usr/bin/certbot certonly --webroot --verbose --noninteractive --quiet  --agree-tos --email="developers@okode.com" --dry-run -w /usr/share/nginx/html -d "sonarqube.okode.com"
