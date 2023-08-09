# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

alias c='clear'
alias ls='lsd'
alias bat='batcat'
# alias fv='fzf --print0 | xargs -0 -o nvim'
alias sd "cd ~ && cd (find * -type d | fzf)"

fish_vi_key_bindings

# set -gx FZF_DEFAULT_COMMAND "fdfind . -H -t f $HOME"

set -gx FZF_DEFAULT_OPTS "
--preview 'batcat --style numbers,changes --theme Dracula --color=always  {}'
--color fg:#D8DEE9,bg:#2E3440,hl:#A3BE8C,fg+:#D8DEE9,bg+:#434C5E,hl+:#A3BE8C
--color pointer:#BF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B
"

