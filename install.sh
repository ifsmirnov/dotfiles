#!/bin/sh

DOTFILES="ackrc inputrc vimrc gitconfig lesskey zshrc tmux.conf"
DIR=`pwd`

echo Installing oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo Making symlinks for regular dotfiles
for file in $DOTFILES; do
    echo "    $file"
    ln -sf $DIR/$file ~/.$file
done

# Not needed after I migrated to zsh
#
# echo -n "Patching .bashrc... "
# if grep -q 'dotfiles/bashrc' ~/.bashrc; then
#     echo "patch already exists"
# else
#     cat >> ~/.bashrc << EOF
# if [ -f ~/dotfiles/bashrc ]; then
#     . ~/dotfiles/bashrc
# fi
# EOF
#     echo "done"
# fi

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

# Openssh of version at least 7.3p1 is needed 
# due to 'include' directive in config
echo Creating .ssh directory and copying config and sshrc
if ! test -d ~/.ssh; then
    echo Create ~/.ssh directory
    mkdir ~/.ssh
    chmod 700 .ssh
fi
mkdir -p ~/.ssh/config.d
ln -sf $DIR/ssh_config ~/.ssh/config
ln -sf $DIR/sshrc ~/.ssh/rc
mkdir -p ~/.ssh/sockets

echo Creating vim special directories
mkdir -p ~/.vim/.undo
mkdir -p ~/.vim/.swp
ln -sf $DIR/vim-snippets ~/.vim/mysnippets

echo Running lesskey
lesskey

echo "Done!"
echo

cat <<EOF
Do not forget!
    - install latest vim
    - install vundle
    - install vim plugins
    - build ycm
    - (optional) install latest ssh client
EOF
