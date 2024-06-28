#!/bin/bash

function red    { echo -e "\033[31;1m$@\033[0;m" ; }
function Red    { echo -e "\033[31;10m$@\033[0;m" ; }
function green  { echo -e "\033[32;1m$@\033[0;m" ; }
function Green  { echo -e "\033[32;10m$@\033[0;m" ; }

_version_is_at_least_impl() {
    { cat; echo $1; } | sort -crV 2>/dev/null
}

die() {
    echo "Fatal error: $@"
    exit 1
}

confirm() {
    read -p "$* [y/n] " rsp
    case $rsp in
        y) return 0;;
        *)
            echo Canceled.
            return 1
            ;;
    esac
}

version_is_at_least() {
    eval $2 >/dev/null 2>/dev/null || die "Failed to check version with command '$2'"
    eval $2 | _version_is_at_least_impl $1
}

DOTFILES="ackrc inputrc vimrc gitconfig lesskey zshrc tmux.conf"
PACKAGES="vim tmux zsh fzf fd-find git"
DIR=`pwd`

##################################################################

install_packages() {
    is_installed() {
        dpkg -s $1 2>/dev/null | grep -q 'Status: install ok installed'
    }

    to_install=()

    for package in $PACKAGES; do
        if is_installed $package; then
            Green "Package $package is already installed"
        else
            red "Going to install $package"
            to_install+=($package)
        fi
    done

    if [ "${#to_install[@]}" -eq 0 ]; then
        green Nothing to install
        return
    fi

    echo "Will install packages ${to_install[@]}"
    confirm Install? || die "Canceled"
    sudo apt install "${to_install[@]}" &&
        green Installed everything ||
        die Failed to install some packages
}

oh_my_zsh() {
    if ! test -d ~/.oh-my-zsh; then
        green Installing oh-my-zsh
        which zsh >/dev/null || { red "    Install zsh first"; return; }
        env CHSH=no RUNZSH=no KEEP_ZSHRC=yes \
            sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    else
        green oh-my-zsh already installed
    fi
}

regular_symlinks() {
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
}

bin_symlinks() {
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
}

ssh_config() {
    # Openssh of version at least 7.3p1 is needed
    # due to 'include' directive in config
    green Creating .ssh directory and copying config and sshrc
    if ! test -d ~/.ssh; then
        green "    "Creating ~/.ssh directory
        mkdir ~/.ssh
        chmod 700 .ssh
    fi

    if version_is_at_least 7.3 \
        "ssh -V 2>&1 | grep -Po '(?<=OpenSSH_)[0-9.]*'"
    then
        Green "    ssh >= 7.3 detected, using ssh_config"
        mkdir -p ~/.ssh/config.d
        ln -sf $DIR/ssh_config ~/.ssh/config
    else
        Green "    ssh < 7.3 detected, using ssh_config_noincl"
        ln -sf $DIR/ssh_config_noincl ~/.ssh/config
    fi

    ln -sf $DIR/sshrc ~/.ssh/rc
    mkdir -p ~/.ssh/sockets
}

vim_stuff() {
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
}

run_lesskey() {
    if version_is_at_least 582 \
        "less --version | grep -Po '(?<=^less )[0-9.]*'"
    then
        green "Lesskey is not needed"
    else
        green Running lesskey
        lesskey
    fi
}

install_tmux_packages() {
    if test -d ~/packages/extrakto; then
        green Extracto already installed
        return
    fi

    confirm Install extrakto? || return
    set -e
    mkdir -p ~/packages
    git clone https://github.com/laktak/extrakto ~/packages/extrakto

    if [ -n "$TMUX" ]; then
        green Reloading tmux.conf to apply new bindings
        tmux source-file ~/.tmux.conf
    fi

    set +e
}

install_vim_packages() {
    confirm Install vundle packages? || return

    vim +VundleInstall +qa &&
        green Installed Vundle packages ||
        red Something went wrong "while" installing Vundle packages
}

while [ $# -gt 0 ]; do
    case $1 in
        --install)
            install=1
            ;;
        --apt-update)
            apt_update=1
            ;;
        --tmux)
            install_tmux=1
            ;;
        --vim)
            install_vim=1
            ;;
        *)
            die "Unknown option '$1'"
            ;;
    esac
    shift
done

if [ "$apt_update" == 1 ]; then
    green "Running apt update"
    sudo apt update
fi

if [ "$install" == 1 ]; then
    green "Installing packages"
    install_packages
fi

oh_my_zsh
regular_symlinks
bin_symlinks
ssh_config
vim_stuff
run_lesskey

if [ "$install_tmux" == 1 ]; then
    green "Installing tmux packages"
    install_tmux_packages
fi

if [ "$install_vim" == 1 ]; then
    green "Installing vim packages"
    install_vim_packages
fi

green "Done!"
