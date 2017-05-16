#!/bin/sh

alias home='cd /root'
alias work='cd /var/www'
alias psux='ps ux'
alias ll='ls -la'
alias add='git add'
alias grm='git rm'
alias more='less'
alias show='git remote show origin'
alias co='git checkout'
alias fetch='git fetch'
alias show_branches='git branch'
alias status='git status;echo " ";show_local;'
alias clean='git clean'
alias pop_stash='git stash pop'
alias list_stash='git stash list'
alias showstash='git stash show "$@"'
alias ci='git commit --all -m '
alias mergeci='git commit'
alias stash='git stash save'
alias merge='git merge --no-ff '
alias mergetool='git mergetool'
alias merge_over='git merge -Xtheirs'
alias merge_master='git pull --no-rebase origin master'
alias help='git help'
alias clean_preview='git clean -n -f'
alias clean='git clean -f'
alias clean_shit_up='git clean -Xfd'
alias gg='git grep -ni'
alias resource='source /etc/profile'