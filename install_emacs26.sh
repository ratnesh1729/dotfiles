sudo apt-get update
sudo apt-get install build-essential texinfo libx11-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev libncurses-dev libxpm-dev automake autoconf gnutls-bin libgnutls28-dev
wget http://mirrors.ibiblio.org/gnu/ftp/gnu/emacs/emacs-26.1.tar.gz
tar -xzvf emacs-26.1.tar.gz
cd emacs-26.1/
./configure
make 
sudo make install
