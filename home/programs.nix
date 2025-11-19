{pkgs, ...}: {
  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          email = "contact@pastaya.net";
          name = "pastaya";
        };

        # url = {
        #   "ssh://git@github.com" = {
        #     insteadOf = "https://github.com";
        #   };
        # };
        core = {
          editor = "hx";
        };
      };
      signing = {
        key = "BE7075D8224B7A628885C06D68B0CFDCFD40EA66";
        signByDefault = true;
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
    };

    helix = {
      defaultEditor = true;
      enable = true;
      settings = {
        # theme = "base16_transparent";
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
          args = ["--stdio"];
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
            if pkgs.stdenv.isDarwin
            then ''${pkgs.terminal-notifier}/bin/terminal-notifier -title "mail!/$AERC_ACCOUNT got mail" -message "from: $AERC_FROM_NAME — $AERC_SUBJECT"''
            else ''${pkgs.libnotify}/bin/notify-send "mail!/$AERC_ACCOUNT got mail" "from: $AERC_FROM — $AERC_SUBJECT"'';
        };
      };

      stylesets = {
        kanso = ''
          #
          # aerc "Kanso Zen" styleset
          #

          *.default=true

          title.reverse=true
          header.bold=true

          # basic semantic colors mapped from kanso:
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

          # backgrounds / foreground

          # global bg / fg
          *.selected.bg=#393B44        # selection background
          *.fg=#C5C9C7                 # primary foreground

          # statusline variants
          statusline_default.fg=#C5C9C7
          statusline_default.bg=#090E13

          statusline_error.fg=#e46876  # bright red
          statusline_error.bg=#090E13

          # message list

          msglist_marked.bg=#7fb4ca      # bright blue
          msglist_flagged.fg=#8a9a7b     # green
          msglist_flagged.bold=true

          msglist_unread.fg=#8ba4b0      # soft blue
          msglist_unread.selected.bg=#393b44
          msglist_unread.selected.fg=#c5c9c7

          # tabs

          tab.fg=#c8c093                # white-ish
          tab.bg=#090e13

          tab.selected.fg=#090e13
          tab.selected.bg=#c4b28a       # the soft yellow

          # directories

          dirlist_unread.fg=#7fb4ca
          dirlist_recent.fg=#8ea4a2
        '';
      };
    };
    # TODO: guard aganist server
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

        # colors = {
        #   # kanso zen alacritty colors
        #   # nixifed from kanso.nvim/extras
        #   primary = {
        #     background = "#090E13";
        #     foreground = "#C5C9C7";
        #   };

        #   normal = {
        #     black = "#090E13";
        #     red = "#c4746e";
        #     green = "#8a9a7b";
        #     yellow = "#c4b28a";
        #     blue = "#8ba4b0";
        #     magenta = "#a292a3";
        #     cyan = "#8ea4a2";
        #     white = "#c8c093";
        #   };

        #   bright = {
        #     black = "#A4A7A4";
        #     red = "#e46876";
        #     green = "#87a987";
        #     yellow = "#e6c384";
        #     blue = "#7fb4ca";
        #     magenta = "#938aa9";
        #     cyan = "#7aa89f";
        #     white = "#C5C9C7";
        #   };

        #   selection = {
        #     background = "#393B44";
        #     foreground = "#C5C9C7";
        #   };

        #   indexed_colors = [
        #     {
        #       index = 16;
        #       color = "#b6927b";
        #     }
        #     {
        #       index = 17;
        #       color = "#b98d7b";
        #     }
        #   ];
        # };
      };
    };

    zellij = {
      enable = true;
      settings = {
        # theme = "kanso";
        default_shell = "nu";
        web_server = true;
      };
      # lowkey too lazy to nixify it
      extraConfig = ''
        keybinds {
            locked {
                bind "Ctrl g" { SwitchToMode "normal"; }
            }
            session {
                bind "a" {
                    LaunchOrFocusPlugin "zellij:about" {
                        floating true
                        move_to_focused_tab true
                    }
                    SwitchToMode "locked"
                }
                bind "c" {
                    LaunchOrFocusPlugin "configuration" {
                        floating true
                        move_to_focused_tab true
                    }
                    SwitchToMode "locked"
                }
                bind "d" { Detach; }
                bind "o" { SwitchToMode "normal"; }
                bind "p" {
                    LaunchOrFocusPlugin "plugin-manager" {
                        floating true
                        move_to_focused_tab true
                    }
                    SwitchToMode "locked"
                }
                bind "w" {
                    LaunchOrFocusPlugin "session-manager" {
                        floating true
                        move_to_focused_tab true
                    }
                    SwitchToMode "locked"
                }
            }
            shared_among "normal" "locked" {
                bind "Alt Shift left" { MoveFocusOrTab "left"; }
                bind "Alt Shift down" { MoveFocus "down"; }
                bind "Alt Shift up" { MoveFocus "up"; }
                bind "Alt Shift right" { MoveFocusOrTab "right"; }
                bind "Alt Shift +" { Resize "Increase"; }
                bind "Alt Shift -" { Resize "Decrease"; }
                bind "Alt Shift =" { Resize "Increase"; }
                bind "Alt Shift [" { PreviousSwapLayout; }
                bind "Alt Shift ]" { NextSwapLayout; }
                bind "Alt Shift f" { ToggleFloatingPanes; }
                bind "Alt Shift h" { MoveFocusOrTab "left"; }
                bind "Alt Shift i" { MoveTab "left"; }
                bind "Alt Shift j" { MoveFocus "down"; }
                bind "Alt Shift k" { MoveFocus "up"; }
                bind "Alt Shift l" { MoveFocusOrTab "right"; }
                bind "Alt Shift n" { NewPane; }
                bind "Alt Shift o" { MoveTab "right"; }
            }
            shared_except "locked" "renametab" "renamepane" {
                bind "Ctrl g" { SwitchToMode "locked"; }
                bind "Ctrl q" { Quit; }
            }
            shared_except "locked" "entersearch" {
                bind "enter" { SwitchToMode "locked"; }
            }
            shared_except "locked" "entersearch" "renametab" "renamepane" {
                bind "esc" { SwitchToMode "locked"; }
            }
           shared_except "locked" "entersearch" "renametab" "renamepane" "move" {
                bind "m" { SwitchToMode "move"; }
            }
            shared_except "locked" "entersearch" "search" "renametab" "renamepane" "session" {
                bind "o" { SwitchToMode "session"; }
            }
            shared_except "locked" "tab" "entersearch" "renametab" "renamepane" {
                bind "t" { SwitchToMode "tab"; }
            }
            shared_except "locked" "tab" "scroll" "entersearch" "renametab" "renamepane" {
                bind "s" { SwitchToMode "scroll"; }
            }
            shared_among "normal" "resize" "tab" "scroll" "prompt" "tmux" {
                bind "p" { SwitchToMode "pane"; }
            }
            shared_except "locked" "resize" "pane" "tab" "entersearch" "renametab" "renamepane" {
                bind "r" { SwitchToMode "resize"; }
            }
        }
        plugins {
            about location="zellij:about"
            compact-bar location="zellij:compact-bar"
            configuration location="zellij:configuration"
            filepicker location="zellij:strider" {
                cwd "/"
            }
            plugin-manager location="zellij:plugin-manager"
            session-manager location="zellij:session-manager"
            status-bar location="zellij:status-bar"
            strider location="zellij:strider"
            tab-bar location="zellij:tab-bar"
            welcome-screen location="zellij:session-manager" {
                welcome_screen true
            }
        }
      '';

      # themes = {
      #   kanso = {
      #     themes = {
      #       kanso = {
      #         bg = "#090E13";
      #         fg = "#C5C9C7";
      #         red = "#C4746E";
      #         green = "#8A9A7B";
      #         blue = "#8BA4B0";
      #         yellow = "#C4B28A";
      #         magenta = "#A292A3";
      #         orange = "#B98D7B";
      #         cyan = "#8EA4A2";
      #         black = "#090E13";
      #         white = "#C5C9C7";
      #       };
      #     };
      #   };
      # };
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    starship = {
      enable = true;
      enableNushellIntegration = true;
      settings = {
        # mostly the plaintext thingy from the starship presets
        # success_symbol = "[>](bold green)";
        # error_symbol = "[x](bold red)";
        # vimcmd_symbol = "[<](bold green)";

        git_commit.tag_symbol = " tag ";

        git_status = {
          ahead = ">";
          behind = "<";
          diverged = "<>";
          renamed = "r";
          deleted = "x";
        };

        aws.symbol = "aws ";
        azure.symbol = "az ";
        buf.symbol = "buf ";
        bun.symbol = "bun ";
        c.symbol = "C ";
        cpp.symbol = "C++ ";
        cobol.symbol = "cobol ";
        conda.symbol = "conda ";
        container.symbol = "container ";
        crystal.symbol = "cr ";
        cmake.symbol = "cmake ";
        daml.symbol = "daml ";
        dart.symbol = "dart ";
        deno.symbol = "deno ";
        dotnet.symbol = ".NET ";
        directory.read_only = " ro";
        docker_context.symbol = "docker ";
        elixir.symbol = "exs ";
        elm.symbol = "elm ";
        fennel.symbol = "fnl ";
        fossil_branch.symbol = "fossil ";
        gcloud.symbol = "gcp ";
        git_branch.symbol = "git ";
        gleam.symbol = "gleam ";
        golang.symbol = "go ";
        gradle.symbol = "gradle ";
        guix_shell.symbol = "guix ";
        haskell.symbol = "haskell ";
        helm.symbol = "helm ";
        hg_branch.symbol = "hg ";
        java.symbol = "java ";
        julia.symbol = "jl ";
        kotlin.symbol = "kt ";
        lua.symbol = "lua ";
        nodejs.symbol = "nodejs ";
        memory_usage.symbol = "memory ";
        meson.symbol = "meson ";
        nats.symbol = "nats ";
        nim.symbol = "nim ";
        nix_shell.symbol = "nix ";
        ocaml.symbol = "ml ";
        opa.symbol = "opa ";

        os.symbols = {
          AIX = "aix ";
          Alpaquita = "alq ";
          AlmaLinux = "alma ";
          Alpine = "alp ";
          Amazon = "amz ";
          Android = "andr ";
          Arch = "rch ";
          Artix = "atx ";
          Bluefin = "blfn ";
          CachyOS = "cach ";
          CentOS = "cent ";
          Debian = "deb ";
          DragonFly = "dfbsd ";
          Emscripten = "emsc ";
          EndeavourOS = "ndev ";
          Fedora = "fed ";
          FreeBSD = "fbsd ";
          Garuda = "garu ";
          Gentoo = "gent ";
          HardenedBSD = "hbsd ";
          Illumos = "lum ";
          Kali = "kali ";
          Linux = "lnx ";
          Mabox = "mbox ";
          Macos = "mac ";
          Manjaro = "mjo ";
          Mariner = "mrn ";
          MidnightBSD = "mid ";
          Mint = "mint ";
          NetBSD = "nbsd ";
          NixOS = "nix ";
          Nobara = "nbra ";
          OpenBSD = "obsd ";
          OpenCloudOS = "ocos ";
          openEuler = "oeul ";
          openSUSE = "osuse ";
          OracleLinux = "orac ";
          Pop = "pop ";
          Raspbian = "rasp ";
          Redhat = "rhl ";
          RedHatEnterprise = "rhel ";
          RockyLinux = "rky ";
          Redox = "redox ";
          Solus = "sol ";
          SUSE = "suse ";
          Ubuntu = "ubnt ";
          Ultramarine = "ultm ";
          Unknown = "unk ";
          Uos = "uos ";
          Void = "void ";
          Windows = "win ";
        };

        package.symbol = "pkg ";
        perl.symbol = "pl ";
        php.symbol = "php ";
        pijul_channel.symbol = "pijul ";
        pixi.symbol = "pixi ";
        pulumi.symbol = "pulumi ";
        purescript.symbol = "purs ";
        python.symbol = "py ";
        quarto.symbol = "quarto ";
        raku.symbol = "raku ";
        rlang.symbol = "r ";
        ruby.symbol = "rb ";
        rust.symbol = "rs ";
        scala.symbol = "scala ";
        spack.symbol = "spack ";
        solidity.symbol = "solidity ";
        status.symbol = "[x](bold red) ";
        sudo.symbol = "sudo ";
        swift.symbol = "swift ";
        typst.symbol = "typst ";
        terraform.symbol = "terraform ";
        zig.symbol = "zig ";
      };
    };
    lazygit = {
      enable = true;
      enableNushellIntegration = true;
    };
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
      settings = {
        editor = "hx";
        git_protocol = "ssh";
      };
    };
    nix-your-shell = {
      enable = true;
      enableNushellIntegration = true;
    };
    direnv = {
      enable = true;
      enableNushellIntegration = true;
      silent = true;
      nix-direnv = {
        enable = true;
      };
    };
    # gpg = {
    #   enable = true;
    # };
  };
}
