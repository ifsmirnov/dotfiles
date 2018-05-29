# If the command finished in more than 2s, show its running time in RPROMPT.
# If in more than 10s, show a display notification.
function stopwatch_pre() {
    if (( ${+SAVED_RPROMPT} )); then
        RPROMPT="$SAVED_RPROMPT"
    fi
    EXECUTED=1
    LAST_CMD_SEC=`date +%s`
    LAST_CMD_MSEC=`date +%N`
    LAST_CMD_MSEC=${LAST_CMD_MSEC:0:3}
}

function stopwatch_post() {
    if [[ -n "$EXECUTED" ]]; then
        sec=`date +%s`
        msec=`date +%N`
        msec=${msec:0:3}
        msec_delta=$(( (sec-LAST_CMD_SEC)*1000+(msec-LAST_CMD_MSEC) ))
        if [[ $msec_delta -gt 2000 ]]; then
            SAVED_RPROMPT=$RPROMPT
            last_command=$(echo $history[$((HISTCMD-1))] | cut -d' ' -f1)
            RPROMPT="[$last_command: $((msec_delta/1000))s $((msec_delta%1000))ms] $RPROMPT"

            if [[ $msec_delta -gt 10000 ]]; then
                msg "'$history[$((HISTCMD-1))]' finished in $((msec_delta/1000)) s"
            fi
        else
            RPROMPT="$SAVED_RPROMPT"
        fi
    else
        RPROMPT="$SAVED_RPROMPT"
    fi
    EXECUTED=
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec stopwatch_pre
add-zsh-hook precmd stopwatch_post
