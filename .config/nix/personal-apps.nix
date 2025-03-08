{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    telegram-desktop
    discord
    #does not start for some reason
    #synology-drive-client
    go
    bun
    ansible
    darwin.xcode_16_1
    # blender
    keka
    iina
    nodejs_22
    ffmpeg-full
    obsidian
    scrcpy
    watchman
    zulu17
    cocoapods
    yt-dlp
    #monero-gui
    #sweethome3d.application
    signal-desktop
    gh
    # kicad
    # freecad
    #enpass
    #steam
    # orca-slicer
  ];
}
