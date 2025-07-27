{
  pkgs,
  lib,
  type ? "personal",
  ...
}:

let
  username = "john";
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in
{
  nix.settings = {
    experimental-features = "nix-command flakes";
    keep-going = true;
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system.primaryUser = username;
  system.startup.chime = false;

  environment = {
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    systemPackages = with pkgs; [
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
      la = "ls -oaGh";
      darwin-rebuild-switch = "sudo ~/.config/nix/rebuild-and-switch.sh";
      darwin-rebuild-switch-work = "sudo ~/.config/nix/rebuild-and-switch-work.sh";
      darwin-cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
      flake-update = "(cd /Users/${username}/.config/nix && nix flake update)";
      mkdir = "mkdir -p";
      docker = "podman";
    };

    systemPath = [
      "/opt/homebrew/bin"
      "$HOME/Library/Android/sdk"
      "$PATH:$ANDROID_HOME/emulator"
      "$PATH:$ANDROID_HOME/platform-tools"
    ];
  };

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  # Automatic updating
  # system.autoUpgrade.enable = true;
  # system.autoUpgrade.dates = "weekly";

  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 7d";
  nix.optimise.automatic = true;

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

    screensaver = {
      askForPasswordDelay = 0;
      askForPassword = true;
    };

    controlcenter = {
      BatteryShowPercentage = true;
      Bluetooth = true;
      Sound = true;
    };

    screencapture = {
      show-thumbnail = true;
      target = "clipboard";
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

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  imports = [
    ./macos/dock.nix
    ./macos/homebrew.nix
    ./macos/karabiner.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${username} = import ./home.nix;
    extraSpecialArgs = {
      inherit type;
    };
  };

  system.activationScripts.preActivation.text = ''
    if ! xcode-select --version 2>/dev/null; then
      xcode-select --install
    fi
  '';

  system.stateVersion = 5;
}
