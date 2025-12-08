# y did i do this
{
  pkgs,
  lib,
  ...
}:
lib.mkMerge [
  {
    nix.settings.experimental-features = ["nix-command" "flakes"];
    nix.settings.trusted-users = ["pastaya"];

    system.copySystemConfiguration = false;
    system.stateVersion = "25.05";
  }

  (lib.mkIf pkgs.stdenv.isLinux {
    networking.networkmanager.enable = true;
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
]
