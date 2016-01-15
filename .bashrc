#{{{ Exports: PATH, LD, ...
# define the root directory of local bin, lib and etc.
# first choice is ~/.local
# then ~/usr
test -d $HOME/.local && export LOCAL=$HOME/.local || export LOCAL=$HOME/usr

export PATH=$LOCAL/bin:$PATH
export PKG_CONFIG_PATH=$LOCAL/lib/pkgconfig:$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=$LOCAL/lib64:$HOME/.local/lib:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=$LOCAL/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$LOCAL/include:$CPLUS_INCLUDE_PATH
export GI_TYPELIB_PATH=$LOCAL/lib/girepository-1.0:$GI_TYPELIB_PATH

export GOROOT=$LOCAL/go
export GOPATH=$LOCAL/gopkg
export PATH=$GOPATH:$GOPATH/bin:$GOROOT/bin:$PATH

# PATH for CUDA
#export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

# PATH for MPI
export MPI_C_INCLUDE_PATH=/opt/mpich/include
export MPI_C_LIBRARIES=/opt/mpich/ch-p4/lib64

# python virtualenv wrapper
export WORKON_HOME=$HOME/.virtualenv
if [ -f $HOME/.local/bin/virtualenvwrapper.sh ]; then 
    source $HOME/.local/bin/virtualenvwrapper.sh
elif [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
elif [ -f /usr/bin/virtualenvwrapper.sh ]; then
    source /usr/bin/virtualenvwrapper.sh
fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# default editor
export VISUAL=vim
export EDIT=$VISUAL
#}}}
#{{{ Aliases
# OS specific settings
case "$(uname -s)" in
    Darwin)
        alias imagej='java -Xmx1024m -jar /Applications/ImageJ/ImageJ64.app/Contents/Resources/Java/ij.jar'
        alias ls="gls --color --group-directories-first"
        alias vim="/usr/local/bin/vim"
        ;;
    Linux)
        alias open='xdg-open 2>/tmp/xdg-open'
        alias ls="ls --color --group-directories-first"
        ;;
    default)
        echo 'unknown os'
esac

alias l="ls -l"
alias ll="ls -la"
alias la='ls -A'
alias ltr="ls -ltr"
alias du="du -h"
alias ..='cd ..'
alias ...='cd ../..'
alias vi="vim -X"
#}}}
#{{{ key binding with readline
if [ -t 1 ]
then
    bind '"\C-d": kill-word'     
    bind '"\C-f": forward-word'   
    bind '"\C-b": backward-word'
    bind '"\C-g": kill-whole-line'
    bind '"\C-w": shell-backward-kill-word'
fi
#}}}
#{{{ Prompt
# Set GIT aware prompt
export GITAWAREPROMPT=~/.git-aware-prompt
source "$GITAWAREPROMPT/main.sh"

# Set different prompt on ssh login
if [ -n "$SSH_CLIENT" ]; then
    #source "$GITAWAREPROMPT/main.sh"
    export PS1='\[\033[0;36m\]\h \[\033[0;32m\]\W\[\033[1;33m\]$git_branch$git_dirty \[\033[0;32m\]> \[\033[0m\]'
else
    export PS1='\[\033[0;32m\]\W\[\033[1;33m\]$git_branch$git_dirty \[\033[0;32m\]> \[\033[0m\]'
fi

# Different prompt on invoking cmd from vim
case $(ps -o comm $PPID) in *vi|*vim)
  PS1="\[\033[1;33m\](VIM $(ps $PPID | awk '{print $NF}' | sed 1d)) \[\033[0m\]" ;;
esac
#}}}
#{{{ Term
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
#}}}
#{{{ tmux functions
# commands for moving windows in tmux: execute 
#   movetmuxwindow $n1 $n2
# will move the n1'th window to n2'th window
tx-mvwindow() {
	if [[ $1 = "" ]]; then 
		echo "error: specify window number please"
		return
	fi

	local window_list=`tmux list-window | cut -d ":" -f 1`
	local current=`tmux list-window | grep 'active' | cut -d ":" -f 1`

	local tag=0
	local src=0

	for i in $window_list; do
		if [ $i -lt $1 ]; then  
			((tag++))
		fi
		if [ $i -lt $current ]; then 
			((src++))
		fi
	done

	if [ $tag -gt $src ]; then
		for i in `seq $((tag-src))`; do
			tmux swap-window -t +1
		done
	fi

	if [ $tag -lt $src ]; then
		for i in `seq $((src-tag))`; do
			tmux swap-window -t -1
		done
	fi
}

tx-renumber() { tmux move-window -r; tmux refresh-client -S; }
#}}}

# disable C-s C-q
stty -ixon

