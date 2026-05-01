{
  pkgs,
  lib,
  osConfig,
  config,
  ...
}: {
  programs =
    {
      fastfetch = {
        enable = true;
      };

      delta = {
        enable = true;
        enableGitIntegration = true;
      };

      password-store = {
        enable = true;
        package = pkgs.pass.withExtensions (exts: [exts.pass-otp]);
      };

      gh = {
        enable = true;
        gitCredentialHelper.enable = true;
        settings = {
          editor = "hx";
          git_protocol = "ssh";
        };
      };

      direnv = {
        # still not fixed
        package = pkgs.direnv.overrideAttrs (oldAttrs: {
          doCheck = false;
        });
        enable = true;
        enableNushellIntegration = true;
        silent = true;
        nix-direnv = {
          enable = true;
        };
      };

      gpg = {
        enable = true;
        mutableKeys = true;
        mutableTrust = true;
      };

      carapace = {
        enable = true;
        enableNushellIntegration = true;
      };

      lazygit = {
        enable = true;
        enableNushellIntegration = true;
      };

      nushell = {
        enable = true;
        package = pkgs.nushell;
        envFile.source = ./nushell/env.nu;
        configFile.source = ./nushell/config.nu;
        # plugins = [pkgs.nushellPlugins.highlight];
      };

      nh = {
        enable = true;
        flake = "${config.home.homeDirectory}/nix-config";
        clean = {
          enable = true;
        };
      };
    }
    // lib.optionalAttrs (!osConfig.isServer) {
      alacritty = {
        enable = true;
        settings = {
          general = {
            live_config_reload = true;
            ipc_socket = true;
          };
          window = {
            padding = {
              x = 12;
              y = 12;
            };
            decorations = "buttonless";
            opacity = lib.mkForce 0.7;
            blur = true;
            startup_mode = "Maximized";
            option_as_alt = "OnlyLeft";
          };
          cursor.style = {
            shape = "Beam";
            blinking = "On";
          };
        };
      };

      aerc = {
        enable = false;
        extraConfig = {
          general = {
            unsafe-accounts-conf = true;
          };
          ui = {
            styleset-name = "kanso";
            fuzzy-complete = true;
            icon-unencrypted = "";
            icon-encrypted = "✔";
            icon-signed = "✔";
            icon-signed-encrypted = "✔";
            icon-unknown = "✘";
            icon-invalid = "⚠";
            threading-enabled = true;
          };
          viewer = {
            always-show-mime = true;
          };
          compose = {
            editor = "${pkgs.helix}/bin/hx";
          };
          filters = {
            "text/plain" = "colorize";
            "text/calendar" = "calendar";
            "message/delivery-status" = "colorize";
            "message/rfc822" = "colorize";
            "text/html" = "${pkgs.w3m}/bin/w3m -T text/html -cols $COLUMNS -dump -o display_image=false -o display_link_number=true";
            ".headers" = "colorize";
          };
          hooks = {
            mail-received =
              if pkgs.stdenv.isDarwin
              then ''${pkgs.terminal-notifier}/bin/terminal-notifier -title "mail!/$AERC_ACCOUNT got mail" -message "from: $AERC_FROM_NAME — $AERC_SUBJECT"''
              else ''${pkgs.libnotify}/bin/notify-send "mail!/$AERC_ACCOUNT got mail" "from: $AERC_FROM — $AERC_SUBJECT"'';
          };
        };
        stylesets = {
          kanso = ''
            *.default=true
            title.reverse=true
            header.bold=true
            error.fg=#c4746e
            warning.fg=#c4b28a
            success.fg=#8a9a7b
            *error.bold=true
            statusline*.default=true
            statusline_default.reverse=true
            statusline_error.reverse=true
            completion_pill.reverse=true
            border.reverse=true
            selector_focused.reverse=true
            selector_chooser.bold=true
            *.selected.bg=#393B44
            *.fg=#C5C9C7
            statusline_default.fg=#C5C9C7
            statusline_default.bg=#090E13
            statusline_error.fg=#e46876
            statusline_error.bg=#090E13
            msglist_marked.bg=#7fb4ca
            msglist_flagged.fg=#8a9a7b
            msglist_flagged.bold=true
            msglist_unread.fg=#8ba4b0
            msglist_unread.selected.bg=#393b44
            msglist_unread.selected.fg=#c5c9c7
            tab.fg=#c8c093
            tab.bg=#090e13
            tab.selected.fg=#090e13
            tab.selected.bg=#c4b28a
            dirlist_unread.fg=#7fb4ca
            dirlist_recent.fg=#8ea4a2
          '';
        };
      };

      notmuch = {
        enable = true;
        new = {
          tags = ["new"];
          ignore = [".mbsyncstate" ".uidvalidity"];
        };
        search = {
          excludeTags = ["spam" "deleted"];
        };
        maildir = {
          synchronizeFlags = true;
        };
        hooks = {
          preNew = "${pkgs.isync}/bin/mbsync -a";
          postNew = ''
            ${pkgs.notmuch}/bin/notmuch tag +work -new -- tag:new and to:contact@pastaya.net
            ${pkgs.notmuch}/bin/notmuch tag +personal -new -- tag:new and to:pastaya@pastaya.net or to:me@pastaya.net
            ${pkgs.notmuch}/bin/notmuch tag +important -new -- tag:new and imapflag:flagged
            ${pkgs.notmuch}/bin/notmuch tag +github -- from:*@github.com
            ${pkgs.notmuch}/bin/notmuch tag -new -- tag:new
          '';
        };
      };

      mbsync = {
        enable = true;
      };

      msmtp = {
        enable = true;
      };

      qutebrowser = {
        package = null;
        enable = true;
        greasemonkey = [
          (pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/69df2b309eae2af18bb1d1ff1790f1d92d8e6a5d/youtube_shorts_block.js";
            sha256 = "09lfbqphdv78l44z1b2ryba46pz4srpyswpapmi86cl41d485nkv";
          })

          (pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/69df2b309eae2af18bb1d1ff1790f1d92d8e6a5d/youtube_sponsorblock.js";
            sha256 = "1ccqg60m4if1gdhq92v50sfpwz81l2a3r55iwjqgy738xmsml0wz";
          })

          (pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/69df2b309eae2af18bb1d1ff1790f1d92d8e6a5d/youtube_adblock.js";
            sha256 = "1mskjnprva2zcwkmdz0m8by7zj840i9c1i30mbgs6v69h9bgs803";
          })
        ];
        settings = {
          colors.webpage.darkmode.enabled = true;
          editor = {
            command = ["${pkgs.emacs}/bin/emacsclient" "-c" "+{line}:{column}" "{file}"];
          };
          content.pdfjs = true;
          scrolling.smooth = true;
        };
      };

      rio = {
        enable = true;
        settings = {
          confirm-before-quit = false;
          padding-x = 10;

          editor = {
            program = "${pkgs.helix}/bin/hx";
          };
          cursor = {
            shape = "beam";
            blinking = true;
          };
          navigation = {
            mode = "Plain";
          };
          shell = {
            program = "${pkgs.nushell}/bin/nu";
          };
          renderer = {
            fliters = [
              "fubax_br"
            ];
          };
          window = {
            opacity = lib.mkForce 0.7;
            blur = true;
            decorations = "Transparent";
            mode = "Maximized";
          };
          fonts = {
            size = lib.mkForce 12;
            bold = {
              weight = 600;
            };
            regular = {
              weight = 400;
            };
            italic = {
              weight = 400;
            };
            bold-italic = {
              weight = 600;
            };
          };
          platform = {
            macos = {
              option-as-alt = "left";
            };
          };
        };
      };
    };
}
