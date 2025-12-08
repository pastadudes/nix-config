# i want flake.nix to atleast be like idk? 1.5 pages tall or long or whatever
{...}: {
  imports = [
    ./common.nix
    ./security.nix
    ./commonPackages.nix
    ./fonts.nix
    ./darwinPackages.nix
    ./darwinServices.nix
    ./users.nix
    ./roles.nix
    ./stylix.nix
  ];
}
