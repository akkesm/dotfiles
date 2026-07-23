{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    android-tools # Add users to "adbusers" group
    pmbootstrap
  ];
}

