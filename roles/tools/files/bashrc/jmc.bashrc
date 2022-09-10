export JMC_HOME="/home/vagrant/Downloads/jmc-8.2.1_linux-x64/JDK Mission Control"

# https://unix.stackexchange.com/questions/4004/how-can-i-run-a-command-which-will-survive-terminal-close
# https://stackoverflow.com/questions/10408816/how-do-i-use-the-nohup-command-without-getting-nohup-out
# https://man7.org/linux/man-pages/man1/nohup.1.html
alias jmc='nohup "$JMC_HOME"/jmc </dev/null >/dev/null 2>&1 &'  #completely detached from terminal
