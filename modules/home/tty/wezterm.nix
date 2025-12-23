{...}: {
  programs.wezterm = {
    enable = true;
    extraConfig = "
      local wezterm = require 'wezterm'
      local config = wezterm.config_builder()

      config.font_size = 12
      config.font = wezterm.font 'Maple Mono NF'
      config.color_scheme = 'Kanagawa (Gogh)'

      return config
    ";
  };
}
