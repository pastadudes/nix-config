{pkgs, ...}: {
  fonts.packages = with pkgs; [
    nerd-fonts.bigblue-terminal
    nerd-fonts.mononoki
    nerd-fonts.caskaydia-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.blex-mono
    noto-fonts-cjk-sans
  ];
}
