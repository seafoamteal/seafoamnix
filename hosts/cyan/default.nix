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

  age.secrets = {
    forgejo_token.file = ../../secrets/forgejo_token.age;
  };

  services.gitea-actions-runner = {
    package = pkgs.forgejo-runner;
    instances.cyan = {
      enable = true;
      name = "cyan";
      tokenFile = config.age.secrets.forgejo_token.path;
      url = "https://git.hari.pm";
      labels = [
        "debian-latest:docker://node:24-trixie"
        "ubuntu-latest:docker://node:24-trixie"
        "nixos-latest:docker://nixos/nix:latest"
      ];
      settings = {
        log = {
          level = "info";
          job_level = "info";
        };

        runner = {
          file = ".runner";
          capacity = 1;
          timeout = "3h";
          shutdown_timeout = "3h";
          insecure = false;
          fetch_timeout = "5s";
          fetch_interval = "2s";
          report_interval = "1s";
        };

        # cache = {};

        container = {
          network = "";
          enable_ipv6 = true;
          privileged = false;
          options = "";
          workdir_parent = "";
          valid_volumes = [];
          docker_host = "-";
          force_pull = false;
          force_rebuild = false;
        };
      };
    };
  };

  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      fixed-cidr-v6 = "fd00::/80";
      ipv6 = true;
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
