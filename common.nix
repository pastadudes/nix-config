{lib, ...}: let
  isLinux = builtins.pathExists "/etc/nixos";
in
  lib.mkMerge [
    {
      nix.settings.experimental-features = ["nix-command" "flakes"];
      nix.settings.trusted-users = ["pastaya"];
    }

    (lib.optionalAttrs isLinux {
      networking.networkmanager.enable = true;
      system.stateVersion = "25.05";
      i18n.defaultLocale = "en_US.UTF-8";
      console = {
        font = "Lat2-Terminus16";
        useXkbConfig = true;
      };
      zramSwap = {
        enable = true;
        algorithm = "zstd";
      };
    })

    (lib.optionalAttrs (!isLinux) {
      system.stateVersion = 6;
    })
  ]
