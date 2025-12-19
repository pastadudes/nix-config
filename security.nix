{...}: let
  isLinux = builtins.pathExists "/etc/nixos";
  isDarwin = !isLinux;

  darwinOptions = {
    security.pam.services.sudo_local.touchIdAuth = true;
  };

  linuxOptions = {
    security.sudo.enable = true;
    security.sudo.configFile = "%wheel ALL=(ALL:ALL) SETENV: ALL";
  };
in
  if isLinux
  then linuxOptions
  else if isDarwin
  then darwinOptions
  else {}
