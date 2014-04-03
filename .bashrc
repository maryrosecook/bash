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


# Quick way to rebuild the Launch Services database and get rid
# of duplicates in the Open With submenu.
alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'

PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"

# add python stuff to path
PATH="/usr/local/lib/python2.7/site-packages:$PATH"

# terminal colours
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

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
alias be='bundle exec'
alias gs='git status'
alias gl='git log --graph --pretty="format:%C(yellow)%h%Cblue%d%Creset %s %C(white)"'
alias lr='lein repl'
alias lt='lein test'
alias ltc='lein clean && lein test'
alias lrt='lein trampoline run'
alias rl='rlwrap'

# add node and lein to path
export PATH=$HOME/local/bin:$PATH
export NODE_PATH="/Users/maryrosecook/local/bin"

# gem open
export GEM_EDITOR='mate'
export EDITOR='mate'

# clojurescript
export CLOJURESCRIPT_HOME=$HOME/code/clojurescript
export PATH=$CLOJURESCRIPT_HOME/bin:$PATH # add to path

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


# copy pygmentized code to clipboard as rtf
#
# $ copyrtf code.py
# $ copyrtf code.py monokai
# $ copyrtf code.py monokai 24
alias hlcode='copyrtf'
copyrtf() {
  local STYLE
  local FONTSIZE
  if [[ -z $2 ]]; then
    STYLE="monokai"
  else
    STYLE=$2
  fi

  if [[ -z $3 ]]; then
    FONTSIZE=24
  else
    FONTSIZE=$3
  fi

  pygmentize -f rtf -O "style=$STYLE,fontface=Inconsolata" $1 |
    # font size (RTF font sizes are doubled)
    sed "s/\\\\f0/\\\\f0\\\\fs$(($FONTSIZE * 2))/g" |
    pbcopy
}
