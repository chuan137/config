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
if [ -d $HOME/usr ]; then
    export PATH=$HOME/usr/bin:$PATH
    export PKG_CONFIG_PATH=$HOME/usr/lib/pkgconfig:$PKG_CONFIG_PATH
    export LD_LIBRARY_PATH=$HOME/usr/lib:$LD_LIBRARY_PATH
    export C_INCLUDE_PATH=$HOME/usr/include:$C_INCLUDE_PATH
    export CPLUS_INCLUDE_PATH=$HOME/usr/include:$CPLUS_INCLUDE_PATH
fi
if [ -d $HOME/usr/lib/girepository-1.0 ]; then
    export GI_TYPELIB_PATH=$HOME/usr/lib/girepository-1.0:$GI_TYPELIB_PATH
fi
if [ -d $HOME/applications ]; then
    export PATH=$(find $HOME/applications -maxdepth 2 -type d -name bin -printf "%p:")$PATH
fi
if [ -d $HOME/.go ]; then
    export PATH=$HOME/.go/bin:$PATH
fi
export N_PREFIX=$HOME/usr

# Python virtualenv wrapper
export WORKON_HOME=$HOME/.virtualenv
if [ -f '/usr/local/bin/virtualenvwrapper.sh' ]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi
if [ -f '/usr/bin/virtualenvwrapper.sh' ]; then
    source /usr/bin/virtualenvwrapper.sh
fi

# Os specific settings
case "$(uname -s)" in
    Darwin)
        export INPUTRC=~/.inputrc.mac
        alias imagej='java -Xmx1024m -jar /Applications/ImageJ/ImageJ64.app/Contents/Resources/Java/ij.jar'
        alias ls="gls --color --group-directories-first"
        ;;
    Linux)
        export INPUTRC=~/.inputrc
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

# Term
if [[ -z $TMUX ]]; then
    if [ -e /usr/share/terminfo/x/xterm+256color ]; then # may be xterm-256 depending on your distro
        export TERM='xterm-256color'
    else
        export TERM='xterm'
    fi
else
    if [ -e /usr/share/terminfo/s/screen-256color ]; then
        export TERM='screen-256color'
    else
        export TERM='screen'
    fi
fi

# readline binding
#>> kill word at cursor
bind '"\C-p": shell-kill-word'

# share code or whatever in terminal via web service paste.click
paste_file()
{
    curl --data-binary @"$1" paste.click | xclip
}
alias paste_web='curl --data-binary @- paste.click | xclip'
