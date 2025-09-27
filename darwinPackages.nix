{ pkgs, ... }: {
  system.stateVersion = 6;

  environment = {
    # this is so that fish gets added to /etc/shells
    shells = [
      pkgs.fish
    ];

    # these are installed globally to /Applications/Nix Apps/
    systemPackages = with pkgs; [
      fish
      iterm2
      taisei
      prismlauncher
      wireguard-tools
      # TODO: uhh migrate alot of homebrew casks to here
    ];
  };

  homebrew = {
    enable = true;
    # disabling quarantine would mean no stupid macOS do-you-really-want-to-open dialogs
    caskArgs.no_quarantine = true;
    onActivation = {
      autoUpdate = true;
      # zap is a more thorough uninstall, ref: https://docs.brew.sh/Cask-Cookbook#stanza-zap
      cleanup = "zap";
      upgrade = true;
      extraFlags = [ "--verbose" ];
    };

    # taps to open, let packages rain
    taps = [
      "koekeishiya/formulae"
      "amar1729/formulae"
    ];

    # `brew list <>` can help pinpoint package name
    # for both ordinary packages and casks
    brews = [
      "pass"
      "supertux"
      "browserpass"
      "pass-git-helper"
      "pinentry-mac"
      "qemu"
      "virt-manager"
      "mesa"
      "monero"
      "docker"
    ];

    casks = [
      "librewolf"
      "osu"
      "discord"
      "thunderbird"
      "tetrio"
      "krita"
      "steamcmd"
      "steam"
      "superTuxKart"
      "zoom"
      "whatsapp"
      "blender"
      "cloudflare-warp"
      "obs"
      "graalvm-jdk"
      "graalvm-jdk@17"
      "fluent-reader"
      "monero-wallet"
      "aldente"
      "raycast"
      # "ollama"
      #! commented this because for some fuckass reason it always uninstalls itself and i have to rebuild again for it to install
      "qbittorrent"
      "roblox" # im sorry guys my friend just HAD to force me to play roblox with them
      "mullvad-vpn"
      "gimp"
      "docker-desktop"
      "vlc"
      "Macs-Fan-Control"
    ];
  };
}
