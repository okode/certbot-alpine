FROM alpine:3.5

RUN apk add --no-cache certbot

VOLUME /etc/letsencrypt

EXPOSE 80

CMD /usr/bin/certbot certonly --standalone --verbose --noninteractive --quiet --standalone --agree-tos --email="developers@okode.com" -d "sonarqube.okode.com" --dry-run --preferred-challenges http-01 && tail -f /var/log/letsencrypt/letsencrypt.log
