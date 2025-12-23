{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    ../../modules/nixos/platforms/server.nix
  ];

  networking.hostName = "cerulean";
  time.timeZone = "Europe/Berlin";
  system.stateVersion = "25.05";
}
