{ ... }: {
  system.defaults = {
    CustomSystemPreferences = {
      NSGlobalDomain = {
        ApplePressAndHoldEnabled = false;
      };
    };

    ".GlobalPreferences" = {
      "com.apple.mouse.scaling" = 1.0;
      "com.apple.sound.beep.sound" = "/System/Library/Sounds/Tink.aiff";
    };

    NSGlobalDomain = {
      AppleEnableMouseSwipeNavigateWithScrolls = true;
      AppleInterfaceStyleSwitchesAutomatically = true;
      AppleKeyboardUIMode = 3;
      AppleShowAllExtensions = true;
      AppleShowScrollBars = "WhenScrolling";
      AppleWindowTabbingMode = "always";
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      "com.apple.keyboard.fnState" = true;
      "com.apple.sound.beep.feedback" = 1;
      "com.apple.springing.delay" = 0.5;
      "com.apple.springing.enabled" = true;
      "com.apple.swipescrolldirection" = true;
    };

    SoftwareUpdate = {
      AutomaticallyInstallMacOSUpdates = false;
    };

    menuExtraClock = {
      IsAnalog = false;
      Show24Hour = true;
      ShowAMPM = false;
      ShowDayOfMonth = false;
      ShowDayOfWeek = true;
      ShowDate = 1; # Always
      ShowSeconds = false;
    };

    dock = {
      autohide = true;
      autohide-delay = 0.0;
      mineffect = "scale";
      minimize-to-application = false;
      orientation = "bottom";
      show-recents = true;
      tilesize = 64;

      # hot corners
      wvous-tl-corner = 1; # Top Left: Disabled
      wvous-tr-corner = 4; # Top Right: Desktop
      wvous-bl-corner = 2; # Bottom Left; Mission Control
      wvous-br-corner = 3; # Bottom Right: Application Windows
    };

    finder = {
      ShowPathbar = true;
      ShowStatusBar = true;
      AppleShowAllExtensions = true;
      FXDefaultSearchScope = "SCcf"; # Search current folder
      FXPreferredViewStyle = "Nlsv"; # List view
      CreateDesktop = true; # Show icons on desktop
      FXEnableExtensionChangeWarning = true;
    };

    loginwindow = {
      GuestEnabled = false;
      ShutDownDisabled = false;
      SleepDisabled = false;
      RestartDisabled = false;
      ShutDownDisabledWhileLoggedIn = false;
      PowerOffDisabledWhileLoggedIn = false;
      RestartDisabledWhileLoggedIn = false;
      DisableConsoleAccess = false;
    };

    magicmouse = {
      MouseButtonMode = "TwoButton";
    };

    screencapture = {
      disable-shadow = true;
    };

    screensaver = {
      askForPassword = true;
      askForPasswordDelay = 5;
    };

    spaces = {
      spans-displays = true;
    };

    trackpad = {
      Clicking = true;
      Dragging = false;
      TrackpadRightClick = true;
      TrackpadThreeFingerDrag = false;
      ActuationStrength = 1; # disable
      FirstClickThreshold = 1; # medium
      SecondClickThreshold = 1; # medium
    };
  };
}
