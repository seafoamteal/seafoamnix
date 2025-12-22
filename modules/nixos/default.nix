{pkgs, ...}: {
  imports = [];

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    optimise = {
      automatic = true;
      dates = ["weekly"];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
      helix
      vim

      wget
      curl
      dig
      openssl

      git

      zip
      unzip
      file

      ripgrep
      fzf
      fd

      htop
      wl-clipboard
      tmux

      bc

      python314
    ];
    variables.EDITOR = "hx";
  };
}
