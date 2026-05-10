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
          name = "node@24";
          link = true;
        }
      ]
    else
      [
        {
          name = "node@24";
          link = true;
        }
      ];

  homebrew.caskArgs = {
    no_quarantine = true;
  };

  homebrew.casks = [
    "zen"
    "zed"
  ]
  ++ (
    if type == "work" then
      [
      ]
    else
      [
        "synology-drive"
        "bambu-studio"
        "telegram"
        "arc"
        "llamabarn"
        "enpass"
      ]
  );

  homebrew.masApps =
    if type == "work" then
      { }
    else
      {
       # Wireguard = 1451685025;
      };
}
