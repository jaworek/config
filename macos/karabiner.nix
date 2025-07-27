{
  config,
  lib,
  pkgs,
  type,
  ...
}:
{
  home.packages = with pkgs; [
    karabiner-elements
  ];
  
  home.file = {
    ".config/karabiner".source = ../dotfiles/karabiner;
  };

  # needed until https://github.com/nix-darwin/nix-darwin/issues/1041 is fixed
  services.karabiner-elements = {
    enable = true;
    package = pkgs.karabiner-elements.overrideAttrs (old: {
      version = "14.13.0";

      src = pkgs.fetchurl {
        inherit (old.src) url;
        hash = "sha256-gmJwoht/Tfm5qMecmq1N6PSAIfWOqsvuHU8VDJY8bLw=";
      };

      dontFixup = true;
    });
  };
}
