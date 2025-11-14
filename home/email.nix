{
  config,
  pkgs,
  ...
}:

{
  accounts.email = {
    maildirBasePath = "mail!";

    accounts = {
      "main!" = {
        primary = true;
        address = "pastaya@pastaya.net";
        userName = "pastaya@pastaya.net";
        realName = "pastaya";
        passwordCommand = "${pkgs.pass}/bin/pass email/mailbox.org | head -n1";

        imap = {
          host = "imap.mailbox.org";
          port = 993;
          tls.enable = true;
        };

        smtp = {
          host = "smtp.mailbox.org";
          port = 587;
          tls = {
            enable = true;
            useStartTls = true;
          };
        };

        gpg = {
          key = "BE7075D8224B7A628885C06D68B0CFDCFD40EA66";
          signByDefault = true;
        };

        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          patterns = [ "*" ];
        };

        notmuch.enable = true;
        msmtp.enable = true;
        
        aerc = {
          enable = true;
          extraAccounts = {
            source = "notmuch://${config.accounts.email.maildirBasePath}";
            query-map = "${config.xdg.configHome}/aerc/main-query-map";
            # maildir-store = "${config.accounts.email.maildirBasePath}/main";
          };
        };

        folders = {
          drafts = "drafts!";
          sent = "sent!";
          trash = "trash!";
        };
      };
    };
  };

  # aerc stuff
  xdg.configFile."aerc/main-query-map".text = ''
    inbox!=tag:unread
    personal!=tag:personal
    work!=tag:work
    sent!=tag:sent
    all!=*
    drafts!=tag:draft
    github!=tag:github
    archive!=tag:archive
  '';
}
