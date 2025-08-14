{...}: {
  services = {
    xserver.enable = false;

    fail2ban.enable = true;

    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [ "pastaya" "bytes" ];
      };
    };

    nginx = {
      enable = true;
      virtualHosts."pastaya.net" = {
        addSSL = true;
        # enableACME = true; # ACME is basically uhhhh get certs
        root = "/var/www/pastaya.net";
        extraConfig = "autoindex on;";
      };
    };
  };
}
