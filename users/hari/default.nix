{pkgs, ...}: {
  users.users.hari = {
    isNormalUser = true;
    description = "Hari";
    initialPassword = "I'llBeThereForYou";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.fish;
  };
}
