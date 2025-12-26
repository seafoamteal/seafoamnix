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

  systemd.network = {
    enable = true;
    networks."30-wan" = {
      matchConfig.Name = "enp1s0";
      networkConfig.DHCP = "ipv4";
      address = [
        "2a01:4f8:1c1c:3356::1/64"
      ];
      routes = [
        {Gateway = "fe80::1";}
      ];
    };
  };

  networking.hostName = "verdigris";
  time.timeZone = "Europe/Berlin";
  system.stateVersion = "25.05";
}
