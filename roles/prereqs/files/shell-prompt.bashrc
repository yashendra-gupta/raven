# Customize shell prompt
# https://github.com/yashendra-gupta/journal-devops/blob/master/linux/customize/customize-shell-prompt.md     

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

export PS1='\[\033[1;32m\]\u@\h\[\033[00m\]:\[\033[1;34m\]\w\[\033[1;31m\]$(__git_ps1)\[\033[00m\] \$' 
