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
        typescript-mode
        treesit-auto
        kotlin-ts-mode
        envrc
        avy
        marginalia
        embark
        embark-consult
        tempel
        tempel-collection
        haskell-mode
        fsharp-mode
        eglot-fsharp
      ];
  };
  home.file.".emacs.d" = {
    enable = true;
    source = ./.;
    recursive = true;
  };
}
