{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    bun
    darwin.xcode_26_Apple_silicon
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
