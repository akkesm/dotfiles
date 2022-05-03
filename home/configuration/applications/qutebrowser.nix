{ config, pkgs, ... }:

{
  programs.qutebrowser = {
    enable = true;

    extraConfig =
      let nordThemeSrc = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/Linuus/nord-qutebrowser/master/nord-qutebrowser.py";
        sha256 = "03jq1xw4vc75dz40jb5apz698ks1nx5q2lkz4w3kw8ml1j5pfwq0";
      };
      in builtins.readFile nordThemeSrc;

    settings = {
      changelog_after_upgrade = "never";
      confirm_quit = [ "downloads" ];

      content = {
        autoplay = false;

        blocking = {
          adblock.lists = [
            "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt"
            "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt"
            "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt"
            "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/quick-fixes.txt"
            "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt"
            "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt"
            "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_2_English/filter.txt"
            "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_11_Mobile/filter.txt"
            "https://easylist.to/easylist/easylist.txt"
            "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_3_Spyware/filter.txt"
            "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_17_TrackParam/filter.txt"
            "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/lan-block.txt"
            "https://easylist.to/easylist/easyprivacy.txt"
            "https://curben.gitlab.io/malware-filter/urlhaus-filter.txt"
            "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_14_Annoyances/filter.txt"
            "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_4_Social/filter.txt"
            "https://secure.fanboy.co.nz/fanboy-antifacebook.txt"
            "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt"
            "https://secure.fanboy.co.nz/fanboy-annoyance.txt"
            "https://easylist.to/easylist/fanboy-social.txt"
            "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances.txt"
            "https://someonewhocares.org/hosts/hosts"
            "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=adblockplus&mimetype=plaintext"
            "https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_16_French/filter.txt"
            "https://easylist-downloads.adblockplus.org/easylistitaly.txt"
            "https://easylist-downloads.adblockplus.org/advblock.txt"
            "https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt"
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
            "https://raw.githubusercontent.com/gioxx/xfiles/master/filtri.txt"
            "https://secure.fanboy.co.nz/enhancedstats.txt"
            "https://raw.githubusercontent.com/Spam404/lists/master/adblock-list.txt"
          ];

          hosts.lists = [
            "https://raw.githubusercontent.com/Spam404/lists/master/adblock-list.txt"
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
          ];

          method = "both";
        };

        cookies = {
          accept = "no-unknown-3rdparty";
          store = false;
        };

        default_encoding = "utf-8";
        pdfjs = true;
      };

      editor.command = [
        "${pkgs.kitty}/bin/kitty"
        "${config.programs.neovim.package}/bin/nvim"
        "+normal {line}G{column}l"
        "{file}"
      ];

      scrolling.smooth = true;
      session.lazy_restore = true;

      tabs = {
        last_close = "close";
        undo_stack_size = 20;
      };
    };
  };
}
