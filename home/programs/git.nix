{pkgs, ...}: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "contact@pastaya.net";
        name = "pastaya";
      };

      diff = {
        algorithm = "histogram";
        colorMoved = "default";
      };

      core = {
        editor = "${pkgs.helix}/bin/hx";
      };

      color = {
        ui = "auto";
      };

      rerere = {
        enabled = true;
        autoupdate = true;
      };

      rebase = {
        autosquash = true;
      };

      alias = {
        a = "add";
        aa = "add -A";
        ci = "commit";
        cl = "clone";
        st = "status";
        d = "diff";
        dc = "diff --cached";

        sw = "switch";
        swc = "switch -c";

        lg = "log --graph --decorate --oneline -20";
        lgu = "log --graph --decorate --oneline @{u}..";
        lga = "log --graph --decorate --oneline --all";
        lgs = "log --graph --decorate --all --stat";

        pushf = "push --force-with-lease";
        amend = "commit --amend --no-edit";

        fixup = "commit --fixup";
      };

      init = {
        defaultBranch = "master";
      };
      gc = {
        auto = 256;
        writeCommitGraph = true;
      };
      merge = {
        conflictStyle = "zdiff3";
      };
      push = {
        autoSetupRemote = true;
        default = "simple";
      };
    };

    signing = {
      key = "BE7075D8224B7A628885C06D68B0CFDCFD40EA66";
      signByDefault = true;
    };
  };
}
