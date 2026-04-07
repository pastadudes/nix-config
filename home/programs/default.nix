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
    ]
    ++ lib.optionals (!osConfig.isServer) [
      ./vesktop.nix
      ./zellij.nix
      ./zed.nix
      ./emacs
    ];
}
