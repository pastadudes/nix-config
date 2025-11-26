{
  pkgs,
  lib,
  osConfig,
  config,
  ...
}: {
  programs =
    {
      # Always enabled
      git = {
        enable = true;
        settings = {
          user = {
            email = "contact@pastaya.net";
            name = "pastaya";
          };
          core = {
            editor = "${pkgs.helix}/bin/hx";
          };
          alias = {
            a  = "add";
            aa = "add -A";
            ci = "commit";
            cl = "clone";
            co = "checkout";
            d  = "diff";
            dc = "diff --cached";
            st = "status";
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
              file-types = ["txt" "eml" "md"];
              language-servers = ["harper-ls" "marksman"];
            }
          ];
        };
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

      starship = {
        enable = true;
        enableNushellIntegration = true;
        settings = {
          # mostly the plaintext thingy from the starship presets
          character = {
            success_symbol = "[>](bold green)";
            error_symbol = "[x](bold red)";
            vimcmd_symbol = "[<](bold green)";
          };

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

      nushell = {
        enable = true;
        package = pkgs.nushell;
        envFile.source = ./nushell/env.nu;
        configFile.source = ./nushell/config.nu;
        plugins = [ pkgs.nushellPlugins.highlight ];
        shellAliases = {
          # broken
          gl = ''
            git log --pretty=%h»¦«%aN»¦«%s»¦«%aD | lines | split column "»¦«" sha1 committer desc merged | first 10
          '';
        };
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

      zellij = {
        enable = true;
        settings = {
          default_shell = "nu";
          web_server = true;
        };
        extraConfig = ''
          keybinds {
              locked {
                  bind "Ctrl g" { SwitchToMode "normal"; }
              }
              session {
                  bind "a" {
                      LaunchOrFocusPlugin "zellij:about" { floating true; move_to_focused_tab true; }
                      SwitchToMode "locked"
                  }
                  bind "c" {
                      LaunchOrFocusPlugin "configuration" { floating true; move_to_focused_tab true; }
                      SwitchToMode "locked"
                  }
                  bind "d" { Detach; }
                  bind "o" { SwitchToMode "normal"; }
                  bind "p" {
                      LaunchOrFocusPlugin "plugin-manager" { floating true; move_to_focused_tab true; }
                      SwitchToMode "locked"
                  }
                  bind "w" {
                      LaunchOrFocusPlugin "session-manager" { floating true; move_to_focused_tab true; }
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
              shared_except "locked" "entersearch" "renametab" "renamepane" "session" {
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
              filepicker location="zellij:strider" { cwd "/"; }
              plugin-manager location="zellij:plugin-manager"
              session-manager location="zellij:session-manager"
              status-bar location="zellij:status-bar"
              strider location="zellij:strider"
              tab-bar location="zellij:tab-bar"
              welcome-screen location="zellij:session-manager" { welcome_screen true; }
          }
        '';
      };
      qutebrowser = {
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

      nixcord = {
        enable = true;
        discord = {
          enable = true;
          vencord.enable = false;
          equicord.enable = true;
        };
        config = {
          autoUpdate = true;
          autoUpdateNotification = true;
          transparent = true;
          useQuickCss = true;

          plugins = {
            usrbg = {
              enable = true;
            };

            alwaysExpandRoles.enable = true;

            animalese = {
              enable = true;
            };
            anonymiseFileNames = {
              enable = true;
              anonymiseByDefault = false;
            };
            betterAudioPlayer = {
              enable = true;
              # derived from `.angled-header h1` from pastaya.net
              # original hex color `#ffaf00`
              oscilloscopeColor = "255, 175, 0"; # nixcord why isn't this a list?
            };
            betterBlockedUsers.enable = true;
            betterCommands = {
              enable = true;
            };

            betterGifAltText.enable = true;
            betterGifPicker.enable = true;
            betterInvites.enable = true;
            betterPlusReacts.enable = true;

            betterQuickReact = {
              enable = true;
            };
            betterRoleContext = {
              enable = true;
            };
            betterRoleDot = {
              enable = true;
            };
            betterSessions = {
              enable = true;
            };
            betterSettings = {
              enable = true;
            };

            betterUploadButton.enable = true;
            biggerStreamPreview.enable = true;

            blockKeywords = {
              enable = true;
              # TW: very bad words, sorry! i don't mean anything here!
              # yo codeberg pls don't ban me
              blockedWords = ''
                (?i)\btroo(n|nie|ny|ns|m)\b,
                (?i)i['’` ]?m\s+maga,
                (?i)\bnigg(a|er|ers)?\b,
                (?i)\bfag(got|gots|s)?\b,
                (?i)\bretard(s|ed|ing)?\b
              '';
              useRegex = true;
            };
            callTimer = {
              enable = true;
            };
            characterCounter = {
              enable = true;
            };

            clearURLs.enable = true;

            clipsEnhancements = {
              enable = true;
            };
            commandPalette = {
              enable = false;
              visualStyle = "polished";
            };
            consoleJanitor = {
              enable = true;
            };

            copyFileContents.enable = true;
            copyStickerLinks.enable = true;
            copyUserURLs.enable = true;

            customTimestamps = {
              enable = true;
            };
            dearrow = {
              enable = true;
            };
            decodeBase64 = {
              enable = true;
            };

            decor.enable = true;
            dontFilterMe.enable = true;

            exportMessages = {
              enable = true;
              exportContacts = true;
            };

            expressionCloner.enable = true;
            f8Break.enable = true;

            fakeNitro = {
              enable = true;
            };
            fakeProfileThemes = {
              enable = true;
            };

            favoriteEmojiFirst.enable = true;

            favoriteGifSearch = {
              enable = true;
            };
            findReply = {
              enable = true;
              includeAuthor = true;
              includePings = true;
            };

            fixCodeblockGap.enable = true;
            fixFileExtensions.enable = true;
            fixImagesQuality.enable = true;

            fixSpotifyEmbeds = {
              enable = true;
            };

            fixYoutubeEmbeds.enable = true;

            followVoiceUser = {
              enable = true;
            };
            fontLoader = {
              enable = true;
            };

            forceOwnerCrown.enable = true;
            frequentQuickSwitcher.enable = true;
            friendCloud.enable = true;
            friendInvites.enable = true;

            friendTags = {
              enable = false; # maybe???
            };

            friendsSince.enable = true;
            friendshipRanks.enable = true;
            fullSearchContext.enable = true;

            gameActivityToggle = {
              enable = true;
            };
            gensokyoRadioRpc = {
              enable = true;
            };
            ghosted = {
              enable = true;
              scary = true;
            };

            gifPaste.enable = true;

            gitHubRepos = {
              enable = true;
            };
            globalBadges = {
              enable = true;
            };
            googleThat = {
              enable = true;
              defaultEngine = "LetMeGoogleThatForYou";
            };
            greetStickerPicker = {
              enable = true;
            };
            guildPickerDumper.enable = true;
            imageFilename = {
              enable = true;
              showFullUrl = true;
            };
            imageZoom = {
              enable = true;
              nearestNeighbour = true;
              # giant lens size for not seeing the lens
              size = 5000.0;
            };
            imgToGif.enable = true;
            implicitRelationships = {
              enable = true;
            };
            inviteDefaults = {
              enable = true;
            };
            ircColors = {
              enable = true;
              # color is used to identify perms in servers quickly
              applyColorOnlyInDms = true;
            };

            jumpTo.enable = true;
            keepCurrentChannel.enable = true;

            keyboardNavigation = {
              enable = false;
            };
            keyboardSounds = {
              enable = true; # might turn this off lw
              soundPack = "osu";
            };
            memberCount = {
              enable = true;
            };
            mentionAvatars = {
              enable = true;
            };
            messageBurst = {
              enable = true;
              shouldMergeWithAttachment = true;
            };
            messageClickActions = {
              enable = true;
            };

            messageColors.enable = true;

            messageFetchTimer = {
              enable = true;
            };
            messageLatency = {
              enable = true;
              showMillis = true;
            };
            messageLinkEmbeds = {
              enable = true;
            };
            messageLogger = {
              enable = true;
              collapseDeleted = true;
            };

            messageLoggerEnhanced.enable = true;

            messageTranslate = {
              enable = true;
            };

            moreCommands.enable = true;
            moreKaomoji.enable = true;

            moreStickers = {
              enable = true;
            };

            moreUserTags.enable = true;
            musicControls.enable = true;
            mutualGroupDMs.enable = true;
            noNitroUpsell.enable = false; # risky...
            noOnboardingDelay.enable = true;
            noTypingAnimation.enable = true;
            noUnblockToJump.enable = true;
            normalizeMessageLinks.enable = true;

            notificationTitle.enable = true;
            onePingPerDM = {
              enable = true;
            };

            pauseInvitesForever.enable = true;

            permissionsViewer = {
              enable = true;
            };
            platformIndicators = {
              enable = true;
            };
            quickReply = {
              enable = true;
            };

            reactErrorDecoder.enable = true;
            readAllNotificationsButton.enable = true;

            # i swear im not weird its only for servers i get booted off
            relationshipNotifier = {
              enable = true;
              friends = false;
              notices = true;
            };
            replaceGoogleSearch = {
              enable = true;
              customEngineName = "DuckDuckGo";
              customEngineUrl = "https://duckduckgo.com/search?q=";
            };

            replyTimestamp.enable = true;
            reverseImageSearch.enable = true;
            reviewDB.enable = true;

            sekaiStickers = {
              enable = true;
            };
            sendTimestamps = {
              enable = true;
            };
            serverInfo = {
              enable = true;
            };
            serverListIndicators = {
              enable = true;
            };

            serverSearch.enable = true;

            shikiCodeblocks = {
              enable = true;
              bgOpacity = 80.0;
              useDevIcon = "COLOR";
            };
            showConnections = {
              enable = true;
            };
            showHiddenChannels = {
              enable = true;
            };

            showHiddenThings.enable = true;
            showMessageEmbeds.enable = true;

            silentMessageToggle = {
              enable = true;
            };
            # not even a huge fan of streaming services or even music in general
            songLink = {
              enable = true;
            };
            splitLargeMessages = {
              enable = true;
            };
            spotifyCrack = {
              enable = true;
            };

            startupTimings.enable = true;
            talkInReverse.enable = true;
            tiktokTts.enable = true;

            toneIndicators = {
              enable = true;
            };

            tosuRpc.enable = true;

            typingIndicator = {
              enable = true;
            };
            typingTweaks = {
              enable = true;
            };

            unindent.enable = true;

            unitConverter = {
              enable = true;
              myUnits = "metric"; # ew im not an american
            };
            universalMention = {
              enable = true;
            };

            validReply.enable = true;
            validUser.enable = true;

            viewRaw = {
              enable = true;
            };
            voiceMessages = {
              enable = true;
            };

            webRichPresence.enable = true;

            whoReacted = {
              enable = true;
            };
            whosWatching = {
              enable = true;
            };

            youtubeAdblock.enable = true;
            youtubeDescription.enable = true;
          };
        };
      };
    };
}
