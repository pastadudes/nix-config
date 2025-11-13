{
  pkgs,
  ...
}:
{
  imports = [
    ./programs.nix
    ./email.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Set user-specific configurations based on the system type
  home = {
    username = "pastaya";
    homeDirectory = if pkgs.stdenv.isDarwin then "/Users/pastaya" else "/home/pastaya";

    # pkgs = with pkgs; [
    #   alacritty
    # ];

    stateVersion = "25.05";
  };
}
