# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

alias c='clear'
alias ls='lsd'
alias bat='batcat'
alias fv='fzf --print0 | xargs -0 -o nvim'

fish_vi_key_bindings

set -gx FZF_DEFAULT_COMMAND "fdfind . $HOME"

