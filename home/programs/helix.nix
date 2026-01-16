{pkgs, ...}: {
  programs.helix = {
    defaultEditor = false;
    enable = true;
    settings = {
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
      language-server = {
        harper-ls = {
          command = "${pkgs.harper}/bin/harper-ls";
          args = ["--stdio"];
        };
        deno-lsp = {
          command = "${pkgs.deno}/bin/deno";
          args = ["lsp"];
        };
        # csharp-ls = {
        #   command = "${pkgs.csharp-ls}/bin/csharp-ls";
        # };
      };
      language = [
        {
          name = "markdown";
          scope = "text.markdown";
          file-types = ["txt" "eml" "md"];
          language-servers = ["harper-ls" "marksman"];
        }
        {
          name = "typescript-deno";
          scope = "source.ts";
          roots = ["deno.json"];
          file-types = ["js" "jsx" "ts" "tsx"];
          language-servers = ["deno-lsp"];
        }
        # {
          # name = "c-sharp";
          # scope = "source.csharp";
          # injection-regex = "c-?sharp";
          # file-types = ["cs" "csx" "cake"];
          # roots = ["sln" "csproj"];
          # # comment-tokens = ["//" "///"];
          # # block-comment-tokens = { start = "/*"; end = "*/"; };
          # indent = { tab-width = 4; unit = "\\t"; };
          # language-servers = ["csharp-ls"];
        # }
      ];
    };
  };
}
