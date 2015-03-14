# aliases
alias l="ls -l"
alias ll="ls -la"
alias la='ls -A'
alias ltr="ls -ltr"
alias du="du -h"
alias ..='cd ..'
alias ...='cd ../..'
alias vi="/usr/bin/vim -X"
alias vim="usr/bin/vim -R"

# Path
export PATH=/usr/local/sbin:/usr/local/bin:$PATH

# Python virtualenv wrapper
export WORKON_HOME=$HOME/.virtualenv
source /usr/local/bin/virtualenvwrapper.sh

# Term
export TERM=xterm-256color

# Os specific settings
case "$(uname -s)" in
    Darwin)
        export INPUTRC=~/.inputrc.mac
        alias imagej='java -Xmx1024m -jar /Applications/ImageJ/ImageJ64.app/Contents/Resources/Java/ij.jar'
        alias ls="gls --color --group-directories-first"
        ;;
    Linux)
        export INPUTRC=~/.inputrc
        export PATH=$(find $HOME/applications -maxdepth 2 -type d -name bin -printf "%p:")$PATH
        alias open='xdg-open 2>/tmp/xdg-open'
        alias ls="ls --color -h --group-directories-first"
        ;;
    default)
        echo 'unknown os'
esac

# cmd prompt
if [ -n "$SSH_CLIENT" ]; then
    export PS1='\[\033[0;36m\]\h \[\033[0;32m\]\W :> \[\033[0m\]'
else
    export PS1='\[\033[0;32m\]\W :> \[\033[0m\]'
fi
case $(ps -o comm $PPID) in *vi|*vim)
  #PS1="( $(ps $PPID | awk '{print $NF}' | sed 1d) ) $PS1" ;;
  PS1="( vim ) $PS1" ;;
esac


