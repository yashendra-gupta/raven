export INTELLIJ_IDEA_COMMUNITY_HOME=/opt/development/bin/intellij_idea_ic
export INTELLIJ_IDEA_COMMUNITY=$INTELLIJ_IDEA_COMMUNITY_HOME/bin

# https://unix.stackexchange.com/questions/4004/how-can-i-run-a-command-which-will-survive-terminal-close
# https://stackoverflow.com/questions/10408816/how-do-i-use-the-nohup-command-without-getting-nohup-out
# https://man7.org/linux/man-pages/man1/nohup.1.html
alias ideac="nohup $INTELLIJ_IDEA_COMMUNITY/idea.sh </dev/null >/dev/null 2>&1 &"  #completely detached from terminal 
