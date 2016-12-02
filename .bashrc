# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# call bash_profile even when login from console
if [ -f ~/.bash_profile ]; then
   source ~/.bash_profile
fi
