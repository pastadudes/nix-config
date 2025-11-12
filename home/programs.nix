{
  pkgs,
  ...
}:

{
  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          email = "contact@pastaya.net";
          name = "pastaya";
        };

        url = {
          "ssh://git@github.com" = {
            insteadOf = "https://github.com/";
          };

        };

      };
      signing = {
        key = "BE7075D8224B7A628885C06D68B0CFDCFD40EA66";
        signByDefault = true;
      };

    };

    helix = {
      defaultEditor = true;
      enable = true;
      settings = {
        theme = "base16_transparent";
        editor = {
          line-number = "relative";
          indent-guides.render = true;
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
        };
        keys = {
          normal = {
            C-x = ":reset-diff-change";
            space = {
              q = ":quit";
              x = ":x";
            };
          };
        };
      };
      languages = {
        language-server.harper-ls = {
          command = "${pkgs.harper}/bin/harper-ls";
          args = [ "--stdio" ];
        };
        language = [
          {
            name = "markdown";
            scope = "text.markdown";
            file-types = [
              "txt"
              "eml"
              "md"
            ];
            language-servers = [
              "harper-ls"
              "marksman"
            ];
          }
        ];
      };
    };
  };
}
