# Set up the prompt

# autoload -Uz promptinit
# promptinit
#prompt adam2
#PROMPT='%~%#=> '
PROMPT="%B%F{cyan}.%b%F{cyan}-%B%F{black}(%B%F{green}%~%B%F{black})%b%F{cyan}-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------%B%F{black}(%b%F{cyan}%n%B%F{cyan}@%b%F{cyan}%m%B%F{black})%b%F{cyan}->"
PROMPT2="> "
# PROMPT2="%i%u > "
# PROMPT2="%{$fg[red]%}\ %{$reset_color%}"
# PROMPT2="%{$fg[$CARETCOLOR]%}◀%{$reset_color%} "
RPROMPT=" %T %y%b"

# PROMPT="%B%F{red}%n%f@%F{blue}%m %b%F{yellow}%1~ %f%# "
PROMPT="
%b%F{yellow}┌%B%F{red}%n%f@%F{blue}%m %b%F{yellow}%1~
└%f%# "
# RPROMPT='[%{$fg_no_bold[green]%}%?%{$reset_color%}]'
# RPROMPT="[%b%F{yellow}%?%f] %*"
# RPROMPT="[%b%F{yellow}%?%f]"
RPROMPT=""

# preexec() { date }

# TRAPALRM() {
#     zle reset-prompt # ломает  zstyle ':completion:*' menu select
# }
# TMOUT=1

# Обычные цвета
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Жирные
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

Color_Off='\e[0m'

preexec () {
  LAST_CMD=$1
  LAST=$?
  # LAST_START=$(( $(date +"%N") * 1e-9 + $(date +"%s") ))
  LAST_START=$(date +"%s.%N")
  DATE=`date +"%Y-%m-%d %H:%M:%S"`
  C=$(($COLUMNS-27))
  echo -e "\033[2A\033[${C}C ${Cyan}start: ${Yellow}${DATE}${Color_Off}\n"

}

precmd () { #postexec
  LAST=$?
  # echo -e "\n\n\n$LAST_CMD\n\n\n"
  if [ "0$LAST_CMD" != "0" ] ; then
    C=$(($COLUMNS - 24))
    echo -ne "$Cyan"  # cyan
    echo "\033[${C}Cend: ${Yellow}$(date +"%Y-%m-%d %H:%M:%S")\033[1A"
    # local LAST_END=$(( $(date +"%N") * 1e-9 + $(date +"%s") ))
    local LAST_END=$(date +"%s.%N")
    # local CMD="%B%F{red}${LAST_CMD}%f"
    local CMD="${LAST_CMD}"
#    if [ "0$LAST" = "00" ] ; then
#      printf "Executed [${BCyan}%s${Yellow}: ${BGreen}${LAST}${Yellow}] in ${BYellow} %.5f ${Yellow} sec\n${Cyan}" $LAST_CMD $(( $LAST_END - $LAST_START ))
#    else
#      printf "Executed [${BCyan}%s${Yellow}: ${BRed}${LAST}${Yellow}] in ${BYellow} %.5f ${Yellow} sec\n${Cyan}" $LAST_CMD $(( $LAST_END - $LAST_START ))
#    fi
    printf '%*s\n' $COLUMNS|sed 's/\ /-/g'
    echo -ne "\033[0m"   # normal

  fi
  unset LAST_END
  unset CMD
  unset LAST_CMD
}



setopt histignorealldups sharehistory prompt_subst

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
#HISTFILE=~/.zsh_history
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' rehash true
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select
setopt completealiases

# Ctrl+ Up/Down  to search in history
zle
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

bindkey "^[[1;5A" history-beginning-search-backward
bindkey "^[[1;5B" history-beginning-search-forward

#from .bashcr
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
#alias l='ls -CF'
# alias less='/usr/share/vim/vim74/macros/less.sh'
# alias less='/usr/share/vim/vim73/macros/less.sh'

if ( ls /usr/share/vim/vim??/macros/less.sh > /dev/null 2>&1 ) ; then
  alias lessc='/usr/share/vim/vim??/macros/less.sh'
fi

alias l=less

alias c='pygmentize -g'

alias ssh-rmate='ssh -R 52698:127.0.0.1:52698'
alias sudo-i='sudo -E zsh'

if [[ -s '/etc/zsh_command_not_found' ]]; then
  source '/etc/zsh_command_not_found'
fi

PATH=$PATH:$HOME/.rvm/bin:$HOME/bin # Add RVM to PATH for scripting
login2gentoo(){cd ~/unsafe_trash; sudo ./mount.sh}
av(){

  type deactivate >/dev/null && deactivate

  [ -d .env ] && source .env/bin/activate
  [ -d env ] && source env/bin/activate

}

dlogs(){
  if [ "$2" != "" ]; then
    docker logs -f --tail=$2 $1
  else
    docker logs -f --tail=200 $1
  fi
}

if [ -f /usr/bin/grc ]; then
 alias c="grc --colour=auto"
 alias gcc="grc --colour=auto gcc"
 # alias irclog="grc --colour=auto irclog"
 # alias log="grc --colour=auto log"
 alias netstat="grc --colour=auto netstat"
 alias ping="grc --colour=auto ping"
 # alias proftpd="grc --colour=auto proftpd"
 alias traceroute="grc --colour=auto traceroute"
fi

greppy(){
  grep --include='*.py' $*
}

grepjs(){
  grep --color --include='*.js' $*
}

avv(){
  PAGER="rmate -w" ansible-vault view $*
}

ave(){
  EDITOR="rmate -w" ansible-vault edit $*
}

rmate(){
  if [ ! -x ~/bin/rmate ] ; then
    URL="https://raw.github.com/aurora/rmate/master/rmate"
    wget --quiet -O - "${URL}" | (umask 077; test -d ~/bin || mkdir -p ~/bin; cat > ~/bin/rmate; chmod a+rx ~/bin/rmate) || exit 1
    sudo sh -c 'test -d /usr/local/bin || mkdir -p /usr/local/bin; cp ~/bin/rmate /usr/local/bin/rmate; chmod a+rx /usr/local/bin/rmate'
    ~/bin/rmate $*
  else
    ~/bin/rmate $*
  fi
}
RMATE_PORT=52699

#rename tab in terminator
n(){
  echo -en "\e]2;$*\a"
}

export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

ds(){
  while true; do TEXT=$(docker stats --no-stream $(docker ps --format={{.Names}})); sleep 0.1; clear; echo "$TEXT"; done
}


autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}
RPROMPT=$'$(vcs_info_wrapper)'
