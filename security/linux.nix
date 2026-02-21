{...}: {
  security.sudo.enable = true;
  security.sudo.configFile = "%wheel ALL=(ALL:ALL) SETENV: ALL";
}
