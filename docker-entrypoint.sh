#!/bin/sh

cp /aliases.orig /etc/postfix/aliases
if [ -n "$ALIASES" ]; then
  IFS=, aliases=$ALIASES
  for line in $aliases; do
    echo $line >> /etc/postfix/aliases
  done
fi
newaliases

cp /main.cf.orig /etc/postfix/main.cf
if [ -n "$HOSTNAME" ]; then
  echo "myhostname = $HOSTNAME" >> /etc/postfix/main.cf
fi

echo "[smtp.sendgrid.net]:587 apikey:$SENDGRID_API" > /etc/postfix/sasl_passwd
postmap /etc/postfix/sasl_passwd

postfix start-fg
