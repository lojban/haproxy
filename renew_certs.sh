#!/bin/bash

# Error trapping from https://gist.github.com/oldratlee/902ad9a398affca37bfcfab64612e7d1
__error_trapper() {
  local parent_lineno="$1"
  local code="$2"
  local commands="$3"
  echo "error exit status $code, at file $0 on or near line $parent_lineno: $commands"
}
trap '__error_trapper "${LINENO}/${BASH_LINENO}" "$?" "$BASH_COMMAND"' ERR

set -euE -o pipefail
shopt -s failglob

# This is often called from cron, so:
export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:$PATH

podman exec -u root -it web certbot renew --http-01-port 8888
podman exec -u root -it web chown -R $(id -u):$(id -g) /etc/letsencrypt/

cat /home/sphaproxy/haproxy/containers/web/data/letsencrypt/live/lojban.org/fullchain.pem \
    /home/sphaproxy/haproxy/containers/web/data/letsencrypt/live/lojban.org/privkey.pem > \
        /home/sphaproxy/haproxy/containers/web/data/letsencrypt/live/lojban.org/haproxy.pem

systemctl --user restart web

echo "cert renewal complete"
