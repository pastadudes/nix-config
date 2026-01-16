{...}: {
  programs.zellij = {
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
}
