export ZSH="/Users/nuriamari/.oh-my-zsh"
ZSH_THEME="spaceship"

autoload -U promptinit; promptinit
prompt spaceship

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  prompt
  contrib-prompt
)

# prompt customizations
SPACESHIP_CHAR_COLOR_SUCCESS=121
SPACESHIP_DIR_COLOR=045	
SPACESHIP_GIT_BRANCH_COLOR=196
SPACESHIP_NODE_COLOR=035
SPACESHIP_PACKAGE_SHOW=false

source $ZSH/oh-my-zsh.sh

alias signin="ssh -Y nfamari@linux.student.cs.uwaterloo.ca"
alias project="cd ~/Developer/Waterloop/Waterloop-Team-Manager"
alias py="python3"
alias 240="cd ~/Dropbox/Second\ Year/2B/CS240"
alias 241="cd ~/Dropbox/Second\ Year/2B/CS241"
alias 251="cd ~/Dropbox/Second\ Year/2B/CS251"
alias 239="cd ~/Dropbox/Second\ Year/2B/MATH239"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH=~/Developer/flutter/bin:$PATH
 
