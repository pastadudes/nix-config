{...}: {
  launchd = {
      user = {
      # Bedtime ON at 11 PM
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

        # Bedtime OFF at 7 AM + sleep
        bedtimeOff = {
          command = "fish -c shortcuts run bedtimeOFF; pmset sleepnow"; # or bash, just needs a shell to run multiple commands
          serviceConfig = {
            UserName = "pastaya";
            StartCalendarInterval = {
              Hour = 7;
              Minute = 0;
            };
          };
        };
      };
    };
  };
}

