{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkMerge [
  (lib.mkIf pkgs.stdenv.isDarwin {
    security.pam.services.sudo_local.touchIdAuth = true;
  })

  (lib.mkIf pkgs.stdenv.isLinux {
    security.sudo.enable = true;
    security.sudo.configFile = "%wheel ALL=(ALL:ALL) SETENV: ALL";
  })

  (lib.mkIf config.isServer {
    networking.firewall.allowedTCPPorts = [80 443 8082 25565 25566];
  })
]
