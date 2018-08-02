HOST_SHORTNAME=""
if [ -n "$HOST_SHORTNAME" ]; then
    PROMPT='%{$fg_bold[green]%}$HOST_SHORTNAME%{$reset_color%} '$PROMPT
fi
