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

	#homebrew.enable = true;
	#homebrew.casks = [
        #	"enpass"
	#];

	fonts = {
		packages = with pkgs; [
			(nerdfonts.override { fonts = ["JetBrainsMono"]; })
			#(google-fonts.override { fonts = ["PublicSans"]; })
		];
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
	  #shellAliases = {
	  #  vim = "nvim";
	  #  gs = "git status";
	  #};
	};

	system.stateVersion = 4;
}
