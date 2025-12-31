{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./disko-configuration.nix
    ./hardware-configuration.nix
    ../../modules/nixos
    ../../modules/nixos/platforms/server.nix
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

  networking = {
    hostName = "cyan";
    networkmanager = {
      enable = true;
    };
    firewall = {
      trustedInterfaces = ["tailscale0"];
    };
  };

  systemd.network = {
    enable = true;
    networks."30-wan" = {
      matchConfig.Name = "enp1s0";
      networkConfig.DHCP = "ipv4";
      address = [
        "2a01:4f8:c014:a775::1/64"
      ];
      routes = [
        {Gateway = "fe80::1";}
      ];
    };
  };

  time.timeZone = "Europe/Berlin";
  system.stateVersion = "25.11";
}
