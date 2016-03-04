#!/bin/bash

export ARID_HOME=~/.arid
export PATH=$PATH:$ARID_HOME

source $ARID_HOME/.exports
source $ARID_HOME/.shell_aliases
source $ARID_HOME/bin/git-completion.bash
source $ARID_HOME/bin/rake-completion.bash
source $ARID_HOME/bin/tmuxinator.bash
source $ARID_HOME/powerline/powerline/bindings/bash/powerline.sh
