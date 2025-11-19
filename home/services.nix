{pkgs, ...}: {
  services = {
    gpg-agent = {
      enable = true;
      enableNushellIntegration = true;
      enableSshSupport = true;
      pinentry = {
        package = pkgs.pinentry_mac;
        program = "pinentry-mac";
      };
    };
  };
}
