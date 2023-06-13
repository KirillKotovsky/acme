#!/bin/bash

set -e

echo "Starting create new certificate..."
# if [ "$#" -lt 2 ]; then
#     echo "Usage: ...  <domain> <email> [options]"
#     exit
# fi

DOMAIN=preprod.clerkwindow.advapay.live
DOMAIN2=preprod.akita.advapay.live
EMAIL=insarov@gmail.com

OPTIONS=$1

# echo $2

docker run -d \
  -v $PWD/letsencrypt:/etc/letsencrypt \
  -v $PWD/webroot:/webroot \
  certbot/certbot \
  certonly --webroot -w /webroot \
  -d $DOMAIN \
  -d $DOMAIN2 \
  --email $EMAIL \
  --non-interactive \
  --agree-tos \


# Merge private key and full chain in one file and add them to haproxy certs folder
function cat-cert() {
  dir="./letsencrypt/live/preprod.clerkwindow.advapay.live"
  cat "$dir/privkey.pem" "$dir/fullchain.pem" > "./certs/preprod.clerkwindow.advapay.live.pem"
}

# Run merge certificate for the requested domain name
cat-cert $DOMAIN

