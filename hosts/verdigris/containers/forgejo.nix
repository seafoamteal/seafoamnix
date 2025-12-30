# https://unpipeetaulit.fr/en/posts/forgejo_podman/
# https://shami.blog/2025/10/forgejo-rootless-install-with-podman-and-ubuntu-24.04/
{pkgs, ...}: {
  virtualisation.oci-containers.containers = {
    forgejo = {
      image = "codeberg.org/forgejo/forgejo:13@sha256:88858e7f592f82d4f650713c7bed8c0cd792d7f71475a7467c5650a31cd2eda9";
      podman = {
        user = "git";
        sdnotify = "healthy";
      };
      environment = {
        USER_UID = "1000";
        USER_GID = "1000";
        FORGEJO__database__DB_TYPE = "sqlite3";
        FORGEJO__repository__DISABLE_STARS = "true";
        FORGEJO__server__ROOT_URL = "https://git.hari.pm";
        FORGEJO__server__SSH_CREATE_AUTHORIZED_KEYS_FILE = "false";
        FORGEJO__service__DISABLE_REGISTRATION = "true";
      };
      volumes = [
        "forgejo-data:/data"
      ];
      extraOptions = [
        "--health-cmd=curl -f http://127.0.0.1:3000/api/healthz || exit 1"
        "--health-interval=15s"
        "--health-timeout=3s"
        "--health-retries=3"
        "--health-on-failure=kill"
      ];
      ports = [
        "127.0.0.1:3000:3000"
      ];
    };
  };

  services.openssh.extraConfig = ''
    Match User git
      AuthorizedKeysCommand /etc/ssh/git-authorised-keys %u %t %k
      AuthorizedKeysCommandUser git
  '';

  environment.etc = {
    "ssh/git-authorised-keys" = {
      text = ''
        #!/bin/sh
        /run/current-system/sw/bin/podman exec \
        --interactive \
        --user git \
        forgejo /usr/local/bin/forgejo \
        --config /data/gitea/conf/app.ini \
        keys -e git -u "$1" -t "$2" -k "$3"
      '';
      mode = "0755";
    };
  };

  systemd.tmpfiles.rules = [
    "L+ /var/lib/git/git-shell 0750 git git - ${pkgs.writeShellScript "git-shell" ''
      #!/bin/sh
      /run/current-system/sw/bin/podman exec \
        --interactive \
        --user git \
        --env SSH_ORIGINAL_COMMAND="$SSH_ORIGINAL_COMMAND" \
        forgejo \
        sh "$@"
    ''}"
  ];

  users = {
    users.git = {
      isSystemUser = true;
      uid = 19622;
      linger = true;
      group = "git";
      home = "/var/lib/git";
      createHome = true;
      autoSubUidGidRange = true;
      extraGroups = ["systemd-journal"];
      shell = "/var/lib/git/git-shell";
    };
    groups.git = {};
  };
}
