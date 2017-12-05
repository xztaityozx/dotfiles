#!/bin/bash 

sudo apt update && sudo apt upgrade -y

sudo apt-add-repository ppa:neovim-ppa/stable
sudo apt update

sudo apt install gnome-terminal dbus-x11 language-pack-ja uim-fep uim-anthy -y

cat << EOF > ~/.uim
(define default-im-name 'anthy)
(define-key generic-on-key? '("<Control> "))
(define-key generic-off-key? '("<Control> "))
EOF

echo 'export DISPLAY=:0.0' >> ~/.bashrc
