# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

############# handy functions

# start quick python server and open webpage, passing optional port
function serve() {
    if [ $# -ne 1 ]; then
      let port=8000+0
    else
      let port=$@
    fi

    open http://localhost:$port && python -m SimpleHTTPServer "$port";
}

# do interactive git rebase at passed revision index
function gr() {
    let revisionIndex=$@
    git rebase -i HEAD~$revisionIndex;
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

# add node and lein to path
export PATH=$HOME/local/bin:$PATH
export NODE_PATH="/Users/maryrosecook/local/bin"

# gem open
export GEM_EDITOR='mate'
export EDITOR='mate'

export CC=gcc-4.2

# rename tabs/windows in OS X Terminal.app
function tn {
  printf "\e]1;$1\a"
}

# add clojure to classpath
export CLASSPATH="$CLASSPATH:$HOME/.lein/self-installs/leiningen-VERSION-standalone.jar"

# The following aliases (save & show) are for saving frequently used directories
# You can save a directory using an abbreviation of your choosing. Eg. save ms
# You can subsequently move to one of the saved directories by using cd with
# the abbreviation you chose. Eg. cd ms  (Note that no '$' is necessary.)
alias sdirs='source ~/.dirs'
alias show='cat ~/.dirs'
save () { /usr/bin/sed "/$@/d" ~/.dirs > ~/.dirs1; \mv ~/.dirs1 ~/.dirs; echo "$@"=\"`pwd`\" >> ~/.dirs; source ~/.dirs ; }

# Initialization for the above 'save' facility:
# source the .sdirs file:
sdirs
# set the bash option so that no '$' is required when using the above facility
shopt -s cdable_vars