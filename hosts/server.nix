{...}: {
  networking.hostName = "pastaya";
  time.timeZone = "America/New_York";

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0";
}
