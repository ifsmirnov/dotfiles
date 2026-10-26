# Rich history log: keeps cwd / session id / a short random tag for every
# command, in a separate file from $HISTFILE. This way `history` / Ctrl-R /
# fzf keep showing plain commands, while `rh` (below) can look up a specific
# invocation by the tag shown in the prompt.

zmodload zsh/datetime 2>/dev/null

ZSH_RICH_HISTORY_FILE="${ZSH_RICH_HISTORY_FILE:-$HOME/.zsh_rich_history}"

# One id per shell session, so all commands from the same shell can be
# grouped together.
typeset -g ZSH_SESSION_ID="${HOST:-$(hostname)}-$$-${EPOCHSECONDS}"

# Sets $PS_TAG directly instead of `print`-ing it: a `$(...)` command
# substitution forks a subshell, and a forked subshell's $RANDOM restarts
# from the parent's current seed state, so two forks in a row (without the
# parent itself consuming $RANDOM in between) yield the *same* sequence -
# i.e. the same tag every time. Setting the variable in-process avoids the
# fork and keeps $RANDOM advancing normally.
function _zsh_gen_tag() {
    local chars='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
    local -i n=${#chars}
    local tag=''
    local -i i
    for i in 1 2 3; do
        tag+=${chars[RANDOM % n + 1]}
    done
    PS_TAG=$tag
}

# Tag for the *next* command, regenerated before every prompt and shown in
# PROMPT (see zshrc). preexec logs whatever tag was visible when the command
# was typed.
_zsh_gen_tag

function _zsh_rich_history_precmd() {
    _zsh_gen_tag
}

function _zsh_rich_history_preexec() {
    local cmd="${1//$'\n'/\\n}"
    cmd="${cmd//$'\t'/ }"
    print -r -- "${EPOCHSECONDS}	${ZSH_SESSION_ID}	${PS_TAG}	${PWD}	YT_PROXY=${YT_PROXY}	${cmd}" >> "$ZSH_RICH_HISTORY_FILE"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _zsh_rich_history_precmd
add-zsh-hook preexec _zsh_rich_history_preexec

# Look up commands in the rich history log: `rh` lists everything, `rh
# <pattern>` greps by tag / session id / dir / command text (e.g. `rh FdU`
# finds the exact command tagged [FdU] in the prompt).
function rh() {
    local file="$ZSH_RICH_HISTORY_FILE"
    local pattern="$1"
    { [[ -n "$pattern" ]] && grep -F -- "$pattern" "$file" || cat "$file"; } |
        while IFS=$'\t' read -r ts session tag dir yt_proxy cmd; do
            printf '%s  [%s]  %-24s  %-30s  %-20s  %s\n' \
                "$(date -d "@$ts" '+%Y-%m-%d %H:%M:%S')" "$tag" "$session" "$dir" "$yt_proxy" "$cmd"
        done
}
