{...}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-users = ["pastaya"];
  system.stateVersion = 6;
}
