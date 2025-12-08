{
  pkgs,
  lib,
  osConfig,
  inputs,
  ...
}: {
  imports =
    [
      ./programs.nix
      ./email.nix
    ]
    ++ lib.optionals (!osConfig.isServer) [./services.nix inputs.nixcord.homeModules.nixcord];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "pastaya";
    homeDirectory =
      if pkgs.stdenv.isDarwin
      then "/Users/pastaya"
      else "/home/pastaya";

    packages = with pkgs; [
      rusty-man
      bat
    ];

    shell = {
      enableNushellIntegration = true;
    };

    shellAliases = {
      icat = "chafa";
      lg = "lazygit";
      ".." = "cd ../";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      "....." = "cd ../../../../";
    };

    stateVersion = "25.05";
  };
}
