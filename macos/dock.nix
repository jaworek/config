{
  config,
  lib,
  pkgs,
  type ? "personal",
  ...
}:

{
  system.defaults.dock = {
    # Disables Desktop & Dock -> Dock -> Show suggested and recent apps in Dock
    show-recents = false;

    # Don’t rearrange spaces based on the most recent use
    mru-spaces = false;

    persistent-apps = [
      "${pkgs.arc-browser}/Applications/Arc.app"
      "/System/Cryptexes/App/System/Applications/Safari.app"
      "/Applications/Zen.app"
      "/System/Applications/System Settings.app"
      "${pkgs.ghostty-bin}/Applications/Ghostty.app"
      "${pkgs.darwin.xcode_26_Apple_silicon}"
      "${pkgs.zed-editor}/Applications/Zed.app"
    ]
    ++ (
      if type == "work" then
        [
          "/System/Applications/Calendar.app"
          "/System/Applications/Notes.app"
          "/Applications/Slack.app"
          "/Applications/1Password.app"
        ]
      else
        [
          "/System/Applications/Messages.app"
          "/System/Applications/Calendar.app"
          "${pkgs.obsidian}/Applications/Obsidian.app"
          "${pkgs.telegram-desktop}/Applications/Telegram.app"
          "${pkgs.signal-desktop-bin}/Applications/Signal.app"
          "${pkgs.discord}/Applications/Discord.app"
          "${pkgs.enpass-mac}/Applications/Enpass.app"
        ]
    );

    # Disable hot corners
    wvous-bl-corner = 1;
    wvous-br-corner = 1;
    wvous-tl-corner = 1;
    wvous-tr-corner = 1;
  };
}
