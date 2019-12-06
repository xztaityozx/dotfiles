#!/bin/zsh

cd /tmp
mkdir Cica
cd Cica

wget https://github.com/miiton/Cica/releases/download/v4.1.2/Cica_v4.1.2.zip

unzip ./Cica_v4.1.2.zip
rm ./Cica_v4.1.2.zip
cd ../
mv Cica ~/.local/share/fonts/
