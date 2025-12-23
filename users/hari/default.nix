{pkgs, ...}: {
  users.users.hari = {
    isNormalUser = true;
    description = "Hari";
    initialPassword = "I'llBeThereForYou";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIATMrTptuZ72X309YDzCyebkQ6We979kcoLZ3p9AwSRE"
    ];
  };

  programs.fish.enable = true;
}
