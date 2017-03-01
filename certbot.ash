#!/bin/ash

LETSENCRYPT_CERTDIR=/etc/letsencrypt/live
LOG_FILE=/var/log/container.log

if [ "$(ls -A $LETSENCRYPT_CERTDIR)" ]; then
    echo "$LETSENCRYPT_CERTDIR is not empty, it is a renewal" >> $LOG_FILE
    /usr/bin/certbot renew --quiet --no-self-upgrade >> $LOG_FILE 2>&1
else
    if [ -z "${ADMIN_MAIL}" ]; then
        echo "ERROR: Administrator email needed" >> $LOG_FILE
    elif [ -z "${DOMAINS}" ]; then
        echo "ERROR: Domains variable needed" >> $LOG_FILE
    else
        echo "$LETSENCRYPT_CERTDIR is empty, executing first retrieval" >> $LOG_FILE
        /usr/bin/certbot certonly --webroot --verbose --noninteractive --quiet  --agree-tos --email="${ADMIN_MAIL}" -w /usr/share/nginx/html -d "${DOMAINS}" >> $LOG_FILE 2>&1
    fi
fi

find $LETSENCRYPT_CERTDIR -name 'privkey.pem' -exec cat {} + > $LETSENCRYPT_CERTDIR/combined.pem
find $LETSENCRYPT_CERTDIR -name 'fullchain.pem' -exec cat {} + >> $LETSENCRYPT_CERTDIR/combined.pem
