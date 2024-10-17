haproxy config for lojban.org; uses https://github.com/lojban/lbcs for systems management.

The only part of this repo that's really interesting at all is the actual haproxy config, which is in misc/haproxy.cfg

Normally there would be a clear line between the container configs / systems management and the "source" tree, but that doesn't really apply here.

Note that lojban.com and lojban.net have TLS terminated at cloudflare, and redirect to lojban.org via cloudflare Rules.
