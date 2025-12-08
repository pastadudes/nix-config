# i want flake.nix to atleast be like idk? 1.5 pages tall or long or whatever
{
  lib,
  pkgs,
  ...
}: {
  imports =
    [
      ./commonPackages.nix
      ./users.nix
      ./common.nix
      ./security.nix
      ./fonts.nix
      ./roles.nix
      ./stylix.nix
    ]
    ++ lib.optional pkgs.stdenv.isDarwin [
      ./darwinPackages.nix
      ./darwinServices.nix
    ];
}
