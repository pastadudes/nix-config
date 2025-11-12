# i want flake.nix to atleast be like idk? 1.5 pages tall or long or whatever
{ ... }: {
  imports = [
    ./commonPackages.nix
    ./fonts.nix
    ./darwinPackages.nix
    ./darwinServices.nix
    ./users.nix
  ];

  security.pam.services.sudo_local.touchIdAuth = true; # touch id with sudo (if you couldn't tell)
}
