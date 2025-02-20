{
  pkgs,
  lib,
  type ? "personal",
  ...
}:
{
  nix.settings.experimental-features = "nix-command flakes";

  security.pam.enableSudoTouchIdAuth = true;

  environment = {
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    systemPackages =
      with pkgs;
      if type == "work" then
        [
          git
          nixfmt-rfc-style
        ]
      else
        [
          git
          nixfmt-rfc-style
        ];

    shellAliases = {
      g = "git";
      gs = "git status";
      gc = "git commit";
      gaa = "git add --all";
      gpu = "git push";
      gpuf = "git push --force-with-lease";
      vim = "nvim";
      la = "ls -laG";
      darwin-rebuild-switch = "~/.config/nix/rebuild-and-switch.sh";
      darwin-rebuild-switch-work = "~/.config/nix/rebuild-and-switch-work.sh";
      darwin-cleanup = "nix-collect-garbage --delete-older-than 7d";
      mkdir = "mkdir -p";
    };

    systemPath = [
      "/opt/homebrew/bin"
      "$HOME/Library/Android/sdk"
      "$PATH:$ANDROID_HOME/emulator"
      "$PATH:$ANDROID_HOME/platform-tools"
    ];
  };

  homebrew.enable = true;
  homebrew.onActivation.cleanup = "zap";

  homebrew.taps =
    if type == "work" then
      [ "homebrew/services" ]
    else
      [
        "homebrew/services"
        "FelixKratz/formulae"
        "nikitabobko/tap"
        "grishka/grishka"
      ];

  homebrew.brews =
    if type == "work" then
      [
        {
          name = "node@20";
          link = true;
        }
      ]
    else
      [
        {
          name = "asimov";
          start_service = true;
        }
        "borders"
        "sketchybar"
      ];

  homebrew.caskArgs = {
    no_quarantine = true;
  };

  homebrew.casks =
    if type == "work" then
      [
        "firefox"
        "brave-browser"
        "minisim"
      ]
    else
      [
        # missing ARM version
        #"enpass"
        "steam"
        "firefox"
        "synology-drive"
        "brave-browser"
        "cursor"
        "neardrop"
        "aerospace"
        "blender"
        "bambu-studio"
      ];

  homebrew.masApps =
    if type == "work" then
      { }
    else
      {
        iMovie = 408981434;
        Numbers = 409203825;
        Enpass = 732710998;
        Wireguard = 1451685025;
      };

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  system.defaults = {
    NSGlobalDomain = {
      # Sets Trackpad -> Point & Click -> Tracking speed
      "com.apple.trackpad.scaling" = 3.0;

      # Enables Trackpad -> Point & Click -> Force Click and haptic feedback
      "com.apple.trackpad.forceClick" = true;
      # Enables Trackpad -> Scroll & Zoom -> Natural scrolling and Mouse -> Nautral scrolling
      "com.apple.swipescrolldirection" = true;
      # Tap to click
      "com.apple.mouse.tapBehavior" = 1;
      # Sets Language & Region -> Measurement system to "Metric"
      AppleMeasurementUnits = "Centimeters";
      # Sets Language & Region -> Measurement system to "Metric"
      AppleMetricUnits = 1;
      # Sets Language & Region -> Temperature to "Celsius"
      AppleTemperatureUnit = "Celsius";
      # Enables Date & Time -> 24-hour time
      AppleICUForce24HourTime = true;

      # Sets Appearance -> Show scroll bars to "Always"
      AppleShowScrollBars = "Always";

      # Disable font smoothing
      # https://tonsky.me/blog/monitors/
      AppleFontSmoothing = 0;

      AppleInterfaceStyle = "Dark";

      # Automatic dark and light mode
      # AppleInterfaceStyleSwitchesAutomatically = true;

      KeyRepeat = 2;

      # Move windows by holding ctrl+cmd and dragging any part of the window
      NSWindowShouldDragOnGesture = true;
    };

    dock = {
      # Disables Desktop & Dock -> Dock -> Show suggested and recent apps in Dock
      show-recents = false;

      # Don’t rearrange spaces based on the most recent use
      mru-spaces = false;

      persistent-apps =
        if type == "work" then
          [
            "${pkgs.arc-browser}/Applications/Arc.app"
            "/System/Cryptexes/App/System/Applications/Safari.app"
            "/Applications/Firefox.app"
            "/System/Applications/Calendar.app"
            "/System/Applications/Notes.app"
            "/System/Applications/System Settings.app"
            "/Applications/Ghostty.app"
            # "${pkgs.vscode}/Applications/Visual Studio Code.app"
            "${pkgs.darwin.xcode_16_1}"
            "/Applications/Slack.app"
            "/Applications/1Password.app"
          ]
        else
          [
            "${pkgs.arc-browser}/Applications/Arc.app"
            "/System/Cryptexes/App/System/Applications/Safari.app"
            "/Applications/Firefox.app"
            "/System/Applications/Messages.app"
            "/System/Applications/Calendar.app"
            "/System/Applications/Notes.app"
            "/System/Applications/System Settings.app"
            "${pkgs.spotify}/Applications/Spotify.app"
            "/Applications/Ghostty.app"
            # "${pkgs.vscode}/Applications/Visual Studio Code.app"
            "${pkgs.darwin.xcode_16_1}"
            "${pkgs.darwin.xcode_16_1}/Contents/Developer/Applications/Simulator.app"
            "${pkgs.telegram-desktop}/Applications/Telegram.app"
            "${pkgs.signal-desktop}/Applications/Signal.app"
            "${pkgs.discord}/Applications/Discord.app"
            "/Applications/Enpass.app"
            "${pkgs.obsidian}/Applications/Obsidian.app"
          ];

      # Disable hot corners
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
    };

    screensaver = {
      askForPasswordDelay = 0;
      askForPassword = true;
    };

    controlcenter = {
      BatteryShowPercentage = true;
      Bluetooth = true;
      Sound = true;
    };

    CustomUserPreferences = {
      NSGlobalDomain = {
        AppleLanguages = [
          "en-US"
        ];

        # Sets Language & Region -> First day of week to "Monday"
        AppleFirstWeekday = {
          gregorian = 2;
        };
      };

      "com.apple.AppleMultitouchTrackpad" = {
        # Enables Trackpad -> Point & Click -> Tap to click
        Clicking = 1;
        # Sets Accessibility -> Motor -> Pointer Control -> Mouse & Trackpad -> Trackpad Options -> Dragging style to "Three Finger Drag"
        TrackpadThreeFingerDrag = 1;
        TrackpadThreeFingerHorizSwipeGesture = 0;
        TrackpadThreeFingerTapGesture = 0;
        TrackpadThreeFingerVertSwipeGesture = 0;
      };

      # App Store
      "com.apple.commerce" = {
        # Disables Automatic Updates
        AutoUpdate = false;
      };
    };

    loginwindow.GuestEnabled = false;
  };

  nixpkgs.config.allowUnfree = true;

  # security.pam.enableSudoTouchIdAuth = true;

  services.nix-daemon.enable = true;
  # services.karabiner-elements.enable = true;

  users.users.john = {
    name = "john";
    home = "/Users/john";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.john = import ./home.nix;
    extraSpecialArgs = {
      inherit type;
    };
  };

  system.stateVersion = 4;
}
