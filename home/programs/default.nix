{
  osConfig,
  lib,
  ...
}: {
  imports =
    [
      ./git.nix
      ./helix.nix
      ./starship.nix
      ./emacs
      ./iamb.nix
    ]
    ++ lib.optionals (!osConfig.isServer) [
      ./vesktop.nix
      ./zellij.nix
      ./zed.nix
      ./halloy.nix
    ];
}
