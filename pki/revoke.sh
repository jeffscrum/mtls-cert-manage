#!/bin/bash
# use argument as client name
#export clientname="client1"
export workdir="/home/jeffscrum/mtls-cert-manage/pki"

sudo rm $workdir/haproxycerts/revoked.pem
sudo rm $workdir/splunkcerts/revoked.pem

sudo easyrsa --passin=file:capassfile gen-crl
sudo easyrsa --passin=file:capassfile revoke $1
sudo easyrsa --passin=file:capassfile gen-crl

sudo cp $workdir/pki/crl.pem $workdir/haproxycerts/revoked.pem
sudo cp $workdir/pki/crl.pem $workdir/splunkcerts/revoked.pem

sudo chown jeffscrum:jeffscrum $workdir/haproxycerts/revoked.pem
sudo chown jeffscrum:jeffscrum $workdir/splunkcerts/revoked.pem

sudo chmod 600 $workdir/haproxycerts/revoked.pem
sudo chmod 600 $workdir/splunkcerts/revoked.pem
