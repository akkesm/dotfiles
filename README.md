# Dotless dotfiles

Dotfiles but without the dots.

Configured with [flake-utils-plus][0] and flakes.

Secrets managed with [sops-nix][1].

Packages are not guaranteed to work.

[0]: https://github.com/gytis-ivaskevicius/flake-utils-plus
[1]: https://github.com/Mic92/sops-nix

# Hosts

Just one for now.

## Civetta

My daily driver.

Laptop with [full disk encryption with YubiKey][2]
and [opt-in state on btrfs][3].

[2]: https://nixos.wiki/wiki/Yubikey_based_Full_Disk_Encryption_(FDE)_on_NixOS
[3]: https://mt-caret.github.io/blog/posts/2020-06-29-optin-state.html

# Home

Configured entirely with [Home Manager][4], including sway.

- Neovim built from the [official flake][5] with an extended plugin set
- Custom Firefox configuration
- Terminal-centric with [Kitty][6] and Zsh

[4]: https://github.com/nix-community/home-manager
[5]: https://github.com/neovim/neovim/tree/master/contrib/flake.nix
[6]: https://sw.kovidgoyal.net/kitty

# Resources and references

**Cool projects used in this repo other than the ones already mentioned above:**
- [Impermanence][7]
- The [NUR][8]
- [nix-direnv][9]
- [direnv][10]
- [sway & addons][11]
  - [waybar styling][12]
- [YubiKey Guide][13]
- [nord theme wallpaper image][14]

**Dotfiles repos I might have taken inspiration from:**
- flake-utils-plus users
  - [Gytis][15] (author)
  - [Fufexan][16]
  - [Bobbbay][17]
- [Hlissner][18]
- [Teto][19] (good example of a custom kernel configuration)
- [NobbZ][20]

**Other generic documentation:**
- [Awesome Nix][21]: a list of Nix related projects
- The [official documentation][22]
- The [unofficial wiki][23]

**And the place you'll spend the most time in:**\
[nixpkgs][24]

[7]: https://github.com/nix-community/impermanence
[8]: https://github.com/nix-community/NUR
[9]: https://github.com/nix-community/nix-direnv
[10]: https://github.com/direnv/direnv
[11]: https://github.com/swaywm/sway/wiki/Useful-add-ons-for-sway
[12]: https://github.com/jakeisnt/nix-cfg/blob/main/config/waybar/style.css

[13]: https://github.com/drduh/YubiKey-Guide
[14]: https://reddit.com/r/nordtheme/comments/fet2fk/humble_nordthemed_nixos_wallpaper
[15]: https://github.com/gytis-ivaskevicius/nixfiles
[16]: https://github.com/fufexan/dotfiles
[17]: https://github.com/Bobbbay/dotfiles
[18]: https://github.com/hlissner/dotfiles
[19]: https://github.com/teto/home
[20]: https://github.com/NobbZ/nix-dotfiles

[21]: https://github.com/nix-community/awesome-nix
[22]: https://nixos.org/learn.html
[23]: https://nixos.wiki/wiki
[24]: https://github.com/NixOS/nixpkgs/tree/nixos-unstable
