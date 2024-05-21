#!/usr/bin/env bash

set -uo pipefail
#set -x

# Use envsubst to replace every file in NGINX_ENVSUBST_TEMPLATE_DIR that ends in NGINX_ENVSUBST_TEMPLATE_SUFFIX
# (defaults to .template) and then output the result to NGINX_ENVSUBST_OUTPUT_DIR.  Only ENV vars beginning with
# NGINX_ should be replaced.
for f in $(find "${NGINX_ENVSUBST_TEMPLATE_DIR:-/usr/local/openresty/nginx/conf.d}" -type f -name "*${NGINX_ENVSUBST_TEMPLATE_SUFFIX:-.template}"); do
    envsubst "$(env | sed -n 's/^\(NGINX_[^=]*\)=.*/\$$\1/p')" < "$f" >"${NGINX_ENVSUBST_OUTPUT_DIR:-/usr/local/openresty/nginx/conf.d}/$(basename "$f" "${NGINX_ENVSUBST_TEMPLATE_SUFFIX:-.template}")"
done

/usr/local/openresty/bin/openresty -g "daemon off;"

# Keep container alive for easier troubleshooting
tail -f /dev/null
