{...}: {
  services = {
    libinput.enable = true;

    displayManager.ly.enable = true;

    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" "intel" ];
    };

    flatpak.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };
    cloudflare-warp.enable = true;
  };

  xdg.portal.enable = true;

}
