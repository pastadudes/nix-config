{pkgs, ...}: {
  programs.niri = {
    enable = true;
    settings = {
      layout = {
        gaps = 12;
      };
      binds = {
        "Mod+Return".action.spawn = ["${pkgs.j4-dmenu-desktop}/bin/j4-dmenu-desktop" "--dmenu=${pkgs.bemenu}/bin/bemenu"];
        "Mod+Q".action.close-window = [];
        "Mod+Shift+S".action.screenshot = [];
        "Print".action.screenshot-screen = [];
        "Mod+Print".action.screenshot-window = [];
      };
    };
  };
}
