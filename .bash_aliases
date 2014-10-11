# ALIASES
alias ls='ls -G --color'
alias ll='ls -G -l --color'
alias la='ls -G -l --color -a'

alias console='script/console'
alias c='bundle exec pry -r config/environment.rb'
alias server='script/server'
alias log='bundle exec rake log:clear; tail -f log/development.log'
alias start='RAILS_ENV=development foreman start'
alias b="bundle exec"
alias r="bundle exec rake"

alias st="git status"
alias co="git checkout"
alias br="git branch"
alias com="git commit"
alias push="git push"
alias add="git add"

# 256 color tmux
alias mx="tmux -2"

if [ -x "$(which ack-grep)" ]; then alias ack="ack-grep"; fi
