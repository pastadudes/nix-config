{...}: {
  programs.iamb = {
    enable = true;
    settings = {
      # default_profile = "personal";
      settings = {
        notfications = {
          enabled = true;
        };
      };
    };
  };
}
