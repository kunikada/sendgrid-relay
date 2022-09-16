FROM alpine

MAINTAINER kunikada

RUN apk add --update --no-cache postfix cyrus-sasl \
  && { \
  echo "mynetworks_style = subnet"; \
  echo "maillog_file = /dev/stdout"; \
  echo "relayhost = [smtp.sendgrid.net]:587"; \
  echo "smtp_sasl_auth_enable = yes"; \
  echo "smtp_sasl_password_maps = texthash:/etc/postfix/sasl_passwd"; \
  echo "smtp_sasl_security_options = noanonymous"; \
  } >> /etc/postfix/main.cf

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

EXPOSE 25

ENTRYPOINT ["/docker-entrypoint.sh"]
