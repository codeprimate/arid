# ALIASES
alias ls='ls -G'
alias ll='ls -G -l'

alias sfm='cd ~/Code/sfm'
alias console='script/console'
alias c='bundle exec pry -r config/environment.rb'
alias server='script/server'
alias log='bundle exec rake log:clear; tail -f log/development.log'
alias start='RAILS_ENV=development foreman start'
alias b="bundle exec"
alias r="bundle exec rake"

alias st="git status"
alias co="git checkout"
#alias br="git branch"
alias com="git commit"
alias push="git push"
alias add="git add"

cc=/usr/bin/gcc-4.2
