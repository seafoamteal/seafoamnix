{...}: {
  imports = [
    ../../../modules/home/editors/helix.nix
    ../../../modules/home/editors/vim.nix
    ../../../modules/home/shells
    ../../../modules/home/tools
    ../../../modules/home/vcs
  ];

  home.username = "hari";
  home.homeDirectory = "/home/hari";
}
