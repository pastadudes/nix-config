{...}: {
  programs.emacs = {
    enable = true;
    extraPackages = epkgs:
      with epkgs; [
        magit
        magit-delta
        which-key
        rust-mode
        nix-ts-mode
        corfu
        kind-icon
        cape
        notmuch
        vertico
        consult
        orderless
        vterm
        # typescript-mode
        treesit-auto
        # kotlin-ts-mode
        envrc
        avy
        marginalia
        embark
        embark-consult
        yasnippet
        haskell-mode
        # fsharp-mode
        # eglot-fsharp
        # scala-mode
        dart-mode
      ];
  };
  home.file.".emacs.d" = {
    enable = true;
    source = ./.;
    recursive = true;
  };
}
