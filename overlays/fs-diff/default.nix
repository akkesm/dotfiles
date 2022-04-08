# https://mt-caret.github.io/blog/posts/2020-06-29-optin-state.html

{ writeShellApplication
, bash
, btrfs-progs
, coreutils
}:

# writeShellApplication sets errexit, nounset, pipefail automatically
writeShellApplication {
  name = "fs-diff";

  runtimeInputs = [
    bash
    btrfs-progs
    coreutils
  ];

  text = ''
    set -E

    OLD_TRANSID=''$(sudo btrfs subvolume find-new /mnt/root-blank 9999999)
    OLD_TRANSID=''${OLD_TRANSID#transid marker was }

    sudo btrfs subvolume find-new "/mnt/root" "$OLD_TRANSID" |
    sed '$d' |
    cut -f17- -d' ' |
    sort |
    uniq |
    while read -r path; do
      path="/$path"
      if [ -L "$path" ]; then
        : # The path is a symbolic link, so is probably handled by NixOS already
      elif [ -d "$path" ]; then
        : # The path is a directory, ignore
      else
        echo "$path"
      fi
    done
  '';
}
