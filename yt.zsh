function make_env {
    export PYTHONPATH=~/yt/source/python
    export PATH=$PATH:~/yt/build/yt/nodejs:~/yt/build/bin
}

PROMPT='%{$fg_bold[blue]%}$([ -n "$YT_PROXY" ] && echo -n \{$YT_PROXY\}" ")%{$reset_color%}'$PROMPT

autoload -U bashcompinit
bashcompinit
test -f /etc/bash_completion.d/yt_completion && source /etc/bash_completion.d/yt_completion
