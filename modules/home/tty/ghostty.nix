{...}: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      font-family = "Maple Mono NF";
      font-feature = "cv09,cv10,cv42,cv43";
      font-size = "12";
      theme = "Kanagawa Wave";
    };
  };
}
