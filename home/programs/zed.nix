{lib, ...}: {
  programs.zed-editor = {
    enable = false;
    extensions = ["TOML" "nix" "html" "eslint" "javascript" "JSDoc" "typescript"];
    userSettings = {
      toolbar = {
        selections_menu = false;
        agent_review = false;
      };
      ui_font_size = lib.mkForce 14.0;
      buffer_font_size = lib.mkForce 13.33333334;
      relative_line_numbers = "enabled";
      autosave = "off";
      search = {
        center_on_match = true;
        regex = true;
      };
      active_pane_modifiers = {
        inactive_opacity = 0.7;
      };
      window_decorations = "client";
      tab_bar = {
        show_tab_bar_buttons = true;
      };
      title_bar = {
        show_menus = false;
        show_branch_icon = true;
      };
      status_bar = {
        active_language_button = true;
        cursor_position_button = true;
      };
      terminal = {
        button = false;
      };
      debugger = {
        button = false;
      };
      helix_mode = true;
      disable_ai = true;
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      vim_mode = false;
    };
  };
}
