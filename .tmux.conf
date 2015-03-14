# prefix key
unbind C-b
set-option -g prefix `

# force to reload config file
unbind r
bind r source-file ~/.tmux.conf

# start window numbering at 1 for easier switching
set -g base-index 1

# colors
set -g default-terminal "screen-256color"

setw -g utf8 on
set -g status-utf8 on

# status line
set-option -g status-bg colour235 #base02
set-option -g status-fg colour136 #yellow
set-option -g status-attr default   
set -g status-left "#h:[#S]"
set -g status-left-length 50
set -g status-right-length 50
set -g status-right "%H:%M %d-%h-%Y"
setw -g window-status-current-format "|#I:#W|"
set-window-option -g automatic-rename off

# split panes
bind C-v split-window -h
bind C-h split-window

# quick pane cycling
unbind ^A
bind ^A select-pane -t :.+

# rebind pane tiling
bind V split-window -h
bind H split-window

# quick pane cycling
unbind ^A
bind ^A select-pane -t :.+

# screen like window toggling
bind Tab last-window
bind Escape copy-mode

# vim movement bindings
set-window-option -g mode-keys vi
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# resize panes
bind L resize-pane -R 10
bind H resize-pane -L 10
bind J resize-pane -D 5
bind K resize-pane -U 5
