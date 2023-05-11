shopt -s expand_aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto --exclude-dir=.git --exclude=*.sw? --exclude=*.pyc'
alias fgrep='fgrep --color=auto --exclude-dir=.git --exclude=*.sw? --exclude=*.pyc'
alias egrep='egrep --color=auto --exclude-dir=.git --exclude=*.sw? --exclude=*.pyc'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias dss='du -sh * | sort -h'
alias decolorize='sed "s/\x1B\[[0-9;]*[JKmsu]//g"'
alias gg='git graph'
alias vimclean='find -iname "*.sw?" -delete'
