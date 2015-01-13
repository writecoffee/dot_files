###############################################################################
# This is Tsu's (writecoffee) bash setup script.
#
# Belows are Fundamental routines required for loading .environment .
#

is_mac () {

    [ "$OSTYPE" == "darwin13" ];
}

is_linux () {
    [ "$OSTYPE" == "linux-gnu" ];
}

setenvvar () {
    eval $1=\"$2\";
    export $1;
}

setenvifnot () {
    if eval [ -z \"\$$1\" ]; then
         eval $1=\"$2\";
         export $1;
    fi;
}

pathappend () {
    if eval expr ":\$$1::" : ".*:$2:.*" >/dev/null 2>&1;
        then true;
    else
        eval $1=\$$1:$2;
    fi;
}

pathappendifdir () {
    if [ -d "$2" ];
         then pathappend $*;
    fi;
}

pathprepend () {
    if eval expr ":\$$1::" : ".*:$2:.*" >/dev/null 2>&1;
        then true;
    else
        eval $1=$2:\$$1;
    fi;
}

pathprependifdir () {
    if [ -d "$2" ];
        then pathprepend $*;
    fi;
}

shellcmd () {
    _cmd=$1;
    shift;
    eval "$_cmd () { command $* \"\$@\"; }";
}

sourcefile () {
    if [ -f "$1" ];
        then . $1;
    fi;
}

sourcefile $HOME/.environment
source $HOME/.git-prompt.sh

# -----------------------------------------------------------------------------
# Basic and misc setup:
#
# 1) If this is a non-interactive shell, exit. The rest of this file is loaded
#    only for interactive shells.
#
# 2) Set tty options.
#
# 3) Set the shell to exit when you press Control-D three times and to prevent
#    programs from dumping core.
#
if [ -z "$PS1" ]; then
     return
fi

stty sane
IGNOREEOF=0
ulimit -Sc 0

alias g='google-chrome'
alias e='eclipse-luna'
alias t='texmacs'
alias ss='gnome-screenshot --interactive'
alias em='emacs'

red='\e[0;31m'
purple='\e[0;35m'
brown='\e[0;33m'
nocolor='\e[0m'
lightblue='\e[1;34m'
lightgreen='\e[1;32m'

# Reset
_Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
_Black="\[\033[0;30m\]"        # Black
_Red="\[\033[0;31m\]"          # Red
_Green="\[\033[0;32m\]"        # Green
_Yellow="\[\033[0;33m\]"       # Yellow
_Blue="\[\033[0;34m\]"         # Blue
_Purple="\[\033[0;35m\]"       # Purple
_Cyan="\[\033[0;36m\]"         # Cyan
_White="\[\033[0;37m\]"        # White

# Bold
_BBlack="\[\033[1;30m\]"       # Black
_BRed="\[\033[1;31m\]"         # Red
_BGreen="\[\033[1;32m\]"       # Green
_BYellow="\[\033[1;33m\]"      # Yellow
_BBlue="\[\033[1;34m\]"        # Blue
_BPurple="\[\033[1;35m\]"      # Purple
_BCyan="\[\033[1;36m\]"        # Cyan
_BWhite="\[\033[1;37m\]"       # White

# Underline
_UBlack="\[\033[4;30m\]"       # Black
_URed="\[\033[4;31m\]"         # Red
_UGreen="\[\033[4;32m\]"       # Green
_UYellow="\[\033[4;33m\]"      # Yellow
_UBlue="\[\033[4;34m\]"        # Blue
_UPurple="\[\033[4;35m\]"      # Purple
_UCyan="\[\033[4;36m\]"        # Cyan
_UWhite="\[\033[4;37m\]"       # White

# Background
_On_Black="\[\033[40m\]"       # Black
_On_Red="\[\033[41m\]"         # Red
_On_Green="\[\033[42m\]"       # Green
_On_Yellow="\[\033[43m\]"      # Yellow
_On_Blue="\[\033[44m\]"        # Blue
_On_Purple="\[\033[45m\]"      # Purple
_On_Cyan="\[\033[46m\]"        # Cyan
_On_White="\[\033[47m\]"       # White

# High Intensty
_IBlack="\[\033[0;90m\]"       # Black
_IRed="\[\033[0;91m\]"         # Red
_IGreen="\[\033[0;92m\]"       # Green
_IYellow="\[\033[0;93m\]"      # Yellow
_IBlue="\[\033[0;94m\]"        # Blue
_IPurple="\[\033[0;95m\]"      # Purple
_ICyan="\[\033[0;96m\]"        # Cyan
_IWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
_BIBlack="\[\033[1;90m\]"      # Black
_BIRed="\[\033[1;91m\]"        # Red
_BIGreen="\[\033[1;92m\]"      # Green
_BIYellow="\[\033[1;93m\]"     # Yellow
_BIBlue="\[\033[1;94m\]"       # Blue
_BIPurple="\[\033[1;95m\]"     # Purple
_BICyan="\[\033[1;96m\]"       # Cyan
_BIWhite="\[\033[1;97m\]"      # White

# High Intensty backgrounds
_On_IBlack="\[\033[0;100m\]"   # Black
_On_IRed="\[\033[0;101m\]"     # Red
_On_IGreen="\[\033[0;102m\]"   # Green
_On_IYellow="\[\033[0;103m\]"  # Yellow
_On_IBlue="\[\033[0;104m\]"    # Blue
_On_IPurple="\[\033[10;95m\]"  # Purple
_On_ICyan="\[\033[0;106m\]"    # Cyan
_On_IWhite="\[\033[0;107m\]"   # White

# Various variables you might want for your PS1 prompt instead
_Date="\d"
_Time12h="\T"
_Time12a="\@"
_PathShort="\w"
_PathFull="\W"
_NewLine="\n"
_Jobs="\j"

__to_bash_color_ () {
    local color=`echo $1 | grep -Eo "\[\d;\d+m"`;
    echo "\\e${color}";
}

# -----------------------------------------------------------------------------
# Prompt:
#
# [TIME] {BRANCH} CURRENT_DIRECTORY $
#
export GIT_PS_SHOWDIRTYSTATE=1;
export PS1=$IBlack$Time12h$Color_Off'\
$(git branch &>/dev/null;\
    if [ $? -eq 0 ]; then \
        echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \

        if [ "$?" -eq "0" ]; then \
            echo "['$_Blue''$_Time12a', '$_Date'] '$_Green'"$(__git_ps1 "(%s)"); \
        else \
            echo "['$_Blue''$_Time12a', '$_Date'] '$_IRed'"$(__git_ps1 "{%s}"); \
        fi) '$_BIPurple$_PathShort$_Color_Off' \$ "; \

    else \
        echo " '$_BIPurple$_PathShort$_Color_Off' \$ "; \
    fi)'

###############################################################################
# readlink:
# 
# Vanilla wrapper function which simulates GNU "readlink -f".
#
# 1. It iterates along a sequence of symlinks until it finds an actual file.
# 2. It returns that file's canonicalized name, i.e., its absolute path name.
#
#
readlink () {
    if is_mac; then {
        target=$2;

        cd `dirname $target`;
        target=`basename $target`;

        while [ -L "$target" ]; do {
            target=`readlink $target`;
            cd `dirname $target`;
            target=`basename $target`;
        } done;

        physical_dir=`pwd -P`;
        result=$physical_dir/$target;
        echo $result;
    } else {
        /usr/bin/readlink;
    } fi;
}

logger () {
    time=`TZ="US/Pacific"  date +"%Y-%m-%d %T"`;
    printf "${lightblue}[$time]${nocolor} $*\n"
}

logger_remove () {
    time=`TZ="US/Pacific"  date +"%Y-%m-%d %T"`;
    printf "${lightblue}[$time]${nocolor} ${red}$1${nocolor} => $2\n"
}

###############################################################################
# rm:
# 
# Replace the original /bin/rm command. Move the target files to trash bin,
# then manage all trash files at your leisure.
#
# Logs are put in file /var/log/trash.log .
#
# Files moved to the trash bin are renamed automatically.
#
rm ()
{ 
    local limit=50;
    local log="/var/log/trash.log";

    if [ -d $HOME/.local/share/Trash/files ]; then {
        trash="$HOME/.local/share/Trash/files";
    } else {
        trash="$HOME/.Trash";
    } fi;

    while [[ ! -z "$1" ]]; do {
        if [[ ! -d "$1" ]]; then {
            if [[ ! -f "$1" ]]; then {
                shift;
                continue;
            } fi;
        } fi;

        full=`readlink -f "$1"`;
        base=`basename "$1"`;
        if [[ -n ` echo "$base" |grep "\." ` ]]; then {
            new=`echo "$base" |sed -e "s/\([^.]*$\)/$RANDOM.\1/" `;
        } else {
            new="$base.$RANDOM";
        } fi;

        trash_file="$trash/$new";
        local fs=`du -m -s "$full" | grep -Eo "^\d+"`;
        if [ "$fs" -gt "$limit" ]; then {
            read -p "File/Folder is ${fs}Mb, too large. rm it permanently? [Y/n]" answer;

            case "$answer" in
            "Y" | "" | "y") {
                /bin/rm -rv "$full";
                logger "'$full' removed permanently"
            } ;;
            *) {
                logger "aborted from deleting $full"
            } ;;
            esac;
            shift;
            continue;
        } fi;

        mv "$full" "$trash_file";

        if [ $? -eq 0 ]; then {
            if [ -w "$log" ]; then {
                logger_remove "$full" "[$trash_file]" | tee -a "$log";
            } else {
                logger_remove "$full" "[$trash_file]";
            } fi;
        } else {
            logger "Error deleting $full";
        } fi;

        shift;
    } done
}

tmux_init()
{
    tmux new-session -s "dev" -d -n "turn"
    tmux new-window -n "misc"
    tmux split-window -h
    tmux -2 attach-session -d
}

if which tmux 2>&1 >/dev/null; then
test -z "$TMUX" && (tmux attach || tmux_init)
fi

