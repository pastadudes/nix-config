{config, ...}: {
  config = {
    networking.hostName = "nixos-vm";

    time.timeZone = "Europe/Berlin";
    isServer = false;

    boot = {
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;
      # i forgot what this is for, maybe gamecube controllers?
      initrd.services.udev.rules = ''
        SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
      '';
    };

    hardware.opentabletdriver.enable = true;

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    networking.firewall = {
      enable = true;
    };
  };
}
