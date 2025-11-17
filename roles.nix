{lib, ...}: {
  options = {
    isServer = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "define if a config is a server or not";
    };
  };
}
