# vim: set ft=sh:

export ARID_HOME=$HOME/.arid
export PATH=$PATH:$ARID_HOME:$ARID_HOME/bin

source $ARID_HOME/.paths
source $ARID_HOME/.development
source $ARID_HOME/.shell_aliases
source $ARID_HOME/.tools

source $ARID_HOME/bin/git-completion.bash
source $ARID_HOME/bin/rake-completion.bash

### Powerline Setup
export PATH=$PATH:/$ARID_HOME/powerline/scripts
source $ARID_HOME/powerline/powerline/bindings/zsh/powerline.zsh

source $ARID_HOME/.load_last
