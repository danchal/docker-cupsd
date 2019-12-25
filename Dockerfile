FROM alpine:edge

ENV CUPS_USER_ADMIN=admin
ENV CUPS_USER_PASSWORD=password

RUN apk update --no-cache; \
    apk add --no-cache cups cups-filters ghostscript avahi; \
    \
    # clean up
    rm -rf /var/cache/apk/* /tmp/*

COPY entrypoint.sh /
RUN  chmod +x /entrypoint.sh;

EXPOSE 631
EXPOSE 5353
VOLUME ["/Config"]

ENTRYPOINT ["/entrypoint.sh"]
