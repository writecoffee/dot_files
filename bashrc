#
# ~/.bashrc
#
# This is the initialization file for bash, and is read each time an instance of
# your shell executes. A shell starts up, for example, when you open a new xterm
# window, remotely log on to another machine, or type 'bash' or 'sh' to start a
# new shell explicitly.
#
# Refer to bash(1) for more information.
#
# The shell treats lines beginning with # as comments.
#
# EDIT THIS FILE to customize *only* shell-specific options for bash (e.g.
# prompt). All other shell options go in ~/.environment.
#

# Define the shell-independent environment commands. See hooks(7) for more
# information.
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

# Run the coursehooks.
sourcefile /u/system/hooks/sh/simple-hooks

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

alias rmglock='rm -f /home/silao_xu/.config/google-chrome/SingletonLock'
alias gant='~/ganttproject/ganttproject &'
alias g='google-chrome'
alias e='eclipse'
alias t='texmacs'
alias cs='cscope -Rb ; ctags -R'
alias windows='rdesktop -g 1200*1600 -d cs rdesktop.cs.brown.edu '
alias ss='gnome-screenshot --interactive'
alias xm='cd ~/xmind2012/XMind_Linux/; ./XMind & 1>/dev/null 2>/dev/null'
alias xm64='cd ~/xmind2012/XMind_Linux_64bit/; ./XMind &'
alias ast='~/myscript/astyle'

# Set the prompt.
PS1="\[`tput rev`\]\h\[`tput sgr0`\] \w \$ ";

