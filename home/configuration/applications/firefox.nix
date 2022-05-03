{ config, lib, pkgs, ... }:

{
  programs = {
    browserpass = {
      enable = false;
      browsers = [ "firefox" ];
    };

    firefox = {
      enable = true;
      package = pkgs.firefox-wayland;

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        betterttv
        bypass-paywalls-clean
        facebook-container
        flagfox
        gopass-bridge
        kristofferhagen-nord-theme
        octolinker
        octotree
        # plasma-integration
        reddit-enhancement-suite
        refined-github
        return-youtube-dislikes
        sourcegraph
        ublock-origin
      ];

      # There is a bug with RES in Firefox in Wayland? Sway? tiling WMs?
      # that doesn't display the popup window to grant permissions.
      # To solve: 
      # > In the prompt, open js console (F12) and grab window.location.href.
      # > Then copy and paste that into a normal tab and click the button.
      # > THEN I get the real firefox balloon message about actually granting the permissions.
      # https://reddit.com/r/RESissues/comments/pje3x2/expandos_in_linuxwaylandfirefox_permissions/hcn7mx5/

      profiles."main" = {
        id = 0;
        settings = {
          # Misc
          "accessibility.blockautorefresh" = true;
          "accessibility.typeaheadfind.enablesound" = false;
          "accessibility.typeaheadfind.flashBar" = 0;
          "app.update.auto" = false;
          "beacon.enabled" = false;
          "browser.aboutConfig.showWarning" = false;
          "browser.chrome.toolbar_tips" = false;
          "browser.fullscreen.autohide" = false;
          "browser.newtabpage.activity-stream.discoverystream.enabled" = false;
          "browser.newtabpage.activity-stream.topSitesRows" = 3;
          "browser.newtabpage.pinned" = ''
            [{"url":"https://www.reddit.com/r/all/","label":"r/all","baseDomain":"reddit.com"},{"url":"https://www.youtube.com","label":"YouTube","baseDomain":"youtube.com"},{"url":"https://questionablecontent.net/","label":"Questionable Content","baseDomain":"questionablecontent.net"},{"url":"https://xkcd.com/","label":"xkcd","baseDomain":"xkcd.com"},{"url":"https://tapas.io/reading-list","label":"Tapas","baseDomain":"tapas.io"},{"url":"https://www.stbeals.com/","label":"StBeals","baseDomain":"stbeals.com"},{"url":"https://dilbert.com/","label":"Dilbert","baseDomain":"dilbert.com"},{"url":"https://perlweekly.com/latest.html","label":"Perl Weekly"},{"url":"https://www.polimi.it/servizi-online","label":"PoliMi Servizi Online","baseDomain":"polimi.it","customScreenshotURL":"https://www.polimi.it/typo3conf/ext/sitetemplate/Resources/Public/Images/favicons/96x96.png"},{"url":"https://webeep.polimi.it/my/","label":"WeBeep","baseDomain":"webeep.polimi.it"},{"url":"https://mail.tutanota.com/mail/","label":"Tutanota","baseDomain":"mail.tutanota.com"},{"url":"https://mail.google.com/mail/u/0/","label":"Gmail","baseDomain":"mail.google.com"},{"url":"https://www.khanacademy.org/","label":"Khan Academy","baseDomain":"khanacademy.org"},{"url":"https://www.tutorialspoint.com/tutorialslibrary.htm","label":"Tutorials Point","baseDomain":"tutorialspoint.com"},{"url":"https://www.geeksforgeeks.org/","label":"GeeksforGeeks","baseDomain":"geeksforgeeks.org"},{"url":"https://distrowatch.com/","label":"Distrowatch"},{"url":"https://search.nixos.org/packages?channel=unstable","label":"NixOS Search - Packages","baseDomain":"search.nixos.org"},{"url":"https://discourse.nixos.org/","label":"NixOS Discourse"},{"url":"https://github.com/NixOS/nixpkgs","label":"nixpkgs","baseDomain":"github.com"},{"url":"https://news.ycombinator.com/news","label":"Hacker News","baseDomain":"news.ycombinator.com"},{"url":"https://www.phoronix.com/scan.php?page=home","label":"phoronix","baseDomain":"phoronix.com"},{"url":"https://lwn.net","label":"LWN.net","baseDomain":"lwn.net"},{"url":"https://www.theregister.com/","label":"The Register","baseDomain":"theregister.com"},{"url":"https://www.anandtech.com/","label":"Anandtech","baseDomain":"anandtech.com"}]
          '';
          "browser.startup.homepage" = "about:home";
          "browser.shell.checkDefaultBrowser" = false; # default
          "browser.urlbar.showSearchSuggestionsFirst" = false;
          "font.default.x-western" = "sans-serif";
          "font.name.monospace.x-western" = config.fonts.monospace;
          "font.name.sans-serif.x-western" = config.fonts.sansSerif;
          "font.name.serif.x-western" = config.fonts.serif;
          "privacy.userContext.extension" = "@contain-facebook";
          "network.trr.custom_uri" = "https://dns.quad9.net/dns-query";
          "network.trr.uri" = "https://dns.quad9.net/dns-query";

          # Restore previous session
          "browser.startup.page" = 3;
          "browser.sessionstore.interval" = 30000;
          "browser.sessionstore.restore_on_demand" = true;

          "browser.toolbars.bookmarks.visibility" = "always";
          "devtools.dom.enabled" = true;
          "devtools.theme" = "dark";
          "devtools.toolbox.host" = "right";
          "extensions.pocket.enabled" = false;

          # Hardware video acceleration
          # https://wiki.archlinux.org/title/firefox#Hardware_video_acceleration
          "gfx.webrender.all" = true;
          "media.ffmpeg.vaapi.enabled" = true;

          # Native dialogs/file pickers
          # needs xdg-desktop-portal-* installed
          "widget.use-xdg-desktop-portal" = true;

          # Use dark themes when available
          # Can interfere with RFP
          # "browser.in-content.dark-mode" = true;
          # "ui.systemUsesDarkTheme" = 1;

          # Popups from plugins
          # 0 => allow all
          # 1 => allow up to dom.popup_maximum
          # 2 => block all
          # 3 => block all, even on whitelistes sites
          "privacy.popups.disable_from_plugins" = 1;

          # Backspace key:
          # 0 => history navigation
          # 1 => page navigation
          "browser.backspace_action" = 1;

          # Move disk cache to RAM
          "browser.cache.disk.parent_directory" = "/run/user/1000/firefox";

          # Privacy
          # https://proprivacy.com/privacy-service/guides/firefox-privacy-security-guide#how-to-make-firefox-more-secure-using-aboutconfig
          # https://www.privacytools.io/browsers/#about_config
          # https://ffprofile.com
          "browser.safebrowsing.malware.enabled" = false;
          "browser.safebrowsing.phishing.enabled" = false;
          "browser.safebrowsing.downloads.remote.enabled" = false;
          # "datareporting.healthreport.uploadEnabled" = false # when true send anonymous health reports to Mozilla
          "dom.event.clipboardevents.enabled" = false;
          # "dom.storage.enabled" = false; # can break stuff
          # "geo.enabled" = false;
          "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
          "geo.wifi.uri" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
          "network.cookie.cookieBehavior" = 5;
          "network.cookie.lifetimePolicy" = 3; # Cookies expire after at max 90 days (see network.cookie.lifetime.days)
          "network.dns.disablePrefetch" = true;
          "network.proxy.socks_remote_dns" = true;
          # "network.http.sendRefererHeader" = 0; # can break stuff, default = 2
          "network.http.sendSecureXSiteReferrer" = false;
          "network.prefetch-next" = false;
          "privacy.donottrackheader.enabled" = true;
          "privacy.donottrackheader.value" = 1;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          # "toolkit.telemetry.enabled" = false; # when true send anynymous reports to Mozilla
          "privacy.firstparty.isolate" = true; # Can break third-party logins
          "privacy.resistFingerprinting" = true;
          "browser.send_pings" = false; # default
          "network.http.referer.XOriginPolicy" = 1; # A value of 0 can break stuff
          "network.http.referer.XOriginTrimmingPolicy" = 2; # Decrement if it breaks stuff
          "network.predictor.enabled" = false;
          "network.IDN_show_punycode" = true;
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
          "browser.crashReports.unsubmittedCheck.enabled" = false;
          "browser.disableResetPrompt" = true;
          "device.sensors.ambientLight.enabled" = false; # default
          # "device.sensors.motion.enabled" = false; # Can interfere with RFP
          "dom.battery.enabled" = false;
          "network.captive-portal-service.enabled" = false;

          # Other resources:
          # https://github.com/arkenfox/user.js
          # https://github.com/pyllyukko/user.js
          # http://kb.mozillazine.org/About:config_entries
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.feeds.snippets" = false; # default
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.default.sites" = "";
          "geo.provider.use_gpsd" = false; # Linux
          "browser.region.network.url" = ""; # Default = "https://location.services.mozilla.com/v1/country?key=%MOZILLA_API_KEY%"
          "browser.region.update.enabled" = false;
          "browser.search.region" = "IT";
          "intl.accept_languages" = "en-US, en";
          "javascript.use_us_english_locale" = true;
          "extensions.getAddons.showPane" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "app.shield.optoutstudies.enabled" = false;
          "browser.discovery.enabled" = false;
          "browser.tabs.crashReporting.sendReport" = false;
          "captivedetect.canonicalContent" = ""; # default = "<meta http-equiv="refresh" content="0;url=https://support.mozilla.org/kb/captive-portal"/>"
          "extensions.formautofill.addresses.enabled" = false;
          # "extensions.formautofill.available" = "off"; # default = "detect"
          "extensions.formautofill.creditCards.available" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "extensions.formautofill.heuristics.enabled" = false;
          "browser.fixup.alternate.enabled" = false;
          "browser.urlbar.trimURLs" = false;
          "browser.urlbar.speculativeConnect.enabled" = false;
          "browser.urlbar.dnsResolveSingleWordsAfterSearch" = 0;
          "network.auth.subresource-http-auth-allow" = 1; # default = 2
          "browser.privatebrowsing.forceMediaMemoryCache" = true;
          "media.memory_cache_max_size" = 65536;
          "security.ssl.require_safe_negotiation" = true;
          "security.pki.sha1_enforcement_level" = 1; # default = 3
          "security.cert_pinning.enforcement_leve" = 2;
          "security.remote_settings.crlite_filters.enabled" = true;
          "security.pki.crlite_mode" = 2;
          "dom.security.https_only_mode" = true;
          "security.ssl.treat_unsafe_negotiation_as_broken" = true;
          "browser.xul.error_pages.expert_bad_cert" = true;
          "security.insecure_connection_text.enabled" = true;
          "privacy.userContext.ui.enabled" = true;
          "privacy.userContext.enabled" = true;
          "media.peerconnection.ice.default_address_only" = true;
          "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
          "media.autoplay.blocking_policy" = 1;
          "dom.disable_window_move_resize" = true;
          "browser.link.open_newwindow" = 3; # default
          "browser.link.open_newwindow.restriction" = 2; # default, decrementing can break stuff
          "dom.allow_cut_copy" = false;
          "dom.vibrator.enabled" = false;
          "javascript.options.asmjs" = false;
          "dom.vr.enabled" = false; # default
          "permissions.default.xr" = 2; # default = 0
          "permissions.manager.defaultsUrl" = "";
          "browser.download.useDownloadDir" = false;
          "browser.download.manager.addToRecentDocs" = false;
          "browser.contentblocking.category" = "strict";
          "dom.storage.next_gen" = true;
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.tabs.warnOnClose" = false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "general.autoScroll" = true;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        };
      };
    };
  };

  home = {
    packages = [ pkgs.passff-host ];

    sessionVariables = {
      BROWSER = "firefox";
      MOZ_ENABLE_WAYLAND = 1;
    };
  };

  wayland.windowManager.sway.config.keybindings =
    let mod = config.wayland.windowManager.sway.config.modifier;
    in lib.mkOptionDefault { "${mod}+b" = "exec firefox"; };
}
