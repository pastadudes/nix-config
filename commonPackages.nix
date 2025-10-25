{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    tree
    fastfetch
    nushell
    neovim
    helix # its time...
    rustup
    clang
    lazygit
    fd
    cmake
    python3
    chafa
    yazi
    nodejs
    lua-language-server
    rust-analyzer
    wgsl-analyzer
    vscode-langservers-extracted
    marksman
    taplo
    nil
    dotnet-sdk_9 # trying c# cuz why not
    csharp-ls
    git
    imgcat
    

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    fzf # A command-line fuzzy finder
    tlrc # too long didn't read
    asciinema # record terminal sessions (no idea why)
    just # for justfiles obviously
    yadm # for dotfiles (and idk how to use home-manager)
    gdu
    bottom
    zellij
    aerc
    translate-shell

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    lynx
    carapace

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    #iotop # io monitoring
    #iftop # network monitoring

    # system call monitoring
    #strace # system call monitoring
    #ltrace # library call monitoring
    #lsof # list open files

    # system tools
    #sysstat
    #lm_sensors # for `sensors` command
    #ethtool
    #pciutils # lspci
    #usbutils # lsusb

  ];
  # programs.fish.enable = true;
  nixpkgs.config.allowBroken = true;
}
