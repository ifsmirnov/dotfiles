#!/bin/bash

function red    { echo -e "\033[31;1m$@\033[0;m" ; }
function Red    { echo -e "\033[31;5m$@\033[0;m" ; }
function green  { echo -e "\033[32;1m$@\033[0;m" ; }
function Green  { echo -e "\033[32;5m$@\033[0;m" ; }

DOTFILES="ackrc inputrc vimrc gitconfig lesskey zshrc tmux.conf"
DIR=`pwd`

if ! test -d ~/.oh-my-zsh; then
    green Installing oh-my-zsh
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
else
    green oh-my-zsh already installed
fi

green Making symlinks for regular dotfiles
for file in $DOTFILES; do
    if ! [ -e ~/.$file ]; then
        ln -sf $DIR/$file ~/.$file
        Green "    $file"
    else
        if [ "$(readlink ~/.$file)" != "$DIR/$file" ]; then
            Red "    "~/.$file exists and is not a symlink, not overriding
        fi
    fi
done

green Making symlinks for ~/bin executables
mkdir -p ~/bin
cd bin
for exe in *; do
    if ! [ -e ~/bin/$exe ]; then
        ln -sf $DIR/bin/$exe ~/bin/$exe
        Green "    bin/$exe"
    else
        if [ "$(readlink ~/bin/$exe)" != "$DIR/bin/$exe" ]; then
            Red "    "~/bin/$exe exists and is not a symlink, not overriding
        fi
    fi
done
cd ..

# Openssh of version at least 7.3p1 is needed 
# due to 'include' directive in config
green Creating .ssh directory and copying config and sshrc
if ! test -d ~/.ssh; then
    green "    "Creating ~/.ssh directory
    mkdir ~/.ssh
    chmod 700 .ssh
fi
if ./check_ssh_version.sh 7.3; then
    Green "    ssh >= 7.3 detected, using ssh_config"
    mkdir -p ~/.ssh/config.d
    ln -sf $DIR/ssh_config ~/.ssh/config
else
    Green "    ssh < 7.3 detected, using ssh_config_noincl"
    ln -sf $DIR/ssh_config_noincl ~/.ssh/config
fi
ln -sf $DIR/sshrc ~/.ssh/rc
mkdir -p ~/.ssh/sockets

green Creating vim special directories
mkdir -p ~/.vim/.undo
mkdir -p ~/.vim/.swp
ln -sfT $DIR/vim-snippets ~/.vim/mysnippets

if ! test -d ~/.vim/bundle/Vundle.vim; then
    green Installing vundle
    mkdir -p ~/.vim/bundle
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
    green Vundle already installed
fi

green Running lesskey
lesskey

green "Done!"
echo

cat <<EOF
Do not forget!
    - build vim and tmux (manual in man/)
    - install vim plugins (vim +PluginInstall)
    - build ycm (manual on github)
    - (optional) build latest ssh client
EOF
