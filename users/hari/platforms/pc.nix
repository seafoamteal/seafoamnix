{pkgs, ...}: {
  imports = [
    ../../../modules/home/browsers
    ../../../modules/home/chat
    ../../../modules/home/editors
    ../../../modules/home/fonts
    ../../../modules/home/media
    ../../../modules/home/office
    ../../../modules/home/shells
    ../../../modules/home/tools
    ../../../modules/home/tty
    ../../../modules/home/vcs
    ../../../modules/home/desktops/niri.nix
  ];

  home.username = "hari";
  home.homeDirectory = "/home/hari";
  home.stateVersion = "25.05";

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    x11.enable = true;
    gtk.enable = true;
  };

  dconf = {
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
}
