{config, ...}: {
  config = {
    system.primaryUser = "pastaya";
    isServer = false;

    nix = {
      settings = {
        experimental-features = ["nix-command" "flakes"];
      };
      gc = {
        automatic = true;
      };
    };

    networking.hostName = "daramd";

    # allow unfree packages
    nixpkgs.config.allowUnfree = true;
  };
}
