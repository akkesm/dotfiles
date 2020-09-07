 # Edit this configuration file to define what should be installed on
 # your system.  Help is available in the configuration.nix(5) man page
 # and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

 #let
 #  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
 #    export __NV_PRIME_RENDER_OFFLOAD=1
 #    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
 #    export __GLX_VENDOR_LIBRARY_NAME=nvidia
 #    export __VK_LAYER_NV_optimus=NVIDIA_only
 #    exec -a "$0" "$@"
 #  '';
 #in
 #{
 #  environment.systemPackages = [ nvidia-offload ];
 #
 #   services.xserver.videoDrivers = [ "nvidia" ];
 #  hardware.nvidia.prime = {
 #    offload.enable = true;
 #
 #    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
 #    intelBusId = "PCI:0:2:0";
 #
 #    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
 #    nvidiaBusId = "PCI:4:0:0";
 #  };
 #}


{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		  # Define file systems
		./fileSystems.nix
		];

 # Use the systemd-boot EFI boot loader.
 # boot.loader.systemd-boot.enable = true;
 # boot.loader.efi.canTouchEfiVariables = true;

	boot.loader = {
		efi = {
			canTouchEfiVariables = true;
			# assuming /boot is the mount point of the  EFI partition in NixOS (as the installation section recommends).
			efiSysMountPoint = "/boot";
		};
		grub = {
			# despite what the configuration.nix manpage seems to indicate,
			# as of release 17.09, setting device to "nodev" will still call
			# `grub-install` if efiSupport is true
			# (the devices list is not used by the EFI grub install,
			# but must be set to some value in order to pass an assert in grub.nix)
			devices = [ "nodev" ];
			efiSupport = true;
			enable = true;
			# set $FS_UUID to the UUID of the EFI partition
			# extraEntries = ''
			# 	menuentry "Windows" {
			#		insmod part_gpt
			#			insmod fat
			#			insmod search_fs_uuid
			#			insmod chain
			#			search --fs-uuid --set=root $FS_UUID
			#			chainloader /EFI/Microsoft/Boot/bootmgfw.efi
			#	}
			# '';
			version = 2;
			useOSProber = true;
		};
	};

	networking.hostName = "B-Ale-NixOS"; # Define your hostname.
 # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
		networking.networkmanager.enable = true;

 # The global useDHCP flag is deprecated, therefore explicitly set to false here.
 # Per-interface useDHCP will be mandatory in the future, so this generated config
 # replicates the default behaviour.
	networking.useDHCP = false;
	networking.interfaces.enp2s0.useDHCP = true;
	networking.interfaces.wlp3s0f0.useDHCP = true;

 # Configure network proxy if necessary
 # networking.proxy.default = "http://user:password@proxy:port/";
 # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

 # Select internationalisation properties.
	i18n.defaultLocale = "it_IT.UTF-8";
	console = {
		font = "Lat2-Terminus16";
		keyMap = "it";
	};

 # Set your time zone.
	time.timeZone = "Europe/Rome";

 # List packages installed in system profile. To search, run:
 # $ nix search wget
	environment.systemPackages = with pkgs; [
			wget 
			neovim
			git
			gnumake
			gparted
			tmux
			mlocate
		#	zsh-syntax-highlighting
			vimpager
			wine
			winetricks
			htop
			lynx
			whois
			bleachbit
			firefox-devedition-bin
			plasma-browser-integration
			ruby
			rustup
			go
			kotlin
			jdk
			file
			evince
			libreoffice-fresh
			python
			python3
			# busybox
	];
	nixpkgs.config.allowUnfree = true;
	
	programs.adb.enable = true;
	nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;	

 # Some programs need SUID wrappers, can be configured further or are
 # started in user sessions.
 # programs.mtr.enable = true;
 # programs.gnupg.agent = {
 #   enable = true;
 #   enableSSHSupport = true;
 #   pinentryFlavor = "gnome3";
 # };

 # List services that you want to enable:

 # Enable the OpenSSH daemon.
	services.openssh.enable = true;

 # Open ports in the firewall.
 # networking.firewall.allowedTCPPorts = [ ... ];
	networking.firewall.allowedTCPPortRanges = [
		{ from = 1714; to = 1764; }
	];
	networking.firewall.allowedUDPPortRanges = [
		{ from = 1714; to = 1764; }
	];
 # networking.firewall.allowedUDPPorts = [ ... ];
 # Or disable the firewall altogether.
 # networking.firewall.enable = false;

 # Enable CUPS to print documents.
 # services.printing.enable = true;

 # Enable sound.
	sound.enable = true;
	hardware.pulseaudio.enable = true;

 # Enable the X11 windowing system.
	services.xserver.enable = true;
	services.xserver.layout = "it";
	services.xserver.xkbOptions = "eurosign:e";
 #services.xserver.videoDrivers = [ "nvidia" ];

 # Enable touchpad support.
	services.xserver.libinput.enable = true;
	services.xserver.libinput.tapping = true;
	

 # Enable the KDE Desktop Environment.
	services.xserver.displayManager.sddm.enable = true;
	services.xserver.desktopManager.plasma5.enable = true;

 # Define a user account. Don't forget to set a password with ‘passwd’.
	programs.zsh.enable = true;
	users.users.Alessandro = {
		isNormalUser = true;
		home = "/home/alessandro";
		shell = pkgs.zsh;
		extraGroups = [ "wheel" "networkmanager" "jackaudio" "adbusers" ];
	};

 # This value determines the NixOS release from which the default
 # settings for stateful data, like file locations and database versions
 # on your system were taken. It‘s perfectly fine and recommended to leave
 # this value at the release version of the first install of this system.
 # Before changing this value read the documentation for this option
 # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "20.03"; # Did you read the comment?

	hardware.opengl.driSupport32Bit = true;
	boot.kernelPackages = pkgs.linuxPackages_latest;

	security.sudo.wheelNeedsPassword = false;

	# nix.gc.automatic = true;
	# nix.gc.dates = "10:30";

	programs.vim.defaultEditor = true;

	# services.jack.jackd.enable = true;
	# services.jack.jackd.extraOptions = [ "-dalsa" "hw:1" ];

	services.xserver.displayManager.lightdm.background = "/home/alessandro/Pictures/BlackSabbathBG.png";

 #environment.systemPackages = [ pkgs.acpi pkgs.android-studio pkgs.base16-shell-preview pkgs.bash_5 pkgs.btrfs-progs pkgs.bzip2 pkgs.capitaine-cursors pkgs.cargo pkgs.catdoc pkgs.celt pkgs.cherry pkgs.chuck pkgs.clac pkgs.clamav pkgs.cmake pkgs.colm pkgs.colordiff pkgs.colorls pkgs.colormake pkgs.comic-neue pkgs.comic-relief pkgs.compsize pkgs.cowsay pkgs.creep pkgs.crex pkgs.crimson pkgs.crystal pkgs.ctl pkgs.cue pkgs.curlFull pkgs.darktable pkgs.dart pkgs.datamash pkgs.ddrescue pkgs.deer pkgs.dhcpcd pkgs.di pkgs.diffutils pkgs.discord-canary pkgs.discord-rpc pkgs.dmd pkgs.doitlive pkgs.dtc pkgs.dub pkgs.duc pkgs.ed pkgs.eff pkgs.efibootmgr pkgs.efitools pkgs.elixir pkgs.emacs pkgs.emojione pkgs.erlang pkgs.es pkgs.etcher pkgs.eternal-terminal pkgs.evince pkgs.exfat pkgs.f2fs-tools pkgs.f5_6 pkgs.falcon pkgs.faust pkgs.ferrum pkgs.fff pkgs.filet pkgs.findutils pkgs.fish pkgs.flac pkgs.flameshot pkgs.flashrom pkgs.flatpak pkgs.font-awesome pkgs.fontconfig pkgs.fontforge pkgs.fortune pkgs.freenet pkgs.gcc10 pkgs.geogebra pkgs.giac-with-xcas pkgs.gimp pkgs.gitMinimal pkgs.glibc pkgs.go pkgs.go-font pkgs.gparted pkgs.gping pkgs.grub pkgs.hr pkgs.htop pkgs.hwinfo pkgs.iftop pkgs.inkscape pkgs.io pkgs.iw pkgs.jack2 pkgs.jp2a pkgs.kotlin pkgs.ksh pkgs.less pkgs.libreoffice-fresh pkgs.linuxHeaders pkgs.lolcat pkgs.lolcode pkgs.lua pkgs.mpd pkgs.neofetch pkgs.neovim-qt pkgs.nfs-utils pkgs.nim pkgs.nordic pkgs.nota pkgs.ntp pkgs.nushell pkgs.ocaml pkgs.oh pkgs.oh-my-zsh pkgs.oil pkgs.onefetch pkgs.opa pkgs.opam pkgs.open-dyslexic pkgs.open-sans pkgs.osl pkgs.openssh pkgs.os-prober pkgs.perl pkgs.php pkgs.pipes pkgs.powershell pkgs.pure pkgs.putty pkgs.pysolfc pkgs.pythonFull pkgs.python3Full pkgs.qbittorrent pkgs.qemu pkgs.qogir-icon-theme pkgs.R pkgs.rakudo pkgs.rc pkgs.red pkgs.refind pkgs.ruby pkgs.rustup pkgs.scala pkgs.scrcpy pkgs.self pkgs.seshat pkgs.sl pkgs.source-code-pro pkgs.squashfsTools pkgs.st pkgs.steam pkgs.strawberry pkgs.tcl pkgs.tdesktop pkgs.texinfo pkgs.thefuck pkgs.tilda pkgs.tldr pkgs.tmux pkgs.tree pkgs.txr pkgs.uefitool pkgs.wget pkgs.urweb pkgs.vifm-full pkgs.vimpager pkgs.vimpc pkgs.wavpack pkgs.wget pkgs.whois pkgs.wine pkgs.winetricks pkgs.wireshark pkgs.zathura pkgs.zig pkgs.zsh ];

}

