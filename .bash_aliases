# weather
alias weather="curl -4 http://wttr.in/westford "

# vi to vim
alias vi="vim"

# preconditions vim
alias vim="vim -c 'set spell spelllang=en' -c 'set nowritebackup'"

# color ls
alias ls='ls --color=auto -hF'

# display as a list, sorting by time modified
alias ll='ls -1t'

# display the insides of a particular directory
alias lv='ls -R'

# useful git aliases from TJ Holowaychuk
alias gd="git diff | subl"
alias ga="git add"
alias gbd="git branch -D"
alias gs="git status"
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gm="git merge --no-ff"
alias gpt="git push --tags"
alias gp="git push"
alias grh="git reset --hard"
alias gb="git branch"
alias gcob="git checkout -b"
alias gco="git checkout"
alias gba="git branch -a"
alias gcp="git cherry-pick"
alias gl="git log --pretty='format:%Cgreen%h%Creset %an - %s' --graph"
alias gpom="git pull --rebase origin master"
alias gcd='cd "`git rev-parse --show-toplevel`"'
alias gup="git remote add upstream"
alias gfa="git fetch --all"

# recursively delete `.pyc` files
alias pycleanup="find . -type f -name '*.pyc' -ls -delete"

# ROT13-encode text, works for decoding, too! ;)
alias rot13='tr a-zA-Z n-za-mN-ZA-M'

# add vim encrypt call
alias vime="vim -u ~/.vimencrypt -x"

# enable aliases to be sudo’ed
alias sudo='sudo '

# gzip-enabled `curl`
alias gurl='curl --compressed'

# get week number
alias week='date +%V'

# grep stuff
alias grep='grep --color --binary-files=without-match'
