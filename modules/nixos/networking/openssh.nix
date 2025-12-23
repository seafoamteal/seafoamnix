{...}: {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = false;
      KbdInteractiveAuthentication = false;
    };
  };
}
