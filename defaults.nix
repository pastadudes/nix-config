# defaults.nix
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
    ++ lib.optionals pkgs.stdenv.isDarwin [
      ./darwinPackages.nix
      ./darwinServices.nix
    ];
}
