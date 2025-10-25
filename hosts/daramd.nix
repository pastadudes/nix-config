{ ... }:

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
  # system.activationScripts.postActivation.text = ''
    # check ../darwinServices.nix
    # sudo pmset repeat wakeorpoweron MTWRFSU 07:00:00

    # chsh -s /run/current-system/sw/bin/fish pastaya
    # '';
}
