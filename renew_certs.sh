#!/bin/bash

# This is often called from cron, so:
export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:$PATH

podman exec -u root -it web certbot renew --http-01-port 8888
podman exec -u root -it web chown -R $(id -u):$(id -g) /etc/letsencrypt/

cat /home/sphaproxy/haproxy/containers/web/data/letsencrypt/live/lojban.org/fullchain.pem \
    /home/sphaproxy/haproxy/containers/web/data/letsencrypt/live/lojban.org/privkey.pem > \
        /home/sphaproxy/haproxy/containers/web/data/letsencrypt/live/lojban.org/haproxy.pem

systemctl --user restart web
