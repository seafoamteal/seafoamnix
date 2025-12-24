{...}: {
  xdg.configFile."git/allowedSigners".text = ''
    dev@haripm.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIATMrTptuZ72X309YDzCyebkQ6We979kcoLZ3p9AwSRE
  '';

  programs.git = {
    enable = true;

    ignores = [
      ".direnv/"
    ];

    settings = {
      user = {
        name = "Hari Mohan";
        email = "dev@haripm.com";
        signingKey = "~/.ssh/id_ed25519.pub";
      };

      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.config/git/allowedSigners";
      };
      commit.gpgSign = true;
      tag.gpgSign = true;

      init = {
        defaultBranch = "trunk";
      };
    };
  };
}
