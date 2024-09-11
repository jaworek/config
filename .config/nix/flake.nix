{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";	
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { 
	self, 
	darwin, 
	nixpkgs, 
	nixpkgs-unstable, 
	home-manager, 
	... 
} @ inputs: let
    darwinModules = [
	./configuration.nix

      	home-manager.darwinModules.home-manager
	{
		home-manager.useGlobalPkgs = true;
		home-manager.useUserPackages = true;
		home-manager.users.john = import ./home.nix;

		nix.registry = {
			nixpkgs.flake = nixpkgs;
                        nixpkgs-unstable.flake = nixpkgs-unstable;
		};
	}
    ];

    configuration = systemArg: darwin.lib.darwinSystem rec {
      system = systemArg;
      modules = darwinModules;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      #environment.systemPackages =
      #  [ 
      #    pkgs.vim
      #  ];

      # Auto upgrade nix package and the daemon service.
      # services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      # nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      # programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      # system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      # system.stateVersion = 4;

      # The platform the configuration will be used on.
      # nixpkgs.hostPlatform = systemArg;
    };
  in
  {
    # Build darwin flake using:
    darwinConfigurations."Johns-MacBook-Pro" = configuration "aarch64-darwin";
    # Expose the package set, including overlays, for convenience.
    # darwinPackages = self.darwinConfigurations."Johns-MacBook-Pro".pkgs;
  };
}
