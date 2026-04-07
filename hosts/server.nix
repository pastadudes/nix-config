{config, ...}: {
  config = {
    networking.hostName = "pastaya";
    time.timeZone = "America/New_York";

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
        8082
        2055
        25565
        25566
      ];
    };

    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0";
    isServer = true;
    nixpkgs.config.allowUnfree = true;
  };
}
