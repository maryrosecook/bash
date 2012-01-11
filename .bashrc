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

# put bash_completion script file in /etc, add bash_completion.d folder
# and put completion scripts into it


[ -z "$BASH_VERSION" -o -n "$BASH_COMPLETION" ] && return

# Check for recent enough version of bash.
bash=${BASH_VERSION%.*}; bmajor=${bash%.*}; bminor=${bash#*.}

# Check for interactive shell.
if [ -n "$PS1" ]; then
  if [ $bmajor -eq 2 -a $bminor '>' 04 ] || [ $bmajor -gt 2 ]; then
    if [ -r /etc/bash_completion ]; then
      # Source completion code.
      . /etc/bash_completion
    fi
  fi
fi
unset bash bminor bmajor


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