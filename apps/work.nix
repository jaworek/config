{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    bun
    xcode
    scrcpy
    watchman
    zulu17
    cocoapods
    rustup
    jetbrains.webstorm
    _1password-gui
    idb-companion
  ];
}
