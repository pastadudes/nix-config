{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    pfetch
  ];

  virtualisation.docker.enable = true;
}
