sudo apt-get update
sudo apt install build-essential libncurses-dev
wget http://mirrors.ibiblio.org/gnu/ftp/gnu/emacs/emacs-26.1.tar.gz
tar -xzvf emacs-26.1.tar.gz
cd emacs-26.1/
./configure
make 
sudo make install
