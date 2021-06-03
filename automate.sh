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
mv /home/ayush/automate_scripts/bconfig /home/ayush/.bitcoin/
mkdir .lightning
mv /home/ayush/automate_scripts/config /home/ayush/.lightning/
mkdir .lightning/testnet
touch .lightning/testnet/se.txt
gcloud secrets versions access 1 --secret="my-secret" >> .lightning/testnet/se.txt
gcloud secrets versions access 1 --secret="my-secwal" >> .lightning/config
xxd -r .lightning/testnet/se.txt > .lightning/testnet/hsm_secret
chmod 0400 .lightning/testnet/hsm_secret
