{ writeScriptBin }:


writeScriptBin "s" ''
  #!/bin/sh
  # Credit to u/o11c

  "$@" 0<>/dev/null 1>&0 2>&1 &
''
