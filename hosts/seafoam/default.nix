{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    ../../modules/nixos/logins/gdm.nix
    ../../modules/nixos/desktops/niri.nix
    ../../modules/nixos/networking/tailscale.nix
    ../../modules/nixos/networking/kdeconnect.nix
  ];

  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
    };

    initrd.luks.devices."swap" = {
      device = "/dev/disk/by-uuid/b5a4f9ca-3d30-4ec0-9cfc-0451e0ca875f";
    };

    resumeDevice = "/dev/mapper/swap";
  };

  swapDevices = [
    {device = "/dev/mapper/swap";}
  ];

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=2h
  '';

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchExternalPower = "suspend";
  };

  networking = {
    hostName = "seafoam";
    networkmanager.enable = true;
    firewall = rec {
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };

  time.timeZone = "Europe/Dublin";

  i18n = {
    defaultLocale = "en_GB.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "en_IE.UTF-8";
      LC_IDENTIFICATION = "en_IE.UTF-8";
      LC_MEASUREMENT = "en_IE.UTF-8";
      LC_MONETARY = "en_IE.UTF-8";
      LC_NAME = "en_IE.UTF-8";
      LC_NUMERIC = "en_IE.UTF-8";
      LC_PAPER = "en_IE.UTF-8";
      LC_TELEPHONE = "en_IE.UTF-8";
      LC_TIME = "en_IE.UTF-8";
    };
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  programs.dconf = {
    enable = true;
  };

  services.power-profiles-daemon.enable = false;
  services.tlp.enable = false;
  services.auto-cpufreq.enable = true;

  services = {
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  system.stateVersion = "25.05"; # Do you remember the comment?
}
