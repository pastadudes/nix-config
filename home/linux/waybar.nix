{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
    };
    settings = {
      layer = "top";
      position = "top";
      height = 30;
      output = [
        "eDP-1"
      ];

      # basic for NOW
      modules-center = [ "systemd-failed-units" ];
    };
  };
}
