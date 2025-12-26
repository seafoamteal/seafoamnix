{...}: {
  imports = [
    ./disko-configuration.nix
    ./hardware-configuration.nix
    ../../modules/nixos
    ../../modules/nixos/platforms/server.nix
    ../../modules/nixos/services/caddy.nix
  ];

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";
        efiSupport = true;
        efiInstallAsRemovable = true;
      };
    };
  };

  networking.hostName = "verdigris";
  time.timeZone = "Europe/Berlin";
  system.stateVersion = "25.05";
}
