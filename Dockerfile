FROM nginx:stable-alpine

RUN apk add --no-cache certbot

VOLUME /etc/letsencrypt

COPY crontab /var/spool/cron/crontabs/root
COPY certbot.ash /usr/local/bin/

RUN chmod +x /usr/local/bin/certbot.ash
RUN touch /var/log/container.log

EXPOSE 80
EXPOSE 443

CMD nginx && crond && tail -f /var/log/container.log
