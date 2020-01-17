#! /bin/bash

## DO NOT RECORD THESE OPERATIONS TO HISTORY
#-------------------------------------------------
set +o history

## ENVIRONMENT
#-------------------------------------------------
shopt -s cdable_vars
shopt -s cdspell
shopt -s checkhash
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -u execfail
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -u histreedit
shopt -u histverify
shopt -s hostcomplete
shopt -u huponexit
shopt -s interactive_comments
shopt -s lithist
shopt -u mailwarn
shopt -u no_empty_cmd_completion
shopt -u nocaseglob
shopt -u nullglob
shopt -u progcomp
shopt -u promptvars
shopt -u shift_verbose
shopt -u sourcepath
shopt -u xpg_echo
set -o allexport
set -o braceexpand
unset -v emacs
unset -v errexit
set -o hashall
unset -v histexpand
set -o ignoreeof
unset -v keyword
set -o monitor
set +o noclobber
unset -v noglob
set -o notify
unset -v nounset
unset -v onecmd
set -o physical
set +o posix
unset -v privileged
unset -v verbose
unset -v vi
unset -v xtrace
export SHELL=/bin/bash
export EDITOR=vim
export VISUAL=vim
export HISTCONTROL=ignoredups
export HISTFILE=~/.bash_history
export HISTFILESIZE=100000
export HISTSIZE=10000
export PAGER=less
export PROMPT_COMMAND=prompt_command
export CLICOLOR=1
#export LC_ALL=C # required for fast Unix sort
export LC_ALL='en_US.UTF-8' # required for correct Unicode display
umask 066


## PATHS
#-------------------------------------------------
export PATH=/bin/
export PATH=$PATH:/sbin/
export PATH=$PATH:/usr/bin/
export PATH=$PATH:/usr/sbin/
#export PATH=$PATH:/usr/local/bin
#export PATH=$PATH:/usr/local/sbin


## MANPATHS
#-------------------------------------------------
export MANPATH=


## INFOPATHS
#-------------------------------------------------
export INFOPATH=


## ALIASES
#-------------------------------------------------
alias view="vim -R"


## FUNCTIONS
#-------------------------------------------------
function preexec() {
	if [ -z "$AT_PROMPT" ] ; then
		return
	fi
	unset AT_PROMPT
	export timer_start=$SECONDS;
}
trap "preexec" DEBUG

export FIRST_PROMPT=1
function postexec() {
	export AT_PROMPT=1
	if [ -n "$FIRST_PROMPT" ] ; then
		unset FIRST_PROMPT
		export timer_start=$SECONDS
		return
	fi
}

function prompt_command {
	exit_status=$?
	i_am=$(whoami)
	postexec
	elapsed=$(($SECONDS-$timer_start))
	echo ""
	jobCount=$(jobs | wc -l | tr -d " ")
	procCount=$(($(ps -ef | grep -w $i_am | wc -l | tr -d " ")-1))
	promptSize=$(echo -n "Shell: bash v${BASH_VERSINFO[0]}.${BASH_VERSINFO[1]}.${BASH_VERSINFO[2]} - Jobs: ${jobCount} - Processes: ${procCount}Exit Status: $exit_status - Elapsed: ${elapsed}s - Date: Sun Jan 01 - Time: HH:MM:SS" | wc -c | tr -d " ")
	if test "$COLUMNS" = "" ; then
		export COLUMNS=80;
	fi
	fill=$(printf ' %.0s' $(seq 1 $(($COLUMNS-$promptSize))))
	PS1="${BG_BLACK}";
	PS1="${PS1}${FG_GREEN}Shell: bash v\V";
	PS1="${PS1}${FG_GRAY} - ";
	PS1="${PS1}${FG_GREEN}Jobs: ${jobCount}";
	PS1="${PS1}${FG_GRAY} - ";
	PS1="${PS1}${FG_GREEN}Processes: ${procCount}";
	PS1="${PS1}${FG_GRAY}${fill}";
	PS1="${PS1}${FG_GREEN}Exit Status: $exit_status";
	PS1="${PS1}${FG_GRAY} - ";
	PS1="${PS1}${FG_GREEN}Elapsed: ${elapsed}s";
	PS1="${PS1}${FG_GRAY} - ";
	PS1="${PS1}${FG_GREEN}Date: \d";
	PS1="${PS1}${FG_GRAY} - ";
	PS1="${PS1}${FG_GREEN}Time: \t";
	PS1="${PS1}\n";
	PS1="${PS1}${FG_LIGHT_GRAY}[";
	if test $i_am == "root" ; then
		PS1="${PS1}${BG_RED}${FG_WHITE}\u"
	else
		PS1="${PS1}${FG_LIGHT_BLUE}\u"
	fi
	PS1="${PS1}${FG_LIGHT_GRAY}@";
	PS1="${PS1}${FG_LIGHT_BLUE}\h";
	PS1="${PS1}${FG_LIGHT_GRAY}:";
	PS1="${PS1}${FG_RED}\w";
	PS1="${PS1}${FG_LIGHT_GRAY}]>";
	PS1="${PS1}${FG_LIGHT_GRAY} ";
	export PS1
}

function index_of {
	if [ $# -ne 1 ] ; then
		printf "required argument: <colname>\n" >&2
		return 1
	fi
	colname="$1"
	head -n 1 | awk -v "colname=$colname" '{for(i=1;i<=NF;++i){if($i==colname){print i;exit 0;}}exit 1;}'
}

function random {
	if [ $# -ne 3 ] ; then
		printf "required arguments: <seed> <lower bound (inclusive)> <upper bound (inclusive)>\n" >&2
		return 1
	fi
	seed=$1
	lower=$2
	upper=$(($3+1-$2))
	perl -e "srand($seed); print int(rand($upper))+$lower;"
}


## COLORS
#-------------------------------------------------
FG_BLACK="\[\033[0;30m\]";
FG_RED="\[\033[0;31m\]";
FG_GREEN="\[\033[0;32m\]";
FG_BROWN="\[\033[0;33m\]";
FG_BLUE="\[\033[0;34m\]";
FG_PURPLE="\[\033[0;35m\]";
FG_CYAN="\[\033[0;36m\]";
FG_LIGHT_GRAY="\[\033[0;37m\]";
FG_GRAY="\[\033[1;30m\]";
FG_LIGHT_RED="\[\033[1;31m\]";
FG_LIGHT_GREEN="\[\033[1;32m\]";
FG_YELLOW="\[\033[1;33m\]";
FG_LIGHT_BLUE="\[\033[1;34m\]";
FG_LIGHT_PURPLE="\[\033[1;35m\]";
FG_LIGHT_CYAN="\[\033[1;36m\]";
FG_WHITE="\[\033[1;37m\]";
BG_BLACK="\[\033[0;40m\]";
BG_RED="\[\033[0;41m\]";
BG_GREEN="\[\033[0;42m\]";
BG_BROWN="\[\033[0;43m\]";
BG_BLUE="\[\033[0;44m\]";
BG_PURPLE="\[\033[0;45m\]";
BG_CYAN="\[\033[0;46m\]";
BG_LIGHT_GRAY="\[\033[0;47m\]";
BG_GRAY="\[\033[1;40m\]";
BG_LIGHT_RED="\[\033[1;41m\]";
BG_LIGHT_GREEN="\[\033[1;42m\]";
BG_YELLOW="\[\033[1;43m\]";
BG_LIGHT_BLUE="\[\033[1;44m\]";
BG_LIGHT_PURPLE="\[\033[1;45m\]";
BG_LIGHT_CYAN="\[\033[1;46m\]";
BG_WHITE="\[\033[1;47m\]";


## ENVIRONMENT-SPECIFIC DEFINITIONS
#-------------------------------------------------


## RESUME NORMAL HISTORY RECORDING
#-------------------------------------------------
set -o history

