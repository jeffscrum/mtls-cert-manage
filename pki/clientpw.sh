#!/bin/bash
# use argument as client name
#export clientname="client1"
export workdir="/home/jeffscrum/mtls-cert-manage/pki"
sudo rm $workdir/pki/private/$1.key
sudo rm $workdir/pki/issued/$1.crt
sudo rm $workdir/pki/reqs/$1.req
sudo easyrsa --passin=file:capassfile --passout=file:cppassfile  build-client-full $1 
sudo easyrsa --passin=file:cppassfile --passout=file:p12passfile export-p12 $1
#sudo rm -R $workdir/haproxycerts
#mkdir  $workdir/haproxycerts
sudo rm $workdir/clientcerts/*
sudo cp $workdir/pki/private/$1.key  $workdir/clientcerts
sudo cp $workdir/pki/private/$1.p12  $workdir/clientcerts
sudo cp $workdir/pki/issued/$1.crt $workdir/clientcerts
sudo cp $workdir/pki/ca.crt $workdir/clientcerts
cd $workdir/clientcerts
sudo chown jeffscrum:jeffscrum *
sudo chmod 600 *
