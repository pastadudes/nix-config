{...}: {
  programs.vesktop = {
    enable = true;
    vencord.useSystem = false;
    settings = {
      appBadge = false;
      arRPC = true;
      checkUpdates = false;
      customTitleBar = false;
      disableMinSize = true;
      minimizeToTray = false;
      tray = false;
      splashBackground = "#000000";
      splashColor = "#ffffff";
      splashTheming = true;
      staticTitle = true;
      hardwareAcceleration = true;
      discordBranch = "stable";
    };
    vencord.settings = {
      autoUpdate = true;
      autoUpdateNotification = true;
      notifyAboutUpdates = false;
      useQuickCss = true;
      disableMinSize = true;
      transparent = true;
      plugins = {
        anammox.enabled = true;
        alwaysExpandRoles.enabled = true;
        anonymiseFileNames = {
          enabled = true;
          anonymiseByDefault = false;
        };
        betterAudioPlayer = {
          enabled = true;
          oscilloscopeColor = "255, 175, 0";
        };
        betterBlockedUsers.enabled = true;
        betterCommands.enabled = true;
        betterGifAltText.enabled = true;
        betterGifPicker.enabled = true;
        betterInvites.enabled = true;
        betterPlusReacts.enabled = true;
        betterQuickReact.enabled = true;
        betterRoleContext.enabled = true;
        betterRoleDot.enabled = true;
        betterSessions.enabled = true;
        betterSettings.enabled = true;
        betterUploadButton.enabled = true;
        biggerStreamPreview.enabled = true;
        blockKeywords = {
          enabled = true;
          blockedWords = ''
            (?i)\btroo(n|nie|ny|ns|m)\b,
            (?i)i['''` ]?m\s+maga,
            (?i)\bnigg(a|er|ers)?\b,
            (?i)\bfag(got|gots|s)?\b,
            (?i)\bretard(s|ed|ing)?\b
          '';
          useRegex = true;
        };
        callTimer.enabled = true;
        characterCounter.enabled = true;
        clipsEnhancements.enabled = true;
        consoleJanitor.enabled = true;
        copyFileContents.enabled = true;
        copyStickerLinks.enabled = true;
        customTimestamps.enabled = true;
        dearrow.enabled = true;
        decodeBase64.enabled = true;
        decor.enabled = true;
        exportMessages = {
          enabled = true;
          exportContacts = true;
        };
        expressionCloner.enabled = true;
        f8Break.enabled = true;
        fakeNitro.enabled = true;
        fakeProfileThemes.enabled = true;
        favoriteEmojiFirst.enabled = true;
        favoriteGifSearch.enabled = true;
        findReply = {
          enabled = true;
          includeAuthor = true;
          includePings = true;
        };
        fixCodeblockGap.enabled = true;
        fixFileExtensions.enabled = true;
        fixImagesQuality.enabled = true;
        fixSpotifyEmbeds.enabled = true;
        fixYoutubeEmbeds.enabled = true;
        followVoiceUser.enabled = true;
        fontLoader.enabled = true;
        forceOwnerCrown.enabled = true;
        frequentQuickSwitcher.enabled = true;
        friendCloud.enabled = true;
        friendInvites.enabled = true;
        friendsSince.enabled = true;
        friendshipRanks.enabled = true;
        fullSearchContext.enabled = true;
        gameActivityToggle.enabled = true;
        ghosted.enabled = true;
        gifPaste.enabled = true;
        gitHubRepos.enabled = true;
        globalBadges.enabled = true;
        googleThat = {
          enabled = true;
          defaultEngine = "LetMeGoogleThatForYou";
        };
        greetStickerPicker.enabled = true;
        guildPickerDumper.enabled = true;
        imageFilename = {
          enabled = true;
          showFullUrl = true;
        };
        imageZoom = {
          enabled = true;
          nearestNeighbour = true;
          size = 5000.0;
        };
        imgToGif.enabled = true;
        implicitRelationships.enabled = true;
        inviteDefaults.enabled = true;
        ircColors = {
          enabled = true;
          applyColorOnlyInDms = true;
        };
        jumpTo.enabled = true;
        keepCurrentChannel.enabled = true;
        keyboardSounds = {
          enabled = true;
          soundPack = "osu";
        };
        memberCount.enabled = true;
        mentionAvatars.enabled = true;
        messageClickActions.enabled = true;
        messageColors.enabled = true;
        messageFetchTimer.enabled = true;
        messageLatency = {
          enabled = true;
          showMillis = true;
        };
        messageLinkEmbeds.enabled = true;
        messageLogger = {
          enabled = true;
          collapseDeleted = true;
        };
        messageLoggerEnhanced.enabled = true;
        messageTranslate.enabled = true;
        moreCommands.enabled = true;
        moreKaomoji.enabled = true;
        moreStickers.enabled = true;
        moreUserTags.enabled = true;
        musicControls.enabled = true;
        noOnboardingDelay.enabled = true;
        noTypingAnimation.enabled = true;
        noUnblockToJump.enabled = true;
        normalizeMessageLinks.enabled = true;
        notificationTitle.enabled = true;
        pauseInvitesForever.enabled = true;
        permissionsViewer.enabled = true;
        platformIndicators.enabled = true;
        quickReply.enabled = true;
        reactErrorDecoder.enabled = true;
        readAllNotificationsButton.enabled = true;
        relationshipNotifier = {
          enabled = true;
          friends = false;
          notices = true;
        };
        replaceGoogleSearch.enabled = true;
        replyTimestamp.enabled = true;
        reverseImageSearch.enabled = true;
        sekaiStickers.enabled = true;
        sendTimestamps.enabled = true;
        serverInfo.enabled = true;
        serverListIndicators.enabled = true;
        serverSearch.enabled = true;
        shikiCodeblocks = {
          enabled = true;
          bgOpacity = 80.0;
          useDevIcon = "COLOR";
        };
        showConnections.enabled = true;
        showHiddenChannels.enabled = true;
        showHiddenThings.enabled = true;
        showMessageEmbeds.enabled = true;
        silentMessageToggle.enabled = true;
        songLink.enabled = true;
        splitLargeMessages.enabled = true;
        spotifyCrack.enabled = true;
        startupTimings.enabled = true;
        talkInReverse.enabled = true;
        toneIndicators.enabled = true;
        typingIndicator.enabled = true;
        typingTweaks.enabled = true;
        unindent.enabled = true;
        unitConverter = {
          enabled = true;
          myUnits = "metric";
        };
        universalMention.enabled = true;
        validReply.enabled = true;
        validUser.enabled = true;
        viewRaw.enabled = true;
        voiceMessages.enabled = true;
        webRichPresence.enabled = true;
        whoReacted.enabled = true;
        whosWatching.enabled = true;
        youtubeAdblock.enabled = true;
        youtubeDescription.enabled = true;
      };
    };
  };
}
