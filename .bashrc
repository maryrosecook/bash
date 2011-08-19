# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

# if cur username is maryrosecook, rewrite to mrc for prompt string
prompt_username=`id -nu`
if [[ "${prompt_username}" = "maryrosecook" ]]; then
    prompt_username='mrc'
fi

# set prompt
PS1='${prompt_username}@\h:\w $ '

# Make bash check its window size after a process completes
shopt -s checkwinsize

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# aliases
alias ls='ls -l'
alias be='bundle exec'

# gem open
export GEM_EDITOR='mate'

export NODE_PATH="/usr/local/lib/node"

export CC=gcc-4.2