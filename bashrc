export PATH="/home/ifsmirnov/bin":$PATH
export EDITOR=vim

export PS1='\[\033[31;1m\]\u@\h:./\W$\[\033[0m\] '

export DEBFULLNAME="Ivan Smirnov"
export EMAIL="ifsmirnov@yandex.ru"
export DEBEMAIL="ifsmirnov@yandex.ru"
export QT_HOME="/home/ifsmirnov/dev/Qt5.5.1/5.5/gcc_64"
export ANDROID_HOME="/home/ifsmirnov/dev/android-sdk-linux"
export JAVA_HOME="/usr/lib/jvm/java-8-oracle"
export ANDROID_NDK="/home/ifsmirnov/dev/android-ndk-r13b"

export DEBFULLNAME="Ivan Smirnov"
export EMAIL="ifsmirnov@yandex.ru"
export DEBEMAIL="ifsmirnov@yandex.ru"
export QT_HOME="/home/ifsmirnov/.Qt5.9.1/5.3/gcc_64"
export ANDROID_HOME="/home/ifsmirnov/dev/android-sdk-linux"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
export ANDROID_NDK="/home/ifsmirnov/sdk/android-ndk-r13b"

# ACM shortcuts
alias gd="g++ -std=c++11 -ggdb -DLOCAL";
alias gp="g++ -std=c++11 -pg -DLOCAL";
alias g="g++ -O2 -std=c++11 -Wall -Wextra -DLOCAL -Wno-char-subscripts -Wno-unused-result -I/home/ifsmirnov/olymp"
alias pc=polygon-cli

# Go to the last used directory
alias cdl="cd \"\`ls -c --group-directories-first | head -n 1\`\""
alias fnd="find . -name"
alias sl=""
alias LS=""
alias ack="ack-grep"

# Show most place consuming subdirectories
alias dul="du -ahd 1 | sort -rh | head"

# Quickly go backwards in directory tree
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."

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

if [ -f ~/dotfiles/ya_bashrc ]; then
    . ~/dotfiles/ya_bashrc
fi
