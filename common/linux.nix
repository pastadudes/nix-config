{...}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-users = ["pastaya"];

  networking.networkmanager.enable = true;

  system.stateVersion = "25.05";

  i18n.defaultLocale = "en_US.UTF-8";

  console.font = "Lat2-Terminus16";
  console.useXkbConfig = true;

  # zram swap
  zramSwap.enable = true;
  zramSwap.algorithm = "zstd";
}
