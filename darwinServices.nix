{pkgs, config,  ...}: {
  launchd = {
      user = {
      # bedtime on at 11 pm
      agents = {
        bedtimeOn = {
          command = "shortcuts run bedtime";
          serviceConfig = {
            UserName = "pastaya";
            StartCalendarInterval = {
              Hour = 23;
              Minute = 0;
            };
          };
        };

        # bedtime off at 7 am + sleep
        bedtimeOff = {
          command = "sh -c shortcuts run bedtimeOFF && pmset sleepnow"; # or bash, just needs a shell to run multiple commands
          serviceConfig = {
            UserName = "pastaya";
            StartCalendarInterval = {
              Hour = 7;
              Minute = 0;
            };
          };
        };
        mbsync = {
          command = ''
            sh -c 'cd ~/mail!/main! && ${pkgs.isync}/bin/mbsync -a && ${pkgs.notmuch}/bin/notmuch new'
            '';
          serviceConfig = {
            UserName = "pastaya";
            StartInterval = 300; # 5 minutes in seconds
            RunAtLoad = true;
            StandardErrorPath = "/Users/pastaya/Library/Logs/mbsync.err.log";
            StandardOutPath = "/Users/pastaya/Library/Logs/mbsync.out.log";
          };
        };
        mailCleanup = {
          command = ''
            sh -c '
              # tag older than 30 days
              ${pkgs.notmuch}/bin/notmuch tag +archive -- "date:..30days ago"

              ${pkgs.notmuch}/bin/notmuch search "tag:archive" | \
              xargs -I {} ${pkgs.notmuch}/bin/notmuch insert --folder=~/mail!/Trash {}

              # sync deletions
              ${pkgs.isync}/bin/mbsync -a
            '
          '';
          serviceConfig = {
            UserName = "pastaya";
            StartInterval = 86400; # runs daily
            RunAtLoad = true;
            StandardOutPath = "/Users/pastaya/Library/Logs/mail-cleanup.log";
            StandardErrorPath = "/Users/pastaya/Library/Logs/mail-cleanup.err";
          };
        };
      };
    };
  };
}

