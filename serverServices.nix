{
  pkgs,
  lib,
  inputs,
  ...
}: let
  modpack = pkgs.fetchPackwizModpack {
    url = "https://codeberg.org/pastaya/mcpastaya/raw/tag/v1.6.0/pack.toml";
    packHash = "sha256-TAdkg6iOirHw2mStXyTfw6js0aYMlMez0rSEqShS+38=";
  };
  mcVersion = modpack.manifest.versions.minecraft;
  fabricVersion = modpack.manifest.versions.fabric;
  serverVersion = lib.replaceStrings ["."] ["_"] "fabric-${mcVersion}";

  pjcs = inputs.pjcs.packages.${pkgs.system}.default;
in {
  services = {
    xserver.enable = false;

    fail2ban.enable = true;

    openssh = {
      enable = true;
      ports = [22 2055];
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

    caddy = {
      virtualHosts = {
        "pastaya.dev" = {
          extraConfig = ''
            bind 0.0.0.0
            root * /var/www/pastaya.dev
            file_server browse
            encode zstd gzip
          '';
        };
      };
      # setup ttyd later
    };

    minecraft-servers = {
      enable = false;
      eula = true;
      dataDir = "/mc";

      servers = {
        mcpastaya = {
          enable = true;
          openFirewall = true;
          jvmOpts = "-Xms512M -Xmx3G -XX:+UseG1GC -Djava.net.preferIPv4Stack=true -XX:+UnlockExperimentalVMOptions -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:MaxGCPauseMillis=75 -XX:G1HeapRegionSize=8M -XX:InitiatingHeapOccupancyPercent=20 -XX:G1NewSizePercent=20 -XX:G1ReservePercent=15 -XX:SurvivorRatio=16";
          package = pkgs.fabricServers.${serverVersion}.override {loaderVersion = fabricVersion;};
          serverProperties = {
            motd = "\"lifestyle\" server lmao";
            server-port = 25566;
            allow-nether = false;
          };

          symlinks = {
            "mods" = "${modpack}/mods";
          };

          operators = {
            pastaya = {
              uuid = "6edf8619-ce16-4ca5-b5af-299169b524ed";
              level = 3;
              bypassesPlayerLimit = true;
            };
          };
        };
      };
    };

    minecraft-server = {
      enable = false;
      eula = true;
      openFirewall = true;
      jvmOpts = "-Xms512M -Xmx3G -XX:+UseG1GC -Djava.net.preferIPv4Stack=true -XX:+UnlockExperimentalVMOptions -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:MaxGCPauseMillis=75 -XX:G1HeapRegionSize=8M -XX:InitiatingHeapOccupancyPercent=20 -XX:G1NewSizePercent=20 -XX:G1ReservePercent=15 -XX:SurvivorRatio=16";
      package = pkgs.fabricServers.${serverVersion}.override {loaderVersion = fabricVersion;};
      serverProperties = {
        motd = "'lifestyle' server";
        allow-nether = false;
      };
    };
  };
  # TODO: fix
  # systemd.services = {
  #   pjcs-runner = {
  #     description = "the systemd service that runs uhhhh pjcs";
  #     wantedBy = ["multi-user.target"];
  #     after = ["network.target"];
  #     serviceConfig = {
  #       DynamicUser = true;
  #       ExecStart = "${pjcs}/bin/pjcs.bot";
  #       StateDirectory = "pjcs";
  #       Restart = "always";
  #       RestartSec = 5;

  #       Environment = ''
  #         PJCS_DATA_DIR="/var/lib/pjcs"
  #       '';
  #     };
  #   };
  # };
}
