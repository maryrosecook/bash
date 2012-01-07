# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

# start quick python server and open webpage, passing optional port
function serve() {
    if [ $# -ne 1 ]; then
      let port=8000+0
    else
      let port=$@
    fi

    open http://localhost:$port && python -m SimpleHTTPServer "$port" ;
}

# set prompt
PS1='mrc:\w $ '

# terminal colours
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# enable bash completion
if [ -f /etc/bash_completion ]; then
. /etc/bash_completion
fi

# Make bash check its window size after a process completes
shopt -s checkwinsize

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# aliases
alias ls='ls -l'
alias be='bundle exec'
alias gs='git status'
alias gl='git log'

# add node to path
export PATH=$HOME/local/bin:$PATH
export NODE_PATH="/Users/maryrosecook/local/bin"

# gem open
export GEM_EDITOR='mate'
export EDITOR='mate'

export CC=gcc-4.2