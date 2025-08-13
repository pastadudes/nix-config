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
      "browserpass"
    ];

    casks = [
      "librewolf"
      "osu"
      "discord"
      "thunderbird"
      "tetrio"
      "krita"
    ];
  };
}
