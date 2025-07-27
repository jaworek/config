{
  description = "MacOS system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs =
    {
      self,
      darwin,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }@inputs:
    let
      darwinModules = [
        ./configuration.nix

        home-manager.darwinModules.home-manager
        {
          nix.registry = {
            nixpkgs.flake = nixpkgs-unstable;
          };
        }
      ];

      configuration =
        {
          system,
          type ? "personal",
        }:
        darwin.lib.darwinSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit type;
          };
          modules = darwinModules ++ [
            {
              nixpkgs.overlays = [
                (self: super: {
                  # neovim = (import nixpkgs-unstable { inherit system; }).neovim;
                  # darwin.xcode_16_1 = (import nixpkgs-unstable { inherit system; }).darwin.xcode_16_1;
                })
              ];
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        vm-aarch64 = {
          system = "aarch64-linux";
          user = "john";
        };
      };

      # Build darwin flake using:
      darwinConfigurations = {
        john = configuration { system = "aarch64-darwin"; };
        work = configuration {
          system = "aarch64-darwin";
          type = "work";
        };
      };
      # Expose the package set, including overlays, for convenience.
      # darwinPackages = self.darwinConfigurations."Johns-MacBook-Pro".pkgs;
    };
}
