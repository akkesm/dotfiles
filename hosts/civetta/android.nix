{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.pmbootstrap ];

  programs.adb.enable = true; # Add users to "adbusers" group
}
