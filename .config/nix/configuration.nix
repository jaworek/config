{
	pkgs,
	lib,
	type ? "personal",
	...
}:
{
	nix.settings.experimental-features = "nix-command flakes";

	environment = {
		# List packages installed in system profile. To search by name, run:
		# $ nix-env -qaP | grep wget
		systemPackages = with pkgs; [
			git
			iterm2
			tailscale
			nixd
		];

		shellAliases = {
			g = "git";
			gs = "git status";
			gc = "git commit";
			gaa = "git add --all";
			gpu = "git push";
			vim = "nvim";
			la = "ls -laG";
			darwin-rebuild-switch = "~/.config/nix/rebuild-and-switch.sh";
			darwin-rebuild-switch-work = "~/.config/nix/rebuild-and-switch.sh --configuration work";
			darwin-cleanup = "nix-collect-garbage --delete-older-than 7d";
			mkdir = "mkdir -p";
		};

		systemPath = [
			"/opt/homebrew/bin"
		];
	};

	homebrew.enable = true;
	homebrew.onActivation.cleanup = "zap";

	homebrew.taps = [
		"homebrew/services"
		"FelixKratz/formulae"
	];

	homebrew.brews = [
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
	
	homebrew.casks = [
		# missing ARM version
        	#"enpass"
		"signal"
		"steam"
		"arc"
		"firefox"
		"synology-drive"
		"brave-browser"
		"cursor"
		{
			name = "grishka/grishka/neardrop";
		}
		"nikitabobko/tap/aerospace"
		"blender"
	];

	homebrew.masApps = {
		iMovie = 408981434;
		Numbers = 409203825;
		Enpass = 732710998;
	};

	fonts = {
		packages = with pkgs; [
			(nerdfonts.override { fonts = ["JetBrainsMono"]; })
		];
	};

	system.defaults = {
		NSGlobalDomain = {
			# Sets Trackpad -> Point & Click -> Tracking speed
			"com.apple.trackpad.scaling" = 2.0;

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

			persistent-apps = [
				"/Applications/Arc.app"
				"/System/Cryptexes/App/System/Applications/Safari.app"
				"/Applications/Firefox.app"
				"/System/Applications/Messages.app"
				"/System/Applications/Calendar.app"
				"/System/Applications/Notes.app"
				"/System/Applications/System Settings.app"
				"${pkgs.spotify}/Applications/Spotify.app"
				"${pkgs.iterm2}/Applications/iTerm2.app"
				"${pkgs.vscode}/Applications/Visual Studio Code.app"
				"${pkgs.darwin.xcode_15_1}"
				"${pkgs.darwin.xcode_15_1}/Contents/Developer/Applications/Simulator.app"
				"${pkgs.telegram-desktop}/Applications/Telegram.app"
				"/Applications/Signal.app"
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

		CustomUserPreferences = {
			NSGlobalDomain = {
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

	security.pam.enableSudoTouchIdAuth = true;

	services.nix-daemon.enable = true;
	services.karabiner-elements.enable = true;

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
