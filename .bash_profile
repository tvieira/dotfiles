# Enable XON/XOFF flow control (that is, Ctrl-S/Ctrl-Q). May be negated.
stty -ixon

# Unset the time consuming "not found" error message
export TERM=xterm-256color
unset command_not_found_handle

export HISTCONTROL=erasedups
export HISTIGNORE="$HISTIGNORE:ls:ll:la:cd"
export HISTIGNORE="$HISTIGNORE:git dc:git st"
export HISTIGNORE="$HISTIGNORE:python"
export HISTSIZE=-1
export HISTFILESIZE=100000
export GLOBIGNORE=.:..

# Vagrant default provider
export VAGRANT_DEFAULT_PROVIDER=virtualbox

# Virtualenv and virtualenv wrapper
export VIRTUALENV_PYTHON="/usr/bin/python2.7"
export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python2.7"
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS="--no-site-packages"
export WORKON_HOME="$HOME/.virtualenvs"

# Use libvirt as default provider for Vagrant
export VAGRANT_DEFAULT_PROVIDER='libvirt'

# default editor
export EDITOR="vim"
export GIT_EDITOR=vim

# pip should only run if there is a virtualenv curently activated
# see .bash_functions on how to install global python packages via
# function gpip2 and gpip3.
export PIP_REQUIRE_VIRTUALENV=true

# get rid of those .pyc files once and for all
export PYTHONDONTWRITEBYTECODE=1
export IGNOREEOF=1

# taskwarrior config place
export TASKRC="$HOME/.taskrc"
export TASKDATA="$HOME/.task/data"

# Locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

PATH="$HOME/Projects/oc-cluster-wrapper:$HOME/.npm-global/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH"

# colorize my bash
eval "$(dircolors -b ~/.dir_colors)"

[[ -f "$HOME/.bash_aliases" ]] && source "$HOME/.bash_aliases"
[[ -f "$HOME/.bash_functions" ]] && source "$HOME/.bash_functions"
[[ -f "$HOME/.bash_prompt" ]] && source "$HOME/.bash_prompt"

# Adjust path
[[ -d "$HOME/.scripts" ]] && export PATH=$HOME/.scripts:$PATH

# Assuming you installed virtualenv via pip --user
[[ -f "$HOME/.local/bin/virtualenvwrapper.sh" ]] && $HOME/.local/bin/virtualenvwrapper.sh

# setting up GOPATH and point PATH to Go binaries
export GOPATH="$HOME/Projects/go"
export PATH="$PATH:$GOPATH/bin"
