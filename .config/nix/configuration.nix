{
	pkgs,
	lib,
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
		];

		shellAliases = {
			g = "git";
			gs = "git status";
			gc = "git commit";
			gaa = "git add --all";
			vim = "nvim";
			la = "ls -laG";
			darwin-rebuild-switch = "~/.config/nix/rebuild-and-switch.sh";
		};

		systemPath = [
			"/opt/homebrew/bin"
		];
	};

	homebrew.enable = true;
	homebrew.onActivation.cleanup = "zap";
	
	homebrew.casks = [
		# missing ARM version
        	#"enpass"
		"signal"
		"steam"
		"arc"
		"firefox"
		"synology-drive"
	];

	homebrew.masApps = {
		Numbers = 409203825;
		Enpass = 732710998;
	};

	fonts = {
		packages = with pkgs; [
			(nerdfonts.override { fonts = ["JetBrainsMono"]; })
			#(google-fonts.override { fonts = ["PublicSans"]; })
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
		};

		dock = {
			# Disables Desktop & Dock -> Dock -> Show suggested and recent apps in Dock
			show-recents = false;

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
			];
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
		};


	nixpkgs.config.allowUnfree = true;

	security.pam.enableSudoTouchIdAuth = true;

	services.nix-daemon.enable = true;

	users.users.john = {
		name = "john";
		home = "/Users/john";
	};

	programs.zsh = { 
	  enable = true;
	};

	system.stateVersion = 4;
}
