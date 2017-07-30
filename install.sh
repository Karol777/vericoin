#!/usr/bin/env bash

# variables
APP_ROOT=/home/ubuntu/vericoin-master/

# install dependencies
sudo apt-get install -y unzip gcc g++ make automake supervisor
sudo apt-get install -y libcurl-ocaml-dev libssl-dev

# download and build
wget https://github.com/andriytkachiv/vericoin/archive/master.zip
cd vericoin-master/
tar -xzvf cpuminer-opt-3.6.7
cd cpuminer-opt-3.6.7
./autogen.sh
CFLAGS="-O3 -march=native -Wall" CXXFLAGS="$CFLAGS -std=gnu++11" ./configure --with-curl
make
cp ../run.sh run.sh
chmod +x run.sh

# supervisor
cd ..
touch "$APP_ROOT/log.log"
cp vericoin.conf /etc/supervisor/conf.d/vericoin.conf
sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl restart all
