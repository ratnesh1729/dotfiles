#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -sinv ${DIR}/emacs.d ~/.emacs.d

# install minimal tools to survive
# install python stuff (needed by emacs conf)
# install c++ stuff (needed by emacs conf)
sudo apt-get install git git-gui gitk cmake ipython python-virtualenv pylint clang-3.8 libclang-3.8-dev libncurses5-dev

# Emacs
read -p "Do you want to install emacs 26.1 from source (configuration may not work otherwise) ? (y) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Installing emacs26 from source"
    ./install_emacs26.sh 
else
    echo "I assume you have emacs 26 installed by yourself."
fi
# emacs configuration
pushd ~/.emacs.d
echo "Adding .cask/bin to your $PATH"
echo "export PATH=\"$PATH:$HOME/.cask/bin/\"" >> .bashrc
export PATH="$PATH:$HOME/.cask/bin/"
bash ./install-cask.sh
cask install
popd

read -p "Install rtags for smart C++ completion ? (y) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    bash ./install_rtags.sh
fi

echo "*** WARNING *** You may need to run these commands in emacs:"
echo " M-x irony-install-server "
echo " M-x jedi:install-server "
