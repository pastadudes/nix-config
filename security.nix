{...}: {
  security = {
     sudo.enable = true;
     sudo.configFile = "%wheel ALL=(ALL:ALL) SETENV: ALL";
  };
}
