{ ... }:
{
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
        AllowUsers = [
          "pastaya"
          "bytes"
        ];
      };
    };

    nginx = {
      enable = true;

      virtualHosts."pastaya.net" = {
        root = "/var/www/pastaya.net";
        extraConfig = "autoindex on;";
        default = true;
      };

      # please work
      virtualHosts."zellij.pastaya.net" = {
        # addSSL = true;
        locations."/" = {
          proxyPass = "http://localhost:8082";
        };
        default = false;

        # haslity comment this before fixing it
        
        # extraConfig = ''
        #   ssl_verify_depth 2;
        #   log_format main '$remote_addr - $remote_user [$time_local] "$request" '
        #                   '$status $body_bytes_sent "$http_referer" '
        #                   '"$http_user_agent" "$http_x_forwarded_for"';
        #   access_log /var/log/nginx/access.log main;
        # '';
      };
    };
  };
}
