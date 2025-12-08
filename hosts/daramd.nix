{
  config,
  pkgs,
  ...
}: {
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
      package = pkgs.lix;
    };

    networking.hostName = "daramd";

    # allow unfree packages
    nixpkgs.config.allowUnfree = true;
  };
}
