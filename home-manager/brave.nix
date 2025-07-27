{
  config,
  lib,
  pkgs,
  type,
  ...
}:

{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      "nffaoalbilbmmfgbnbgppjihopabppdk"
      "kmcfomidfpdkfieipokbalgegidffkal"
      # { id = "nffaoalbilbmmfgbnbgppjihopabppdk"; } # video speed controller
      # { id = "kmcfomidfpdkfieipokbalgegidffkal"; } # enpass

    ];
  };
}
