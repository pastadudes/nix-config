{...}: {
  networking.hostName = "t2nix";

  time.timeZone = "Europe/Berlin";

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    initrd.services.udev.rules = ''
      SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
    '';

    kernelParams = [
      "quiet"
      "intel_iommu=on"
      "iommu=pt"
      "pcie_ports=native"
    ];
  };

  hardware.opentabletdriver.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  networking.firewall = {
    enable = true;
  };

  hardware.apple-t2.firmware.enable = true;


  # hardware.firmware = [
  #   (pkgs.stdenvNoCC.mkDerivation (final: {
  #     name = "brcm-firmware";
  #     src = ../firmware/brcm; # t2.nix is in the hosts/ folder
  #     installPhase = ''
  #       mkdir -p $out/lib/firmware/brcm
  #       cp ${final.src}/* "$out/lib/firmware/brcm"
  #     '';
  #   }))
  # ];
}
