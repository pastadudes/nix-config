{pkgs, ...}: {
  services = {
    libinput.enable = true;

    displayManager.ly.enable = true;

    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" "intel" ];
    };

    flatpak.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };
    cloudflare-warp.enable = true;
  };

  xdg.portal.enable = true;
  # anything beyond that is best effort
  # no testing has been done
  systemd.user.services = {
    mbsync = {
      description = "sync mail with mbsync";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.isync}/bin/mbsync -a && ${pkgs.notmuch}/bin/notmuch new";
      };
      wantedBy = [ "default.target" ];
    };

    mailCleanup = {
      description = "cleanup emails";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = ''
          ${pkgs.notmuch}/bin/notmuch tag +archive -- "date:..30days ago"
          ${pkgs.notmuch}/bin/notmuch search "tag:archive" | \
          xargs -I {} ${pkgs.notmuch}/bin/notmuch insert --folder=~/mail!/Trash {}
        '';
      };
      wantedBy = [ "default.target" ];
    };
  };

  systemd.user.timers = {
    mbsync = {
      description = "run mbsync every 5 minutes";
      timerConfig = {
        OnBootSec = "1min";
        OnUnitActiveSec = "5min";
        Unit = "mbsync.service";
      };
      wantedBy = [ "timers.target" ];
    };

    mailCleanup = {
      description = "run mail cleanup every 30 days";
      timerConfig = {
        OnCalendar = "monthly";
        Persistent = true;
        Unit = "mailCleanup.service";
      };
      wantedBy = [ "timers.target" ];
    };
  };
}
