# Path to oh-my-zsh installation.
export ZSH=/home/ifsmirnov/.oh-my-zsh

ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"
ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
plugins=(git pip sudo ubuntu)
# plugins+=("zsh-syntax-highlighting")

# use custom command-not-found and print failure-msg
# /me from 2021: up-to-date builtin command-not-found seems to work properly.
# Maybe should remove.
autoload -Uz is-at-least
if is-at-least 5.4; then
    if [[ -x /usr/lib/command-not-found ]] ; then
        if (( ! ${+functions[command_not_found_handler]} )) ; then
            function command_not_found_handler {
                [[ -x /usr/lib/command-not-found ]] || return 1
                /usr/lib/command-not-found -- ${1+"$1"} && :
            }
        fi
    fi
else
    plugins+=("command-not-found")
fi

source $ZSH/oh-my-zsh.sh

export HISTSIZE=100000000
export SAVEHIST=100000000

fpath=($fpath /usr/share/zsh/vendor-functions /usr/share/zsh/vendor-completions)
fpath=($fpath $(find /usr/share/zsh/functions -mindepth 1 -type d -print0 | tr '\0' ' '))
fpath+=~/.zfunc

autoload -U compinit && compinit

# User config
export DEBFULLNAME="Ivan Smirnov"
export EMAIL="ifsmirnov@yandex.ru"
export DEBEMAIL="ifsmirnov@yandex.ru"
export EDITOR=vim

# Set up bracketed paste
stty -ixon

if [ `whoami` = 'root' ]; then
    PROMPT='%{$fg_bold[red]%}#%{$reset_color%} '$PROMPT
fi

unsetopt share_history
setopt inc_append_history
disable r

# Compilation shortcuts
alias gd="g++ -std=c++17 -ggdb -DLOCAL";
alias gp="g++ -std=c++17 -pg -DLOCAL";
alias g="g++ -O2 -std=c++17 -Wall -Wextra -DLOCAL -Wno-char-subscripts -Wno-unused-result -I/home/ifsmirnov/olymp"

alias pc=polygon-cli

# Go to the last used directory
alias cdl="cd \"\`ls -c --group-directories-first | head -n 1\`\""

alias fnd="noglob find . -name"
alias sl=""
alias LS=""
alias gi=git # frequent typo

alias tmux='tmux -2'
alias vim='TERM=xterm vim'

# Show 10 largest directories
alias dul="du -ahd 1 | sort -rh | head"

# Print a message with a system notifier
alias msg="notify-send -u critical"

# Prefix-wise history search with Alt-P
bindkey '\ep' up-line-or-beginning-search

# Rename helper (zmv *.h *.hpp renames foo.h into foo.hpp)
autoload -U zmv
alias mmv='noglob zmv -W'

alias a=arc

# Colorful messaging
function red    { echo -e "\033[31;1m$@\033[0;m" ; }
function green  { echo -e "\033[32;1m$@\033[0;m" ; }
function yellow { echo -e "\033[33;1m$@\033[0;m" ; }
function blue   { echo -e "\033[36;1m$@\033[0;m" ; }
function Red    { echo -e "\033[31;5m$@\033[0;m" ; }
function Green  { echo -e "\033[32;5m$@\033[0;m" ; }
function Yellow { echo -e "\033[33;5m$@\033[0;m" ; }
function Blue   { echo -e "\033[36;5m$@\033[0;m" ; }

# Grep anything without removing non-matching lines
function color { egrep --line-buffered --color=always "$|$1"; }

# Wrapper for xargs
function sargs { xargs -L1 sh -c "$@" _; }

# fzf and fd
# local installation?
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# package installation?
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh

# if which fd >/dev/null; then
#     export FZF_DEFAULT_COMMAND='fd --type f'
#     export FZF_ALT_C_COMMAND='fd --type d'
#     export FZF_CTRL_T_COMMAND='fd --type f'
# fi

# Locales
export LANG=en_US.UTF-8
export LANGUAGE=en_US
export LC_CTYPE=en_US.UTF-8
export LC_NUMERIC=en_GB.UTF-8
export LC_TIME=en_GB.UTF-8
export LC_COLLATE="en_US.UTF-8"
export LC_MONETARY=en_GB.UTF-8
export LC_MESSAGES="en_US.UTF-8"
export LC_PAPER=en_GB.UTF-8
export LC_NAME=en_GB.UTF-8
export LC_ADDRESS=en_GB.UTF-8
export LC_TELEPHONE=en_GB.UTF-8
export LC_MEASUREMENT=en_GB.UTF-8
export LC_IDENTIFICATION=en_GB.UTF-8
export LC_ALL=

# Load extra sources
. ~/dotfiles/bindings.zsh
. ~/dotfiles/stopwatch.zsh
[ -e ~/dotfiles/yandex.zsh ] && . ~/dotfiles/yandex.zsh
# May define HOST_SHORTNAME to be appended to prompt.
[ -e ~/dotfiles/local.zsh ] && . ~/dotfiles/local.zsh

# Apply local stuff.
if [ -n "$HOST_SHORTNAME" ]; then
    PROMPT='%{$fg_bold[green]%}$HOST_SHORTNAME%{$reset_color%} '$PROMPT
fi

echo $PATH | tr ':' '\n' | grep -q "^$HOME/bin$" ||
    export PATH="$HOME/bin":$PATH

true
