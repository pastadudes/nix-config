{...}: {
  networking.hostName = "t2nix";

  time.timeZone = "Europe/Berlin";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
