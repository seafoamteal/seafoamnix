{...}: {
  virtualisation.oci-containers.containers = {
    actualbudget = {
      image = "actualbudget/actual-server:latest-alpine@sha256:a9d0a6a406dd0ace4a5e091e139e9d990cd321bdc4a15ddd76271b5aa5e2950e";
      podman = {
        user = "actualbudget";
        sdnotify = "healthy";
      };
      volumes = [
        "actual-data:/data"
      ];
      extraOptions = [
        "--health-cmd=node src/scripts/health-check.js"
        "--health-interval=60s"
        "--health-timeout=10s"
        "--health-retries=3"
        "--health-start-period=20s"
      ];
      ports = [
        "127.0.0.1:5006:5006"
      ];
    };
  };

  users = {
    users.actualbudget = {
      isSystemUser = true;
      linger = true;
      uid = 19623;
      group = "actualbudget";
      home = "/var/lib/actualbudget";
      createHome = true;
      autoSubUidGidRange = true;
    };
    groups.actualbudget = {};
  };
}
