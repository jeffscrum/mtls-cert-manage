#!/bin/bash
export serverip="192.168.0.1"
export serverfqdn="server.lan"
export workdir="/home/jeffscrum/mtls-cert-manage/pki"
sudo rm $workdir/pki/private/$serverip.key
sudo rm $workdir/pki/issued/$serverip.crt
sudo rm $workdir/pki/reqs/$serverip.req
sudo easyrsa --passin=file:capassfile --subject-alt-name="DNS:localhost,DNS:$serverfqdn,IP:$serverip" build-server-full $serverip nopass
#sudo rm -R $workdir/splunkcerts
#mkdir $workdir/splunkcerts
sudo rm $workdir/splunkcerts/*
sudo cp $workdir/pki/private/$serverip.key $workdir/splunkcerts
sudo cp $workdir/pki/issued/$serverip.crt $workdir/splunkcerts
sudo cp $workdir/pki/ca.crt $workdir/splunkcerts

## Create empty revoked CRL
sudo easyrsa --passin=file:capassfile gen-crl
sudo cp $workdir/pki/crl.pem $workdir/splunkcerts/revoked.pem

cd $workdir/splunkcerts
# add password into private key
#openssl rsa -aes256 -in $serverip.key -out $serverip.pw.key
# convert crt to pem
sudo openssl x509 -inform PEM -in $serverip.crt > $serverip.pem
# genarate server.pem
sudo cat $serverip.pem $serverip.key > server.pem
sudo chown jeffscrum:jeffscrum *
sudo chmod 600  *
