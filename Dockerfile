FROM ubuntu:latest

ENV CUPS_USER_ADMIN=admin
ENV CUPS_USER_PASSWORD=password
ENV TERM=xterm

RUN apt-get update;
RUN apt-get install --no-install-recommends --yes \
	cups \
	avahi-daemon \
    libnss-mdns;
RUN rm -rf /var/lib/apt/lists/*;

COPY entrypoint.sh /
RUN  chmod +x /entrypoint.sh;

EXPOSE 631
EXPOSE 5353
VOLUME ["/config"]

ENTRYPOINT ["/entrypoint.sh"]
