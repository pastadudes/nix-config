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
            insteadOf = "https://github.com";
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

    notmuch = {
      enable = true;
      new = {
        tags = [ "new" ];
        ignore = [ ".mbsyncstate" ".uidvalidity" ];
      };
      search = {
        excludeTags = [ "spam" "deleted" ];
      };
      maildir = {
        synchronizeFlags = true;
      };
      hooks = {
        preNew = "${pkgs.isync}/bin/mbsync -a";
        postNew = ''
          # basic email flitering
          ${pkgs.notmuch}/bin/notmuch tag +work -new -- tag:new and to:contact@pastaya.net
          ${pkgs.notmuch}/bin/notmuch tag +personal -new -- tag:new and to:pastaya@pastaya.net or to:me@pastaya.net
          ${pkgs.notmuch}/bin/notmuch tag +important -new -- tag:new and imapflag:flagged
          
          # tag emails from SOME senders
          ${pkgs.notmuch}/bin/notmuch tag +github -- from:*@github.com
          
          # finir
          ${pkgs.notmuch}/bin/notmuch tag -new -- tag:new
        '';
      };
    };

    # mbsync for syncing email
    mbsync = {
      enable = true;
    };

    # # msmtp for sending email
    msmtp = {
      enable = true;
    };

    # aerc with notmuch backend
    aerc = {
      enable = true;
      
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
            if pkgs.stdenv.isDarwin then
              ''${pkgs.terminal-notifier}/bin/terminal-notifier -title "mail!/$AERC_ACCOUNT got mail" -message "from: $AERC_FROM_NAME — $AERC_SUBJECT"''
            else
              ''${pkgs.libnotify}/bin/notify-send "mail!/$AERC_ACCOUNT got mail" "from: $AERC_FROM — $AERC_SUBJECT"'';
        };
      };

      stylesets = {
        Nord = ''
          #
          # aerc nord styleset
          #

          *.default=true

          title.reverse=true
          header.bold=true

          *error.bold=true
          error.fg=red
          warning.fg=yellow
          success.fg=green

          statusline*.default=true
          statusline_default.reverse=true
          statusline_error.reverse=true

          completion_pill.reverse=true

          border.reverse = true

          selector_focused.reverse=true
          selector_chooser.bold=true

          # Colors: Nord

          *.selected.bg=#090e13

          msglist_marked.bg=#81a1c1
          msglist_flagged.fg=#a3be8c
          msglist_flagged.bold=true

          msglist_unread.fg=#8fbcbb
          msglist_unread.selected.bg=#88C0D0

          statusline_default.fg=#49576b
          statusline_error.fg=#94545d

          tab.fg=#ff9a00
          tab.bg=#49576b
          tab.selected.bg=#64A6B3
          tab.selected.fg=#2c3441

          dirlist_unread.fg=#64A6B3
          dirlist_recent.fg=#64A6B3
        '';

        kanso = ''
          #
          # aerc "Kanso Zen" styleset
          # matches your Alacritty Kanso Zen colors
          #

          *.default=true

          title.reverse=true
          header.bold=true

          # Basic semantic colors mapped from Kanso:
          error.fg=#c4746e       # red
          warning.fg=#c4b28a     # yellow
          success.fg=#8a9a7b     # green
          *error.bold=true

          statusline*.default=true
          statusline_default.reverse=true
          statusline_error.reverse=true

          completion_pill.reverse=true
          border.reverse=true

          selector_focused.reverse=true
          selector_chooser.bold=true

          # -----------------------------------------
          # Backgrounds / Foreground
          # -----------------------------------------

          # global bg / fg
          *.selected.bg=#393B44        # selection background
          *.fg=#C5C9C7                 # primary foreground

          # statusline variants
          statusline_default.fg=#C5C9C7
          statusline_default.bg=#090E13

          statusline_error.fg=#e46876  # bright red
          statusline_error.bg=#090E13

          # -----------------------------------------
          # Message List
          # -----------------------------------------

          msglist_marked.bg=#7fb4ca      # bright blue
          msglist_flagged.fg=#8a9a7b     # green
          msglist_flagged.bold=true

          msglist_unread.fg=#8ba4b0      # soft blue
          msglist_unread.selected.bg=#393B44
          msglist_unread.selected.fg=#C5C9C7

          # -----------------------------------------
          # Tabs
          # -----------------------------------------

          tab.fg=#c8c093                # white-ish
          tab.bg=#090E13

          tab.selected.fg=#090E13
          tab.selected.bg=#c4b28a       # the soft yellow

          # -----------------------------------------
          # Directories
          # -----------------------------------------

          dirlist_unread.fg=#7fb4ca
          dirlist_recent.fg=#8ea4a2
        '';
      };
    };
    alacritty = {
      enable = true;
        settings = {
        # its safe to have darwin specific configs on alacritty
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
          opacity = 0.7;
          blur = true;               
          startup_mode = "Maximized";
          option_as_alt = "OnlyLeft";
        };

        font.normal = {
          family = "BigBlueTermPlus Nerd Font";
          style = "Regular";
        };

        cursor.style = {
          shape = "Beam";
          blinking = "On";
        };
      };
    };
  };
}
