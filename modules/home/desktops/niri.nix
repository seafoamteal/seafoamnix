{pkgs, ...}: {
  xdg.configFile."niri/config.kdl".source = ../../../dots/niri/config.kdl;
  xdg.configFile."waybar/config".source = ../../../dots/waybar/config;

  home.packages = with pkgs; [
    swaybg
    brightnessctl
    playerctl
    xwayland-satellite
  ];

  programs.swaylock.enable = true;
  programs.fuzzel.enable = true;
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "niri.service";
    };
  };

  services.swayidle.enable = true;
  services.mako.enable = true;
  services.polkit-gnome.enable = true;

  xdg.portal = {
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
      gnome-keyring
    ];
    config = {
      niri = {
        default = ["gnome" "gtk"];
        "org.freedesktop.impl.portal.Access" = ["gtk"];
        "org.freedesktop.impl.portal.Notification" = ["gtk"];
        "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
      };
    };
  };
}
