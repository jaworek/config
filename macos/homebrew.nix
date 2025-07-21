{
  pkgs,
  lib,
  type ? "personal",
  ...
}:
{
  homebrew.enable = true;
  homebrew.onActivation.cleanup = "zap";

  homebrew.brews =
    if type == "work" then
      [
        {
          name = "node@20";
          link = true;
        }
      ]
    else
      [
      ];

  homebrew.caskArgs = {
    no_quarantine = true;
  };

  homebrew.casks = [
    "zen"
    "brave-browser"
    "arc"
  ]
  ++ (
    if type == "work" then
      [
      ]
    else
      [
        "synology-drive"
        "bambu-studio"
      ]
  );

  homebrew.masApps =
    if type == "work" then
      { }
    else
      {
        Wireguard = 1451685025;
      };
}
