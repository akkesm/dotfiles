{ lib, pkgs, ... }:

{
  environment = {
    sessionVariables.KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";

    systemPackages = with pkgs; [
      kubectl
      kubernetes-helm
      kafkactl
      natscli
    ];
  };

  services.k3s = {
    enable = false;
    configPath = ./config.yaml;
  };

  systemd.tmpfiles.rules =
    let
      inherit (builtins) toString;
      mkRuleLink = dir: x:
        "L+ /var/lib/rancher/k3s/server/manifests/${lib.removePrefix (toString dir) x} - - - - ${x}";
      mkRules = dir:
        builtins.map (x: mkRuleLink dir x) (map toString (lib.filesystem.listFilesRecursive dir));
    in
    mkRules ./manifests;
}

