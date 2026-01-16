{pkgs, ...}: {
  stylix = {
    enable = true;
    # base16Scheme = {
    #   base00 = "#090E13";
    #   base01 = "#393B44";
    #   base02 = "#A4A7A4";
    #   base03 = "#8ea4a2";

    #   base04 = "#c8c093";
    #   base05 = "#C5C9C7";
    #   base06 = "#C5C9C7";
    #   base07 = "#FFFFFF";

    #   base08 = "#c4746e";
    #   base09 = "#e6c384";
    #   base0A = "#c4b28a";
    #   base0B = "#8a9a7b";
    #   base0C = "#8ea4a2";
    #   base0D = "#8ba4b0";
    #   base0E = "#a292a3";
    #   base0F = "#b6927b";
    # };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    fonts = {
      serif = {
        package = pkgs.nerd-fonts.caskaydia-mono;
        name = "CaskaydiaMono Nerd Font Mono";
      };

      sansSerif = {
        package = pkgs.nerd-fonts.caskaydia-mono;
        name = "CaskaydiaMono Nerd Font Mono";
      };

      monospace = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 14;
        desktop = 10;
        terminal = 12;
      };
      # opacity = {
      #   applications = 0.7;
      #   desktop = 0.7;
      #   terminal = 0.7;
      # };
    };
  };
}
