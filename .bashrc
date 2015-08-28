# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

# include bash file for private stuff (not checked in anywhere)
if [ -f ~/.bash_private ]; then
. ~/.bash_private
fi

######### prompt

if [ -f $(brew --prefix)/etc/bash_completion ]; then
   . $(brew --prefix)/etc/bash_completion
fi

# color codes
RESET="\[\033[0m\]"
BLUE="\[\033[34m\]"
YELLOW="\[\033[33m\]"
RED="\[\033[31m\]"
RED_BOLD="\[\033[1;31m\]"

# colorized and git-orized prompt
export PS1="$BLUE\w$YELLOW\$(__git_ps1) $RED_BOLD> $RESET"

############# handy functions

# start quick python server and open webpage, passing optional port
function serve() {
    if [ $# -ne 1 ]; then
      let port=4000+0
    else
      let port=$@
    fi

    python -m SimpleHTTPServer "$port";
}

# do interactive git rebase at passed revision index
function gr() {
    let revisionIndex=$@
    git rebase -i HEAD~$revisionIndex;
}

PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"

# terminal colours
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# set editor to emacs
export EDITOR=/Applications/Emacs.app

# use stuff in brew path over stuff in usr/bin
PATH=/usr/local/bin:$PATH

# add ~/bin to path
export PATH=$HOME/bin:$PATH

# v8 for clojurescript tests
export V8_HOME=$HOME/code/v8/out/x64.release

# Make bash check its window size after a process completes
shopt -s checkwinsize

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# aliases
alias ls='ls -l'
alias gs='git status'
alias gl='git log --graph --pretty="format:%C(yellow)%h%Cblue%d%Creset %s %C(white)"'
alias gc='git cat-file -p'
alias lr='lein repl'
alias rl='rlwrap'

# add node and lein to path
export PATH=$HOME/local/bin:$PATH
export NODE_PATH="/Users/maryrosecook/local/bin"

# clojurescript
export CLOJURESCRIPT_HOME=$HOME/code/clojurescript
export PATH=$CLOJURESCRIPT_HOME/bin:$PATH # add to path

# add clojure to classpath
export CLASSPATH="$CLASSPATH:$HOME/.lein/self-installs/leiningen-VERSION-standalone.jar"
