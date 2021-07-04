#!/bin/bash

podman exec -u root -it web certbot certonly --expand --standalone \
    -d lojban.org \
    -d mw.lojban.org -d mw-live.lojban.org -d mw-test.lojban.org \
    -d jbotcan.org -d jbovlaste.lojban.org -d www.lojban.org \
    -d vlasisku.lojban.org -d tiki.lojban.org -d test-vs.lojban.org \
    -d camxes.lojban.org -d corpus.lojban.org \
    --non-interactive --agree-tos --email webmaster@lojban.org --http-01-port=8888
podman exec -u root -it web chown -R $(id -un):$(id -gn) /etc/letsencrypt/

cat containers/web/data/letsencrypt/live/lojban.org/fullchain.pem containers/web/data/letsencrypt/live/lojban.org/privkey.pem > containers/web/data/letsencrypt/live/lojban.org/haproxy.pem

systemctl --user restart web

