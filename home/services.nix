{pkgs, ...}: {
  services = {
    gpg-agent = {
      enable = true;
      enableNushellIntegration = true;
      enableSshSupport = true;
      pinentry = {
        package = if pkgs.stdenv.isDarwin then pkgs.pinentry_mac else pkgs.pinentry-bemenu;
        program = if pkgs.stdenv.isDarwin then "pinentry-mac" else "pinentry-bemenu";
      };
    };
  };
}
