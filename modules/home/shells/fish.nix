{...}: {
  programs.fish = {
    enable = true;
    generateCompletions = true;
    shellAbbrs = {
      "cd" = "z";
      "ls" = "eza";
      "ll" = "eza -l";
      "la" = "eza -la";
      "cls" = "clear";
      "cat" = "bat";
    };
    functions = {
      "fish_greeting" = "";
    };
    interactiveShellInit = ''
      fish_add_path ~/.local/bin
    '';
  };
}
