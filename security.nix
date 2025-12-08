{
  config,
  lib,
  pkgs,
  ...
}:
{
  security =
    {
    }
    // lib.optionalAttrs pkgs.stdenv.isDarwin {
      pam.services.sudo_local.touchIdAuth = true; # touch id with sudo (if you couldn't tell)
    }
    // lib.optionalAttrs pkgs.stdenv.isLinux {
      sudo.enable = true;
      sudo.configFile = "%wheel ALL=(ALL:ALL) SETENV: ALL";
    };
}
// lib.optionalAttrs config.isServer {
  networking.firewall.allowedTCPPorts = [80 443 8082 25565 25566];
}
