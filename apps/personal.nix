{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    telegram-desktop
    discord
    # does not start for some reason
    # synology-drive-client
    bun
    ansible
    darwin.xcode_26_Apple_silicon
    # blender
    keka
    iina
    ffmpeg-full
    obsidian
    yt-dlp
    spotify
    # monero-gui
    # sweethome3d.application
    signal-desktop-bin
    ollama
    # cursor
    syncthing
    # tailscale - no gui
    jetbrains.webstorm
    podman
    # altserver-linux
    # davinci-resolve
    # lmstudio
    # davinci-resolve
    # kicad
    # freecad
    enpass-mac
    # steam
    # orca-slicer
    # vlc-bin
    # handbrake
  ];
}
