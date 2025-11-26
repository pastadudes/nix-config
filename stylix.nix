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
        package = pkgs.nerd-fonts.bigblue-terminal;
        name = "BigBlueTermPlus Nerd Font";
      };

      sansSerif = {
        package = pkgs.nerd-fonts.bigblue-terminal;
        name = "BigBlueTermPlus Nerd Font";
      };

      monospace = {
        package = pkgs.nerd-fonts.bigblue-terminal;
        name = "BigBlueTermPlus Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
