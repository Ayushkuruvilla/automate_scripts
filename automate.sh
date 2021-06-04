#!/bin/bash
sudo apt-get install -y snapd
sudo snap install bitcoin-core
ln -s /snap/bitcoin-core/current/bin/bitcoin{d,-cli} /usr/local/bin/
cd /home/ayush
sudo apt-get update
sudo apt-get install -y autoconf automake build-essential git libtool libgmp-dev libsqlite3-dev python3 python3-mako net-tools zlib1g-dev libsodium-dev gettext
git clone https://github.com/ElementsProject/lightning.git
cd lightning
sudo apt-get install -y valgrind python3-pip libpq-dev
sudo pip3 install -r requirements.txt
./configure
make
sudo make install
cd ..
mkdir .bitcoin
git clone https://github.com/Ayushkuruvilla/automate_scripts.git
mv /home/ayush/automate_scripts/bconfig /home/ayush/.bitcoin/config
mkdir .lightning
mv /home/ayush/automate_scripts/config /home/ayush/.lightning/
pub=$(dig +short myip.opendns.com @resolver1.opendns.com)
internal=$(hostname -I | awk '{print $1}')
var3="bind-addr="$internal":9735"
var4="announce-addr="$pub":9735"
echo $var3 >> .lightning/config
echo $var4 >> .lightning/config
mkdir .lightning/testnet
touch .lightning/testnet/se.txt
gcloud secrets versions access 1 --secret="my-secret" >> .lightning/testnet/se.txt
gcloud secrets versions access 1 --secret="my-secwal" >> .lightning/config
xxd -r .lightning/testnet/se.txt > .lightning/testnet/hsm_secret
chmod 0400 .lightning/testnet/hsm_secret
