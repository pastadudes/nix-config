# i want flake.nix to atleast be like idk? 1.5 pages tall or long or whatever
{ ...}: {
  imports = [
    ./commonPackages.nix
    ./fonts.nix
    ./darwinPackages.nix
  ];
}
