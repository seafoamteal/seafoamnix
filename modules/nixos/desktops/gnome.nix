{pkgs, ...}: {
  services.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverridePackages = [pkgs.mutter];
    extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features=['scale-monitor-framebuffer']
    '';
  };

  programs.gnome-shell = {
    extensions = [{package = pkgs.gnomeExtensions.gsconnect;}];
  };

  dconf = {
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        gsconnect.extensionUuid
      ];
    };
  };

  home.packages = with pkgs; [
    gnome-tweaks
  ];
}
