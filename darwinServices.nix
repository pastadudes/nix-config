{pkgs,  ...}: {
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
          command = "${pkgs.isync}/bin/mbsync -a && ${pkgs.notmuch}/bin/notmuch new";
          serviceConfig = {
            UserName = "pastaya";
            StartInterval = 300; # 5 minutes in seconds
            RunAtLoad = true;
            StandardErrorPath = "/Users/pastaya/Library/Logs/mbsync.err.log";
            StandardOutPath = "/Users/pastaya/Library/Logs/mbsync.out.log";
          };
        };
      };
    };
  };
}

