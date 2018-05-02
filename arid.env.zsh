export ARID_HOME=$HOME/.arid
export PATH=$PATH:$ARID_HOME:$ARID_HOME/bin

source $ARID_HOME/.paths
source $ARID_HOME/.exports
source $ARID_HOME/.shell_aliases
source $ARID_HOME/bin/tmuxinator.zsh

# Powerline Setup
unsetopt auto_name_dirs
export PATH=$PATH:/$ARID_HOME/powerline/scripts
source $ARID_HOME/powerline/powerline/bindings/zsh/powerline.zsh
