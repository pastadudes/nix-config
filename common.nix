{
  pkgs,
  lib,
  ...
}:
{
  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.settings.trusted-users = ["pastaya"];

  system.copySystemConfiguration = false;
  system.stateVersion = "25.05"; # Have I actually changed everything before enabling this?
  # 9 times out of 10 probably not
}
// lib.optionalAttrs pkgs.stdenv.isLinux {
  networking.networkmanager.enable = true;
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    #keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
}
