{...}: {
  security = {
     sudo.enable = true;
     sudo.configFile = "%wheel ALL=(ALL:ALL) SETENV: ALL";
  };

 networking.firewall.allowedTCPPorts = [ 80 443 8082 ];
}
