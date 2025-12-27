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

  age.secrets = {
    cf_api_token_hari_pm_dns.file = ../../secrets/cf_api_token_hari_pm_dns.age;
  };

  systemd.services.caddy = {
    serviceConfig = {
      EnvironmentFile = config.age.secrets.cf_api_token_hari_pm_dns.path;
    };
  };

  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = ["github.com/caddy-dns/cloudflare@v0.2.2"];
      hash = "sha256-ea8PC/+SlPRdEVVF/I3c1CBprlVp1nrumKM5cMwJJ3U=";
    };
    globalConfig = ''
      acme_dns cloudflare {env.CF_API_TOKEN}
    '';

    virtualHosts = {
      "hari.pm" = {
        extraConfig = ''
          respond "Hi, Hari!" 200
        '';
      };
    };
  };

  services.dnsmasq = {
    enable = true;
    settings = {
      interface = "tailscale0";
      bind-interfaces = true;
      address = "/hari.pm/100.113.128.75";
      no-resolv = true;
      server = ["1.1.1.1" "1.0.0.1"];
    };
  };

  systemd.services.dnsmasq = {
    after = ["tailscaled.service"];
    wants = ["tailscaled.service"];
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
