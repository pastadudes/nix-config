{...}: {
  programs.halloy = {
    enable = true;
    settings = {
      "buffer.channel.topic" = {
        enabled = true;
      };
      "servers.liberachat" = {
        channels = [
          "#halloy"
          "#general"
          "#helix"
          "#nixos"
        ];
        nickname = "pastaya";
        server = "irc.libera.chat";
      };
    };
  };
}
