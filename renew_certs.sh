#!/bin/bash

podman exec -u root -it web certbot renew --tls-sni-01-port=8888
podman exec -u root -it web chown -R $(id -un):$(id -gn) /etc/letsencrypt/

cat containers/web/data/letsencrypt/live/lojban.org/fullchain.pem containers/web/data/letsencrypt/live/lojban.org/privkey.pem > containers/web/data/letsencrypt/live/lojban.org/haproxy.pem

systemctl --user restart web

