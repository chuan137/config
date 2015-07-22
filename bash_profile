# PATH: UFO specific
export GI_TYPELIB_PATH=$HOME/usr/lib/girepository-1.0:$GI_TYPELIB_PATH
export MPI_C_INCLUDE_PATH=/opt/mpich/include
export MPI_C_LIBRARIES=/opt/mpich/ch-p4/lib64

# PATH for $HOME/usr/
if [ -d $HOME/usr ]; then
    export PKG_CONFIG_PATH=$HOME/usr/lib/pkgconfig:$PKG_CONFIG_PATH
    export LD_LIBRARY_PATH=$HOME/usr/lib:$LD_LIBRARY_PATH
    export C_INCLUDE_PATH=$HOME/usr/include:$C_INCLUDE_PATH
    export CPLUS_INCLUDE_PATH=$HOME/usr/include:$CPLUS_INCLUDE_PATH
fi

# PATH for CUDA
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

# OS specific settings
case "$(uname -s)" in
    Darwin)
        alias imagej='java -Xmx1024m -jar /Applications/ImageJ/ImageJ64.app/Contents/Resources/Java/ij.jar'
        alias ls="gls --color --group-directories-first"
        ;;
    Linux)
        alias open='xdg-open 2>/tmp/xdg-open'
        alias ls="ls --color --group-directories-first"
        ;;
    default)
        echo 'unknown os'
esac

# Aliases
alias l="ls -l"
alias ll="ls -la"
alias la='ls -A'
alias ltr="ls -ltr"
alias du="du -h"
alias ..='cd ..'
alias ...='cd ../..'
alias vi="/usr/bin/vim -X"
alias vim="usr/bin/vim -R"

# key binding with readline
bind '"\C-d": kill-word'     
bind '"\C-f": forward-word'   
bind '"\C-b": backward-word'
bind '"\C-g": kill-whole-line'

# Set different prompt on ssh login
if [ -n "$SSH_CLIENT" ]; then
    export PS1='\[\033[0;36m\]\h \[\033[0;32m\]\W :> \[\033[0m\]'
else
    export PS1='\[\033[0;32m\]\W :> \[\033[0m\]'
fi

# Different prompt on invoking cmd from vim
case $(ps -o comm $PPID) in *vi|*vim)
  PS1="( $(ps $PPID | awk '{print $NF}' | sed 1d) ) $PS1" ;;
  # PS1="( vim ) $PS1" ;;
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
