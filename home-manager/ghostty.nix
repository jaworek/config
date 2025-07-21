{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    enableZshIntegration = true;
    settings = {
      cursor-style = "underline";
      # font-family = "FiraCode Nerd Font Mono Reg";
      # font-family-bold = "FiraCode Nerd Font Mono Bold";
      # font-synthetic-style = [
      #   "italic"
      #   "bold-italic"
      # ];
      # font-size = 14;
      # maximize = true;
      quit-after-last-window-closed = true;
      theme = "JetBrains Darcula";
      auto-update = "off";
      copy-on-select = true;
      font-feature = [
        "-calt"
        "-liga"
        "-dlig"
      ];
      window-inherit-working-directory = false;
      window-save-state = "always";
      window-colorspace = "display-p3";
    };
  };
}
