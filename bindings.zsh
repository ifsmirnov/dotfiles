function _current_branch() {
    git rev-parse --abbrev-ref HEAD 2>/dev/null
}

function _default_branch() {
    git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null | sed 's:origin/::'
}

# Most of this is experimental garbage, but still.
function run() {
    read -sk1 c
    if [ `printf %x "'$c"` = "1b" ]; then
        read -sk1 c
        if [ `printf %x "'$c"` = "1b" ]; then
            # Typed escape twice, exit
            return
        fi
    fi
    case $c in
        g) LBUFFER+='git '   ;;
        e) LBUFFER+='echo '  ;;
        m) LBUFFER+='mkdir ' ;;
        # show current git branch
        c) LBUFFER+=`_current_branch` ;;
        # show main git branch
        p) LBUFFER+=`_default_branch` ;;
        # merge-base between current branch and master
        b) LBUFFER+=$(git merge-base `_current_branch` `_default_branch` | head -c8) ;;
        u) LBUFFER+='ifsmirnov' ;;
        *)
            which _eval_yandex_esc_l_binding >/dev/null && {
                _eval_yandex_esc_l_binding $c
            }
            ;;
    esac
}

zle -N run

bindkey '\el' 'run'

function maxdepth() {
    t=$BUFFER
    LBUFFER=`python ~/maxdepth.py "$t" l`
    RBUFFER=`python ~/maxdepth.py "$t" r`
}

zle -N maxdepth

bindkey '\ek' 'maxdepth'

# function zle-line-pre-redraw() {
#     # print $region_highlight
#     # echo
#     # region_highlight+=("10 20 bg=yellow")
#     # region_highlight+=("15 25 bold")
#     # echo $region_highlight
# }
#
# zle -N zle-line-pre-redraw

# function zle-line-finish() {
#     echo 123
# }
#
# zle -N zle-line-finish
#
# function zle-line-finish() {
#     echo 456
# }

# PREV_NAME=${widgets[zle-line-finish]}

# zle -N zle-line-finish f1
# zle -A f1 f4
# zle -N zle-line-finish f2

# zle -N save-zle-line-finish ${PREV_NAME#*:}
# function helper() {
#     zle save-zle-line-finish
#     # echo helper
# }
# zle -N zle-line-finish helper


function append_widget() {
    widget="$1"
    name="$2"
    [[ -n "$widget" ]] || { echo Empty widget; return 1 }
    [[ -n "$name" ]] || { echo Empty name; return 1 }
    prev_name="${widgets[$widget]}"
    if [[ -n "$prev_name" ]]; then
        PREFIX="r${RANDOM}_s${SECONDS}"
        prev_name="${prev_name#*:}"
        echo "replacing '$prev_name'"
        zle -N orig_${PREFIX}_${prev_name} $prev_name
        eval "
        function helper_${PREFIX}_${prev_name}() {
            zle orig_${PREFIX}_${prev_name} $prev_name
            $name
        }
        "
        zle -N $widget helper_${PREFIX}_${prev_name}
    else
        zle -N $widget $name
        echo "creating new"
    fi
}

function example() {
    tmp="$LBUFFER"
    LBUFFER="$RBUFFER"
    RBUFFER="$tmp"
    PREDISPLAY='[hel]\n'
}

# эта строчка регистрирует функцию как виджет
zle -N example
bindkey '^E' 'example'

