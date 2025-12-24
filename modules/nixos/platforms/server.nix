{...}: {
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

  fileSystems = {
    "/" = {
      device = /dev/disk/by-label/nixos;
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "ext4";
    };
  };

  swapDevices = [
    {
      device = "/dev/disk/by-label/swap";
    }
  ];

  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "us";

  users.users.root.hashedPassword = "!";
  security.sudo.wheelNeedsPassword = false;
}
