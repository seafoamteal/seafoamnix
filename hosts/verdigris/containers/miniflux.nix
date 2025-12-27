{config, ...}: {
  virtualisation.oci-containers.containers = {
    miniflux = {
      image = "miniflux/miniflux@sha256:9a1f95a7a05b77040d19bb7be96194af4c222de02fb84165fb808f65700c064f";
      podman = {
        user = "miniflux";
        sdnotify = "healthy";
      };
      dependsOn = ["miniflux-db"];
      environment = {
        RUN_MIGRATIONS = "1";
        CREATE_ADMIN = "1";
        ADMIN_USERNAME = "hari";
      };
      environmentFiles = [
        config.age.secrets.miniflux_env.path
      ];
      networks = ["miniflux"];
      ports = ["127.0.0.1:8080:8080"];
    };

    miniflux-db = {
      image = "postgres@sha256:b40d931bd0e7ce6eecc59a5a6ac3b3c04a01e559750e73e7086b6dbd7f8bf545";
      podman = {
        user = "miniflux";
        sdnotify = "healthy";
      };
      environment = {
        POSTGRES_USER = "miniflux";
        POSTGRES_DB = "miniflux";
      };
      environmentFiles = [
        config.age.secrets.miniflux_db_env.path
      ];
      volumes = [
        "/var/lib/miniflux/postgresql:/var/lib/postgresql"
      ];
      networks = ["miniflux"];
      extraOptions = [
        "--health-cmd=pg_isready -U miniflux"
        "--health-interval=10s"
        "--health-start-period=30s"
      ];
    };
  };

  age.secrets = {
    miniflux_env = {
      file = ../../../secrets/miniflux_env.age;
      owner = "miniflux";
    };

    miniflux_db_env = {
      file = ../../../secrets/miniflux_db_env.age;
      owner = "miniflux";
    };
  };

  users = {
    users.miniflux = {
      isSystemUser = true;
      linger = true;
      uid = 19621;
      group = "miniflux";
    };
    groups.miniflux = {};
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/miniflux/postgresql 0750 miniflux miniflux -"
  ];

  systemd.services.init-miniflux-network = {
    description = "Creates Podman network for Miniflux containers";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig.Type = "oneshot";
    path = [config.virtualisation.podman.package];
    script = ''
      podman network exists miniflux || podman network create miniflux
    '';
  };
}
