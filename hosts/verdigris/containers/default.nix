{...}: {
  imports = [
    ./miniflux.nix
    ./forgejo.nix
    ./actualbudget.nix
  ];

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    oci-containers = {
      backend = "podman";
    };
  };
}
