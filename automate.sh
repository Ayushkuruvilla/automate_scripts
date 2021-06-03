sudo apt-get update
sudo apt-get install -y autoconf automake build-essential git libtool libgmp-dev libsqlite3->
git clone https://github.com/ElementsProject/lightning.git
cd lightning
sudo apt-get install -y valgrind python3-pip libpq-dev
sudo pip3 install -r requirements.txt
./configure
make
sudo make install
cd ..
mkdir .bitcoin
mv /home/ayush/automate_scripts/bconfig /home/ayush/.bitcoin
mkdir .lightning
mv /home/ayush/automate_scripts/config /home/ayush/.lightning
