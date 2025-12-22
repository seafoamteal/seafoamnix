{pkgs, ...}: {
  xdg.configFile."helix/config.toml".source = ../../../dots/helix/config.toml;

  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [
      # nix
      alejandra
      nixd
      # python
      ruff
      ty
    ];
  };
}
