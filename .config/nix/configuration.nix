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
	};

	nixpkgs.config.allowUnfree = true;

	security.pam.enableSudoTouchIdAuth = true;

	services.nix-daemon.enable = true;

	users.users.john = {
		name = "john";
		home = "/Users/john";
	};

	programs.zsh.enable = true;

	system.stateVersion = 4;
}
