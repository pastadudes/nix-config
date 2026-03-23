{pkgs, ...}: {
  system.stateVersion = 6;

  environment = {
    # this is so that fish gets added to /etc/shells
    shells = [
      pkgs.nushell
    ];

    # these are installed globally to /Applications/Nix Apps/
    systemPackages = with pkgs; [
      fish
      # taisei
      prismlauncher
      # everest-mons
      wireguard-tools
      harper
      # musescore
      # qemu
      # virt-manager
      inkscape
      # TODO: uhh migrate alot of homebrew casks to here
    ];
  };

  homebrew = {
    enable = true;
    # disabling quarantine would mean no stupid macOS do-you-really-want-to-open dialogs
    # caskArgs.no_quarantine = true;
    onActivation = {
      autoUpdate = true;
      # zap is a more thorough uninstall, ref: https://docs.brew.sh/Cask-Cookbook#stanza-zap
      cleanup = "zap";
      upgrade = true;
      extraFlags = ["--verbose"];
    };

    # taps to open, let packages rain
    taps = [
      "koekeishiya/formulae"
      "amar1729/formulae"
    ];

    brews = [
      "dart-sdk"
    ];

    casks = [
      "osu"
      "discord"
      "tetrio"
      "krita"
      "steam"
      "zoom"
      "whatsapp"
      "blender"
      "cloudflare-warp"
      "obs"
      "graalvm-jdk"
      "graalvm-jdk@17"
      "fluent-reader"
      "aldente"
      "raycast"
      "qbittorrent"
      "gimp"
      "vlc"
      "Macs-Fan-Control"
      "kdenlive"
      "wine@staging"
      "flutter"
      # "dart-sdk"
    ];
  };
}
