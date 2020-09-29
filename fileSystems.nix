{ config, pkgs, ... }:

{
	fileSystems = {
		"/" = {
			options = [ "rw" "relatime" ];
		};
		"/boot" = {
			options = [ "rw" "relatime" ];
		};
		"/windows_os" = {
			device = "/dev/disk/by-uuid/CC280B83280B6C30";
			fsType = "ntfs";
			options = [ "rw" "relatime" ];
		};
		"/windows_data" = {
			device = "/dev/disk/by-uuid/2ECAE8EDCAE8B1EF";
			fsType = "ntfs";
			options = [ "rw" "relatime" ];
		};
		"/Arch_home" = {
			device = "/dev/disk/by-uuid/01e0e28e-ff59-485a-973f-742a8206dbd4";
			fsType = "ext4";
			options = [ "rw" "relatime" ];
		};
	};
}
