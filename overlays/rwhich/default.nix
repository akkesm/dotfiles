{ writeScriptBin, zsh }:

writeScriptBin "rwhich" ''
  #!${zsh}/bin/zsh
  set -Eeuo pipefail

  # This script is made for zsh
  # Correctly report zsh built-in commands
  # eg.: `zsh -c "which print` => "print: shell built-in command"
  #      `bash -c "which print"` => "which: no print in ($PATH)"
  paths="$(zsh -c "which -a $1")"

  if [[ "$paths" =~ 'built-in' ]]; then
    echo "$paths"
    exit 0
  elif [[ "$paths" =~ 'not found' ]]; then
    echo "$paths"
    exit 1
  else
    echo "$(echo -n "$paths" | awk '/^\// { print }' | xargs realpath | uniq)"
    exit 0
  fi
''
