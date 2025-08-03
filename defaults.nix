# i want flake.nix to atleast be like idk? 1.5 pages tall or long or whatever
{ ...}: {
  imports = [
    ./commonPackages.nix
    ./users.nix
    ./common.nix
    ./security.nix
    ./fonts.nix
  ];
}
