{...}: {
  imports = [
    ../networking/openssh.nix
  ];

  networking = {
    networkmanager.enable = true;
    firewall = {
      trustedInterfaces = ["tailscale0"];
    };
  };

  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "us";

  users.users.root = {
    hashedPassword = "!";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIATMrTptuZ72X309YDzCyebkQ6We979kcoLZ3p9AwSRE"
    ];
  };
}
