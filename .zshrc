# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
SAVEHIST=5000
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
# alias icat="kitty +kitten icat"
alias gitcommit="git commit -a --allow-empty-message -m ''"
alias wpa="sudo killall wpa_supplicant && sudo wpa_supplicant -B -i wlp3s0f0 -c /etc/wpa_supplicant/wpa_supplicant.conf"
# alias polybarlaunch="/home/alessandro/.config/polybar/launch.sh"
alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'
export DOC='/windows_os/Users/ale/Documents'
alias scr='scrcpy --bit-rate 2M --max-size 800 &; disown && exit'
export CFLAGS="-march=native -pipe -ansi -Wc90-c99-compat -Wpedantic -Werror -O2 -g"
export CXXFLAGS="-march=native -pipe -Wpedantic -Werror -O2 -g"
export MAKEFLAGS="-j3"
#alias compile="ls *.c | sed 's/.c//' | xargs -I % zsh -c 'gcc -march=native -pipe -ansi -Wc90-c99-compat -Wpedantic -Werror -O2 -g %.c -o % && ./%'"
#alias compile="cfile=$(ls *.c | sed 's/.c//'); gcc -march=native -pipe -ansi -Wc90-c99-compat -Wpedantic -Werror -O2 -g "$myfile".c -o "$myfile" && ./"$myfile""

# Base16 Shell
#BASE16_SHELL="$HOME/.config/base16-shell/"
#[ -n "$PS1" ] && \
#    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
#        eval "$("$BASE16_SHELL/profile_helper.sh")"

 export ZSH=~/.oh-my-zsh/
 export PATH="$PATH:$HOME/scripts"

plugins=(
  adb
  archlinux
  brew
  catimg
  colored-man-pages
  colorize
  command-not-found
  copybuffer
  copydir
  copyfile
# dogesay
  dotenv
  extract
  git
  git-auto-fetch
  history
  pip
  rake
# rbenv
  ruby
  singlechar
  suse
  systemd
# thefuck
  tmux
  torrent
# zsh-interactive-cd

# zsh-syntax-highlighting
)

ZSH_THEME="galloiscustom"
source $ZSH/oh-my-zsh.sh
