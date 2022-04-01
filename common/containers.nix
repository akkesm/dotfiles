{ ... }:

{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true; # Add users to "podman" group
    };

    oci-containers = {
      backend = "podman";
    };
  };
}
