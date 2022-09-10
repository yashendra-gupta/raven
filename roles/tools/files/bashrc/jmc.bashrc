export JMC_HOME='/opt/development/bin/jmc/"JDK Mission Control"'
export JMC=$JMC_HOME/jmc # $JMC_HOME not working alias directly

# https://unix.stackexchange.com/questions/4004/how-can-i-run-a-command-which-will-survive-terminal-close
# https://stackoverflow.com/questions/10408816/how-do-i-use-the-nohup-command-without-getting-nohup-out
# https://man7.org/linux/man-pages/man1/nohup.1.html
alias jmc="nohup $JMC </dev/null >/dev/null 2>&1 &"  #completely detached from terminal