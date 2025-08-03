{...}: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings.trusted-users = [ "pastaya" ];

  networking.networkmanager.enable = true;
  # i dont put timezone since my server is far away (eastern usa)
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

  system.copySystemConfiguration = false;
  system.stateVersion = "25.05"; # Have I actually changed everything before enabling this?
  # 9 times out of 10 probably not
}
