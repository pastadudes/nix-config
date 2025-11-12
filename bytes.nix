{ pkgs, ... }:
{
  users.users.bytes = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIImB712+perbBafcMDECVZAKzY6rWNmQm1Sty2hFp2Eq pastaya@t2nix"
    ];
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "input"
      "audio"
      "flatpak"
      "docker"
    ];

    packages = with pkgs; [
      # bytes add your things here DO NOT USE "nix profile install" or "nix-env"
      nmap # after you added your packages run "sudo nixos-rebuild switch --flake /home/pastaya/nix-config#server"
    ];
  };
  programs.zsh.enable = true; # PLEASE DISABLE IF YOU SWITCH FROM ZSH TO ANY OTHER SHELL
}
