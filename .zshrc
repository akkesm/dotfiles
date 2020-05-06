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
alias sysupdate="sudo pacman -Syu --noconfirm"
alias icat="kitty +kitten icat"
alias gitcommit="git commit -a --allow-empty-message -m ''"
alias wpa="sudo killall wpa_supplicant && sudo wpa_supplicant -B -i wlp3s0f0 -c /etc/wpa_supplicant/wpa_supplicant.conf"
alias polybarlaunch="/home/alessandro/.config/polybar/launch.sh"
alias tlmgr='TEXMFDIST/scripts/texlive/tlmgr.pl --usermode'
alias doc='/windows_os/Users/ale/Documents'

export ZSH=/usr/share/oh-my-zsh

plugins=(
  git
  bundler
  dotenv
  osx
  rake
  rbenv
  ruby
)

ZSH_THEME="galloiscustom"
source $ZSH/oh-my-zsh.sh
