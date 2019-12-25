#!/bin/sh

if [ "$(grep -ci "${CUPS_USER_ADMIN}" /etc/shadow)" -eq 0 ]; then
    adduser --system --no-create-home --ingroup lpadmin --disabled-login "${CUPS_USER_ADMIN}"
fi

echo "${CUPS_USER_ADMIN}:${CUPS_USER_PASSWORD}" | chpasswd

cat <<EOF
===========================================================
The dockerized CUPS instance is now ready for use! The web
interface is available here:
URL:       https://<docker host>:631/
Username:  ${CUPS_USER_ADMIN}
Password:  ${CUPS_USER_PASSWORD}
===========================================================
EOF

touch /config/cupsd.conf

echo "### Start DBUS service ###"
/etc/init.d/dbus start

echo "### Start AVAHI daemon ###"
/etc/init.d/avahi-daemon start

echo "### Start CUPS service ###"
exec /usr/sbin/cupsd -f -c /config/cupsd.conf
