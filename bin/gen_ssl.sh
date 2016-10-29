#!/usr/bin/env bash

[ -z "$SSL_DIR" ] && export SSL_DIR="."
[ -z "$DOMAIN" ] && export DOMAIN="*.lvh.me"
[ -z "$FILENAME" ] && export FILENAME="wild_lvh_me" 

echo " => Generating Self-Signed SSL certificate for $DOMAIN (Using ENV[DOMAIN])"
echo "    Filename: $SSL_DIR/$FILENAME (Using ENV[SSL_DIR] and ENV[FILENAME])"

if [ -e "$SSL_DIR/$FILENAME.key" ]; then
  echo "$SSL_DIR/$FILENAME.key exists...aborting"
  exit 1
fi

# A blank passphrase
export PASSPHRASE=""

# Set our CSR variables
export SUBJ="
C=US
ST=Texas
O=
localityName=Austin
commonName=$DOMAIN
organizationalUnitName=
emailAddress=
"

# Create our SSL directory
# in case it doesn't exist
[ -d "$SSL_DIR" ] || mkdir -p "$SSL_DIR"

#t Generate our Private Key, CSR and Certificate
echo " -> Generating private key ($SSL_DIR/$FILENAME.key)..."
openssl genrsa -out "$SSL_DIR/$FILENAME.key" 2048
echo " ->  Generating CSR ($SSL_DIR/$FILENAME.key)..."
openssl req -new -subj "$(echo -n "$SUBJ" | tr "\n" "/")" -key "$SSL_DIR/$FILENAME.key" -out "$SSL_DIR/$FILENAME.csr" -passin pass:$PASSPHRASE
echo " -> Generating Certificate ($SSL_DIR/$FILENAME.csr)..."
openssl x509 -req -days 365 -in "$SSL_DIR/$FILENAME.csr" -signkey "$SSL_DIR/$FILENAME.key" -out "$SSL_DIR/$FILENAME.crt"
