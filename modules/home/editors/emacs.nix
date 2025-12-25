{...}: {
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.proof-general
      epkgs.kanagawa-themes
      epkgs.evil
      epkgs.magit
      epkgs.company
      epkgs.company-coq
    ];
  };
  services.emacs = {
    enable = true;
    client.enable = true;
    socketActivation.enable = true;
  };
}
