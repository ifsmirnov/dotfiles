#!/bin/sh

DOTFILES="ackrc inputrc vimrc gitconfig"
DIR=`pwd`

echo Making symlinks for regular dotfiles
for file in $DOTFILES; do
    echo "    $file"
    ln -sf $DIR/$file ~/.$file
done

echo -n "Patching .bashrc... "
if grep -q 'dotfiles/bashrc' ~/.bashrc; then
    echo "patch already exists"
else
    cat >> ~/.bashrc << EOF
if [ -f ~/dotfiles/bashrc ]; then
    . ~/dotfiles/bashrc
fi
EOF
    echo "done"
fi

echo "Making symlinks for ~/bin executables"
mkdir -p ~/bin
cd bin
for exe in *; do
    if ln -s $DIR/bin/$exe ~/bin/$exe; then
        echo "    $exe"
    else
        echo "    Failed to copy $exe"
    fi
done
cd ..

echo Creating .ssh directory and copying config
if ! test -d ~/.ssh; then
    echo Create ~/.ssh directory
    mkdir ~/.ssh
    chmod 700 .ssh
fi
mkdir -p ~/.ssh/config.d
ln -sf $DIR/ssh_config ~/.ssh/config
mkdir -p ~/.ssh/sockets

echo Creating vim special directories
mkdir -p ~/.vim/.undo
mkdir -p ~/.vim/.swp

echo Done
