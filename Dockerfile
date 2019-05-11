FROM fedora:30

RUN set -x \
 && useradd -r stunnel \
 && dnf install -y \
        stunnel \
 && cp -v /usr/bin/envsubst /usr/local/bin/
COPY *.template openssl.cnf /srv/stunnel/
COPY stunnel.sh /srv/

RUN set -x \
 && chmod +x /srv/stunnel.sh \
 && mkdir -p /var/run/stunnel /var/log/stunnel \
 && chown -vR stunnel:stunnel /var/run/stunnel /var/log/stunnel

ENTRYPOINT ["/srv/stunnel.sh"]
CMD ["stunnel"]
