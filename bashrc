setenvvar () { eval $1=\"$2\"; export $1; }
setenvifnot () { if eval [ -z \"\$$1\" ]; then eval $1=\"$2\"; export $1; fi; }
pathappend () { if eval expr ":\$$1::" : ".*:$2:.*" >/dev/null 2>&1; then true; else eval $1=\$$1:$2; fi; }
pathappendifdir () { if [ -d "$2" ]; then pathappend $*; fi; }
pathprepend () { if eval expr ":\$$1::" : ".*:$2:.*" >/dev/null 2>&1; then true; else eval $1=$2:\$$1; fi; }
pathprependifdir () { if [ -d "$2" ]; then pathprepend $*; fi; }
shellcmd () { _cmd=$1; shift; eval "$_cmd () { command $* \"\$@\"; }"; }
sourcefile () { if [ -f "$1" ]; then . $1; fi; }

# Load personal environment settings.
sourcefile $HOME/.environment

# If this is a non-interactive shell, exit. The rest of this file is loaded
# only for interactive shells.
if [ -z "$PS1" ]; then
     return
fi

# Set tty options.
stty sane

# Set the shell to exit when you press Control-D three times and to prevent
# programs from dumping core.
IGNOREEOF=0
ulimit -Sc 0

alias g='google-chrome'
alias e='eclipse-luna'
alias t='texmacs'
alias ss='gnome-screenshot --interactive'
alias xm='cd ~/xmind2012/XMind_Linux/; ./XMind & 1>/dev/null 2>/dev/null'
alias xm64='cd ~/xmind2012/XMind_Linux_64bit/; ./XMind &'

# Set the prompt.
PS1="\[`tput rev`\]\h\[`tput sgr0`\] \w \$ ";

red='\e[0;31m'
purple='\e[0;35m'
brown='\e[0;33m'
nocolor='\e[0m'
lightblue='\e[1;34m'
lightgreen='\e[1;32m'

logger () 
{
    time=`TZ="US/Pacific"  date +"%Y-%m-%d %T"`;
    echo -e "${lightgreen}[$time]${nocolor} $*"
}

logger_remove () 
{
    time=`TZ="US/Pacific"  date +"%Y-%m-%d %T"`;
    echo -e "${lightgreen}[$time]${nocolor} ${red}$1${nocolor} => $2"
}

# Replace the original /bin/rm command. Move the target files to trash bin, then
# manage all trash files at your leisure.
# 
# Logs are put in file /var/log/trash.log .
# 
# Files moved to the trash bin are renamed automatically.
#
rm () 
{ 
    local limit=50;
    if [ -d $HOME/.local/share/Trash/files ]; then
        trash="$HOME/.local/share/Trash/files";
    else
        trash="$HOME/.Trash";
    fi;
    local log="/var/log/trash.log";
    while [[ ! -z "$1" ]]; do
        if [[ ! -d "$1" ]]; then
            if [[ ! -f "$1" ]]; then
                shift;
                continue;
            fi;
        fi;
        full=`readlink -f "$1"`;
        base=`basename "$full"`;
        if [[ -n ` echo "$base" |grep "\." ` ]]; then
            new=`echo "$base" |sed -e "s/\([^.]*$\)/$RANDOM.\1/" `;
        else
            new="$base.$RANDOM";
        fi;
        trash_file="$trash/$new";
        local fs=`du -BM -s "$full" |awk -FM '{print $1}'`;
        if [ "$fs" -gt "$limit" ]; then
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
        fi;
        mv "$full" "$trash_file";
        if [ $? -eq 0 ]; then
            if [ -w "$log" ]; then
                logger_remove "$full" "[$trash_file]" | tee -a "$log";
            else
                logger_remove "$full" "[$trash_file]";
            fi;
        else
            logger "Error deleting $full";
        fi;
        shift;
    done
}
