# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=3000
SAVEHIST=3000
setopt appendhistory autocd extendedglob nomatch
unsetopt notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jq/.zshrc'

autoload -U compinit
compinit

autoload -Uz promptinit
promptinit
prompt walters
# End of lines added by compinstall
alias cls='clear'
alias ll='ls -la'
alias la='ls --color=auto'

# Adapted from code found at <https://gist.github.com/1712320>.
source .zsh/git-prompt/zshrc.sh
# an example prompt
PROMPT='%B%m%b$(git_super_status) > '
function chpwd() {
    emulate -L zsh
    ls
}

