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

# -----------------------------------------------------------------------------
# Prompt:
#
# [USER_NAME]::[HOST_NAME] {CURRENT_DIRECTORY} $
#
PS1='\[\033[01;32m\]\u\[\033[01;34m\]::\[\033[01;31m\]\h \[\033[00;34m\]{ \[\033[01;34m\]\w \[\033[00;34m\]}\[\033[01;32m\] $ \[\033[00m\]';

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
        _target=$2;

        cd `dirname $_target`;
        _target=`basename $_target`;

        while [ -L "$_target" ]; do
            _target=`readlink $_target`;
        cd `dirname $_target`;
        _target=`basename $_target`;
        done;

        _physic_dir=`pwd -P`;
        _result=$_physic_dir/$_target;
        echo $_result;
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
                "Y" | "" | "y")
                    /bin/rm -rv "$full";
                    logger "'$full' removed permanently"
                ;;
                *)
                    logger "aborted from deleting $full"
                ;;
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

