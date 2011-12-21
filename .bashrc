# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

# if cur username is maryrosecook, rewrite to mrc for prompt string
prompt_username=`id -nu`
if [[ "${prompt_username}" = "maryrosecook" ]]; then
   prompt_username='mrc'
fi

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

# add node to path
export PATH=$HOME/local/bin:$PATH

# gem open
export GEM_EDITOR='mate'
export EDITOR='mate'

export NODE_PATH="/Users/maryrosecook/local/bin"

export CC=gcc-4.2

# set prompt
PS1='${prompt_username}@mrc:\w $ '

# terminal colours
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad