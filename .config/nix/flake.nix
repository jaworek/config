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
    	modules = darwinModules ++ [{
    		nixpkgs.overlays = [
    			(self: super: {
    				neovim = (import nixpkgs-unstable { system = systemArg; }).neovim;
    			})
    		];
    	}];
    };
  in
  {
    # Build darwin flake using:
    darwinConfigurations."Johns-MacBook-Pro" = configuration "aarch64-darwin";
    # Expose the package set, including overlays, for convenience.
    # darwinPackages = self.darwinConfigurations."Johns-MacBook-Pro".pkgs;
  };
}
