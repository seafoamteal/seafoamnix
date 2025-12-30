{config, ...}: {
  virtualisation.oci-containers.containers = {
    linkding = {
      image = "sissbruecker/linkding:1.44.2@sha256:2883e8b30f02d8dbd2b79d7fd813dff02971b70742e474d0e18f0c3708d22edd";
      podman = {
        user = "linkding";
        sdnotify = "healthy";
      };
      ports = ["127.0.0.1:9090:9090"];
      volumes = [
        "linkding-data:/etc/linkding/data"
      ];
      environment = {
        LD_SUPERUSER_NAME = "hari";
      };
      environmentFiles = [
        config.age.secrets.linkding_env.path
      ];

      extraOptions = [
        "--health-cmd=curl -f http://localhost:9090/health || exit 1"
        "--health-interval=30s"
        "--health-timeout=1s"
        "--health-retries=3"
      ];
    };
  };

  age.secrets = {
    linkding_env = {
      file = ../../../secrets/linkding_env.age;
      owner = "linkding";
    };
  };

  users = {
    users.linkding = {
      isSystemUser = true;
      linger = true;
      uid = 19623;
      group = "linkding";
      home = "/var/lib/linkding";
      createHome = true;
      autoSubUidGidRange = true;
    };
    groups.linkding = {};
  };
}
