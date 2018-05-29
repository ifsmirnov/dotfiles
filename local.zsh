# locales
# export LANG=en_US.UTF-8
# export LANGUAGE=en_US
# export LC_CTYPE=en_US.UTF-8
# export LC_NUMERIC=en_GB.UTF-8
# export LC_TIME=en_GB.UTF-8
# export LC_COLLATE="en_US.UTF-8"
# export LC_MONETARY=en_GB.UTF-8
# export LC_MESSAGES="en_US.UTF-8"
# export LC_PAPER=en_GB.UTF-8
# export LC_NAME=en_GB.UTF-8
# export LC_ADDRESS=en_GB.UTF-8
# export LC_TELEPHONE=en_GB.UTF-8
# export LC_MEASUREMENT=en_GB.UTF-8
# export LC_IDENTIFICATION=en_GB.UTF-8
# export LC_ALL=

HOST_SHORTNAME=""
if [ -n "$HOST_SHORTNAME" ]; then
    PROMPT='%{$fg_bold[green]%}$HOST_SHORTNAME%{$reset_color%} '$PROMPT
fi
