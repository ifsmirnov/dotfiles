# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/ifsmirnov/.oh-my-zsh
export PATH="/home/ifsmirnov/bin":$PATH

export DEBFULLNAME="Ivan Smirnov"
export EMAIL="ifsmirnov@yandex.ru"
export DEBEMAIL="ifsmirnov@yandex.ru"
export QT_HOME="/home/ifsmirnov/.Qt5.9.1/5.3/gcc_64"
export ANDROID_HOME="/home/ifsmirnov/sdk/android"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
export ANDROID_NDK="/home/ifsmirnov/sdk/android-ndk-r13b"
export CCACHE='grc -e ccache'
export USE_CCACHE=1
export NDK_CCACHE='grc -e ccache'

export EDITOR=vim
alias tmux='tmux -2'
alias vim='TERM=xterm vim'

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git command-not-found pip sudo ubuntu zsh-completions)

source $ZSH/oh-my-zsh.sh

autoload -U compinit && compinit

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if [ -n "$PKG_ROOT" ]; then
    PROMPT='%{$fg_bold[green]%}[env]%{$reset_color%} '$PROMPT
fi

if [ `whoami` = 'root' ]; then
    PROMPT='%{$fg_bold[red]%}#%{$reset_color%} '$PROMPT
fi

alias senv=~/work/pkg-root/mysenv.sh

alias clean_env="dpkg -l | grep bundle | grep -v deve | cut -f3 -d' ' | xargs apt-get remove --assume-yes && apt-get autoremove --assume-yes"

unsetopt share_history

# ACM shortcuts
alias gd="g++ -std=c++17 -ggdb -DLOCAL";
alias gp="g++ -std=c++17 -pg -DLOCAL";
alias g="g++ -O2 -std=c++17 -Wall -Wextra -DLOCAL -Wno-char-subscripts -Wno-unused-result -I/home/ifsmirnov/olymp"
alias pc=polygon-cli

# Go to the last used directory
alias cdl="cd \"\`ls -c --group-directories-first | head -n 1\`\""
alias fnd="find . -name"
alias sl=""
alias LS=""

alias dul="du -ahd 1 | sort -rh | head"

# Colorful messaging
function red { echo -e "\033[31;1m$@\033[0;m" ; }
function green { echo -e "\033[32;1m$@\033[0;m" ; }
function yellow { echo -e "\033[33;1m$@\033[0;m" ; }
function blue { echo -e "\033[36;1m$@\033[0;m" ; }
function Red { echo -e "\033[31;3m$@\033[0;m" ; }
function Green { echo -e "\033[32;3m$@\033[0;m" ; }
function Yellow { echo -e "\033[33;3m$@\033[0;m" ; }
function Blue { echo -e "\033[36;3m$@\033[0;m" ; }

# Grep anything without removing non-matching lines
function color { egrep --color=always "$|$1"; }

# Wrapper for xargs
function sargs { xargs -L1 sh -c "$@" _; }

# Print a message with a system notifier
alias msg="notify-send -u critical"

# preexec() {
#     # guake -r "$(basename $(pwd)) $1"
#     # echo -n '\e]0;'
#     # echo -nE "$1"
#     # print -nP '  (%~)'
#     # echo -n '\a'
# }
# precmd() {
#     guake -r $(basename $(pwd))
# }
# 
export HISTSIZE=100000000
export SAVEHIST=100000000

alias dcj=/home/ifsmirnov/olymp/dist_codejam17/tester/dcj.sh
stty -ixon
