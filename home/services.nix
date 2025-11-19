{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  modpack = pkgs.fetchPackwizModpack {
    url = "https://codeberg.org/pastaya/mcpastaya/raw/tag/v1.1.0/pack.toml";
    packHash = "sha256-Cr9re9DR+WgBm66IKILb03SzC+sod1mI9aJuVxWrSik=";
  };
  mcVersion = modpack.manifest.versions.minecraft;
  fabricVersion = modpack.manifest.versions.fabric;
  serverVersion = lib.replaceStrings ["."] ["_"] "fabric-${mcVersion}";
in {
  services =
    {
      gpg-agent = {
        enable = true;
        enableNushellIntegration = true;
        enableSshSupport = true;
        pinentry = {
          package =
            if pkgs.stdenv.isDarwin
            then pkgs.pinentry_mac
            else pkgs.pinentry-bemenu;
          program =
            if pkgs.stdenv.isDarwin
            then "pinentry-mac"
            else "pinentry-bemenu";
        };
      };
    }
    // lib.optionalAttrs osConfig.isServer {
      services = {
        xserver.enable = false;

        fail2ban.enable = true;

        openssh = {
          enable = true;
          ports = [22];
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

        # ayo somebody remind me to uhhh switch to caddy right mate
        nginx = {
          enable = true;

          virtualHosts."pastaya.net" = {
            root = "/var/www/pastaya.net";
            extraConfig = "autoindex on;";
            default = true;
          };

          # please work
          # virtualHosts."zellij.pastaya.net" = {
          #   # addSSL = true;
          #   locations."/" = {
          #     proxyPass = "http://localhost:8082";
          #   };
          #   default = false;

          #   # haslity comment this before fixing it

          #   # extraConfig = ''
          #   #   ssl_verify_depth 2;
          #   #   log_format main '$remote_addr - $remote_user [$time_local] "$request" '
          #   #                   '$status $body_bytes_sent "$http_referer" '
          #   #                   '"$http_user_agent" "$http_x_forwarded_for"';
          #   #   access_log /var/log/nginx/access.log main;
          #   # '';

          # };
          # virtualHosts."git.pastaya.net" = {
          #   locations."/" = {
          #     proxyPass = "http://localhost:6000";
          #   };
          # };
          # streamConfig = ''
          #     upstream mc_backend {
          #       server 127.0.0.1:25565;
          #     }

          #     server {
          #       listen 3000;
          #       proxy_pass mc_backend;
          #       proxy_protocol off;
          #     }
          # '';
        };
        # use gitea instead cuz it has captcha
        # forgejo = {
        #   enable = true;
        #   user = "forgejo";
        #   group = "forgejo";

        #   stateDir = "/var/lib/forgejo";

        #   database = {
        #     type = "sqlite3";
        #     path = "/var/lib/forgejo/data/forgejo.db";
        #   };

        #   settings = {
        #     server = {
        #       ROOT_URL = "https://git.pastaya.net/";
        #       DISABLE_SSH = true; # disables builtin forgejo ssh server (cuz we already have one lmao)
        #       START_SSH_SERVER = false;
        #       HTTP_PORT = 6000;
        #       HTTP_ADDR = "127.0.0.1";
        #     };

        #     # optional minimal setup tweaks
        #     service = {
        #       REGISTER_EMAIL_CONFIRM = false; # i am NOT setting up email for this
        #       DISABLE_REGISTRATION = false;
        #       REQUIRE_SIGNIN_VIEW = false;
        #       # holy fuck so much nesting
        #     };
        #   };
        # };

        minecraft-servers = {
          # sorry guys my server operator has to attend a family matter
          enable = true;
          eula = true;

          servers = {
            mcpastaya = {
              # sorry guys my server operator has to attend a family matter
              enable = true;
              openFirewall = true;
              jvmOpts = "-Xms2G -Xmx3G -XX:+UseG1GC -Djava.net.preferIPv4Stack=true -XX:+UnlockExperimentalVMOptions -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:MaxGCPauseMillis=75 -XX:G1HeapRegionSize=8M -XX:InitiatingHeapOccupancyPercent=20 -XX:G1NewSizePercent=20 -XX:G1ReservePercent=15 -XX:SurvivorRatio=16";
              package = pkgs.fabricServers.${serverVersion}.override {loaderVersion = fabricVersion;};
              serverProperties = {
                motd = "welcome from NixOS!";
                server-port = 3000;
              };

              symlinks = {
                "mods" = "${modpack}/mods";
              };
            };
          };
        };
      };
    };
}
