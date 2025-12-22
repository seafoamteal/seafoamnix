{...}: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Hari Mohan";
        email = " dev@haripm.com";
      };
      init = {
        defaultBranch = "trunk";
      };
    };
  };
}
