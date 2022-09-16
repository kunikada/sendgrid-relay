#!/bin/sh

echo "[smtp.sendgrid.net]:587 apikey:$SENDGRID_API" > /etc/postfix/sasl_passwd
postmap /etc/postfix/sasl_passwd

postfix start-fg
