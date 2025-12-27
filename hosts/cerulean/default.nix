{...}: {
  imports = [
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
      };
    };
  };

  networking.hostName = "cerulean";
  time.timeZone = "Europe/Berlin";
  system.stateVersion = "25.05";

  networking.firewall.allowedTCPPorts = [80 443];

  services.caddy = {
    virtualHosts = {
      "haripm.com" = {
        extraConfig = ''
          root * /srv/http
          encode
          file_server
        '';
      };

      # redirect www to root
      "www.haripm.com" = {
        extraConfig = ''
          redir https://haripm.com{uri}
        '';
      };
    };
  };
}
