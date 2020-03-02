[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM='xterm-256color';
fi;

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

get_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\[\033[38;5;245m\]\w\[\033[33m\]\$(get_git_branch) \[\e[0m\]"

export SHELL=/bin/bash

eval "$(pyenv init -)"

alias cd_docker_env="cd /var/ata/cache/docker_dev_env/master"
alias cd_work="cd /Users/nuri/ata_desktop/squid/cache"
alias cd_npm="cd /var/squid/sites/panel/squid"
export PATH=$PATH:~/ata_desktop/arc/arcanist/bin:/var/ata/tools
source ~/ata_desktop/arc/arcanist/resources/shell/bash-completion
alias vim=$(which nvim)
alias vi=$(which nvim)
alias generate_tags="ctags -R --exclude=*/node_modules/* --exclude=*/build/* --exclude=*/*.min.js --exclude=*.sql --links=no ."

# tab completion apparently
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
