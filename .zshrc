# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
SAVEHIST=1000
setopt appendhistory autocd nomatch notify
unsetopt beep extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/alessandro/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

alias q="exit"
alias gitcommit="git commit -a --allow-empty-message -m ''"
alias brew="termux-chroot ~/homebrew/bin/brew"

export ZSH=$HOME/.oh-my-zsh

plugins=(
  adb
  bundler
  colorize
  git
  history
  dotenv
  pip
  rake
  ruby
  singlechar
  thefuck
)

ZSH_THEME="galloiscustom"
source $ZSH/oh-my-zsh.sh
