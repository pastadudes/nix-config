{ inputs, config, pkgs, lib, ... }:

{
  nix.settings = {
    # this is required because flakes hasn't graduated into a stable feature yet
    experimental-features = [ "nix-command" "flakes" ];
  };

  system.primaryUser = "pastaya";

  nix.gc = {
    automatic = true;
  };

  networking.hostName = "daramd";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
