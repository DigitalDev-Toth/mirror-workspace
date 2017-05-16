#!/bin/sh

source /etc/profile.d/alpine_func.sh

if [ -f /usr/share/doc/git-*/contrib/completion/git-completion.bash ]; then
  . /usr/share/doc/git-*/contrib/completion/git-completion.bash
fi

Grey="\[\e[1;30m\]"
Purple="\[\e[0;35m\]"
Cyan="\[\e[0;36m\]"
LightGreen="\[\e[1;32m\]"
LightRed="\[\e[1;31m\]"
Default="\[\e[0m\]"

PS1="$LightRed+-[$LightGreen\t-UTC $Default\u$LightGreen@$Purple\h$LightGreen \$(get_branch) $Cyan\w$LightRed]$LightRed+->$Default "
export PS1
