{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    any-nix-shell

    bat-extras.batdiff
    bat-extras.batman
    bat-extras.batgrep
    bat-extras.batman

    bc
    cachix
    file
    gdb
    ripgrep
    rwhich
    sd
    shellcheck
    strace
    unzip
    wget
    zip
    scrcpy

    bottom
    dig
    duf
    lshw
    lsof
    nettools
    nmap
    pciutils
    sysstat
    tcpdump
    usbutils
    whois

    yubikey-manager-qt
    yubikey-personalization
    yubioath-desktop
  ];

  programs = {
    bat = {
      enable = true;
      config = {
        pager = "less";
        theme = "Nord";
      };
    };

    exa.enable = true;

    fzf = {
      enable = true;
      changeDirWidgetCommand = "fd --type directory --follow --hidden --color=always";
      defaultCommand = "fd --type file --follow --hidden --color=always";
      defaultOptions = [ "--height 40%" "--layout=reverse --ansi" ];
      fileWidgetCommand = "${config.programs.fzf.defaultCommand}";
    };

    htop = {
      enable = true;

      settings = {
        account_guest_in_cpu_meters = false;
        color_scheme = 0;
        cpu_count_from_one = false;
        delay = 15;
        detailed_cpu_time = false;
        enable_mouse = true;
        fields = [ 0 48 17 18 38 39 40 2 46 47 49 1 ];
        find_comm_in_cmdline = true;
        header_margin = true;
        hide_function_bar = false;
        hide_kernel_threads = false;
        hide_userland_threads = false;
        highlight_base_name = true;
        highlight_changes = false;
        highlight_changes_delay_Secs = 5;
        highlight_megabytes = true;
        highlight_threads = true;
        shadow_other_users = false;
        show_cpu_frequency = true;
        show_cpu_usage = true;
        show_merged_command = false;
        show_program_path = true;
        show_thread_names = false;
        sort_key = 46;
        sort_direction = 0;
        strip_exe_from_cmdline = true;
        tree_sort_key = 0;
        tree_sort_direction = 1;
        tree_view = false;
        tree_view_always_by_pid = false;
        update_process_names = false;
        vim_mode = true;
        left_meters = [ "LeftCPUs" "CPU" "Memory" "Swap" "Zram" "DiskIO" "NetworkIO" ];
        left_meter_modes = [ 1 2 1 1 2 2 2 ];
        right_meters = [ "RightCPUs" "Tasks" "LoadAverage" "Uptime" "Battery" "SELinux" "Systemd" ];
        right_meter_modes = [ 1 2 2 2 2 2 2 ];
      };
    };

    less = {
      enable = true;
      keys = ''
        #env
        LESS = --quit-if-one-screen --ignore-case --RAW-CONTROL-CHARS --incsearch
      '';
    };

    lesspipe.enable = true;

    lf = {
      enable = true;

      commands = {
        bulk-rename = ''
          ''${{
            old="$(mktemp)"
            new="$(mktemp)"
            [ -n "$fs" ] && fs="$(ls)"
            printf '%s\n' "$fs" >"$old"
            printf '%s\n' "$fs" >"$new"
            $EDITOR "$new"
            [ "$(wc -l "$new")" -ne "$(wc -l "$old")" ] && exit
            paste "$old" "$new" | while IFS= read -r names; do
              src="$(printf '%s' "$names" | cut -f1)"
              dst="$(printf '%s' "$names" | cut -f2)"
              if [ "$src" = "$dst" ] || [ -e "$dst" ]; then
                  continue
              fi
              mv -- "$src" "$dst"
            done
            rm -- "$old" "$new"
            lf -remote "send $id unselect"
          }}
        '';

        paste-async = ''
          &{{
            set -- $(lf -remote load)
            mode="$1"
            shift
            case "$mode" in
              copy) cp -rn -- "$@" .;;
              move) mv -n -- "$@" .;;
            esac
            lf -remote "send load"
            lf -remote "send clear"
          }}
        '';

        recol = ''
          &{{
            w=$(tput cols)
            if [ $w -le 80 ]; then
              lf -remote "send $id set ratios 1:2"
            elif [ $w -le 160 ]; then
              lf -remote "send $id set ratios 1:2:3"
            else
              lf -remote "send $id set ratios 1:2:3:5"
            fi
          }}
        '';

        trash = ''
          cmd trash %trash-put $fx
        '';
      };

      extraConfig =
        let
          kittyCleaner = pkgs.writeShellScript "kittyCleaner.sh" ''
            ${config.programs.kitty.package}/bin/kitty +icat --clear --silent --transfer-mode file
          '';
        in
        ''
          set cleaner ${kittyCleaner}
          set mouse on
        '';

      keybindings = {
        P = "paste-async";
      };

      previewer.source = pkgs.writers.writeBash "kittyPreviewer.sh" ''
        if [[ "$( file -Lb --mime-type "$1")" =~ ^image ]]; then
          ${config.programs.kitty.package}/bin/kitty +icat --silent \
            --transfer-mode file --place "$2x$3@$4x$5" "$1"
          exit 1
        fi
        
        ${pkgs.pistol}/bin/pistol "$1"
      '';

      settings = {
        anchorfind = false;
        dircounts = false;
        dirfirst = true;
        drawbox = true;
        filesep = "\n";
        findlen = 1;
        globsearch = true;
        hidden = true;
        icons = false;
        ifs = "\n";
        ignorecase = true;
        ignoredia = true;
        incsearch = true;
        info = "size:time";
        number = true;
        period = 0;
        preview = true;
        relativenumber = false;
        reverse = false;
        scrolloff = 0;
        shell = "zsh";
        shellopts = "-euy";
        smartcase = true;
        smartdia = true;
        sortby = "name";
        tabstop = 4;
        wrapscan = true;
        wrapscroll = false;
      };
    };
  };
}
