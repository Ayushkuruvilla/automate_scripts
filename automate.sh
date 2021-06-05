#!/bin/bash
mkdir helloimhere
sudo apt-get install -y snapd
sudo snap install bitcoin-core
ln -s /snap/bitcoin-core/current/bin/bitcoin{d,-cli} /usr/local/bin/
sudo useradd -m  -p test_password test_user
shopt -s expand_aliases
alias sud='sudo -u test_user'
cd /home/test_user
sudo bash -c 'apt-get update'
sudo bash -c 'apt-get install -y autoconf automake build-essential git libtool libgmp-dev libsqlite3-dev python3 python3-mako net-tools zlib1g-dev libsodium-dev gettext'
sud git clone https://github.com/ElementsProject/lightning.git
cd lightning
sudo bash -c 'apt-get install -y valgrind python3-pip libpq-dev'
sudo bash -c 'pip3 install -r requirements.txt'
sud ./configure
sud make
sudo make install
cd ..
sud mkdir .bitcoin
sud git clone https://github.com/Ayushkuruvilla/automate_scripts.git
sud mv /home/test_user/automate_scripts/bconfig /home/test_user/.bitcoin/config
sud mkdir .lightning
sud mv /home/test_user/automate_scripts/config /home/test_user/.lightning/
pub=$(dig +short myip.opendns.com @resolver1.opendns.com)
internal=$(hostname -I | awk '{print $1}')
var3="bind-addr="$internal":9735"
var4="announce-addr="$pub":9735"
sud echo "$var3" | sudo tee -a .lightning/config
sud echo "$var4" | sudo tee -a .lightning/config
sud mkdir .lightning/testnet
sud touch .lightning/testnet/se.txt
sudo bash -c 'gcloud secrets versions access 1 --secret="my-secret" >> .lightning/testnet/se.txt'
sudo bash -c 'gcloud secrets versions access 1 --secret="my-secwal" >> .lightning/config'
sudo bash -c 'xxd -r .lightning/testnet/se.txt > .lightning/testnet/hsm_secret'
sud chmod 0400 .lightning/testnet/hsm_secret
sud lightningd --daemon
