{lib, ...}: {
  imports = [
    ../networking/openssh.nix
  ];

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";
      };
    };

    initrd.availableKernelModules = [
      "ahci"
      "xhci_pci"
      "virtio_pci"
      "virtio_scsi"
      "sd_mod"
      "sr_mod"
      "ext4"
    ];
  };

  networking = {
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [80 443];
      trustedInterfaces = ["tailscale0"];
    };
  };

  fileSystems = lib.mkDefault {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "ext4";
    };
  };

  swapDevices = lib.mkDefault [
    {
      device = "/dev/disk/by-label/swap";
    }
  ];

  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "us";

  users.users.root = {
    hashedPassword = "!";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIATMrTptuZ72X309YDzCyebkQ6We979kcoLZ3p9AwSRE"
    ];
  };
}
