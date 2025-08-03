{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    firefox
    fuzzel
    hyprpaper
    hyprpicker
    easyeffects
    hyprlock
    dunst
    hyprpolkitagent
    udiskie
    lua51Packages.lua
    luarocks
    xwayland-satellite
    # ladspaPlugins
    # calf
    # lsp-plugins
    # alsa-lib

    # ONLY ENABLE THE ABOVE WHEN PIPEWIRE_SINK_CONF.NIX WORKS!!!!
    remmina
    git-credential-oauth
    anydesk
    pass
    gnupg
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    # vesktop
    discord
    vencord
    overlayed
    ckan

    # games
    prismlauncher
    tetrio-desktop
    osu-lazer-bin
    taisei

    # terminal emulator
    foot

    # wayland utilities
    # grimblast
    pwvucontrol
    cliphist
    wl-clipboard
    wlogout
    waybar

    # drawing
    krita

    # graphics
    intel-media-driver
];
  # services.xserver.desktopManager.xterm.enable = false;
  services.xserver.excludePackages = [ pkgs.xterm ];
  programs.firefox.enable = true;
  programs.niri.enable = true;
  programs.gamemode.enable = true;
  nixpkgs.config.allowUnfree = true;
  programs.gnupg.agent.enable = true;
}

