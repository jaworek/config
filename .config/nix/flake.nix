{
  description = "MacOS system configuration";

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
		nix.registry = {
			nixpkgs.flake = nixpkgs;
                        nixpkgs-unstable.flake = nixpkgs-unstable;
		};
	}
    ];

    configuration = { system, type ? "personal" }: let 
    in
    darwin.lib.darwinSystem rec {
	inherit system;
    	modules = darwinModules ++ [{
    		nixpkgs.overlays = [
    			(self: super: {
    				neovim = (import nixpkgs-unstable { inherit system; }).neovim;
    			})
    		];
    	}];
    };
  in
  {
    # Build darwin flake using:
    darwinConfigurations = {
			"Johns-MacBook-Pro" = configuration { system = "aarch64-darwin"; };
			work = configuration { system = "aarch64-darwin"; type = "work"; };
    };
    # Expose the package set, including overlays, for convenience.
    # darwinPackages = self.darwinConfigurations."Johns-MacBook-Pro".pkgs;
  };
}
