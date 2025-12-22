{pkgs, ...}: {
  home.packages = with pkgs; [
    maple-mono.NF
    lilex
  ];
}
