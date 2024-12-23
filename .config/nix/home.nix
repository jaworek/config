{
  config,
  pkgs,
  lib,
  type ? "personal",
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages =
    with pkgs;
    if type == "work" then
      [
        iterm2
        raycast
        vscode
        neovim
        git
        karabiner-elements
        tmux
        bun
        nodejs_20
        darwin.xcode_16_1
        scrcpy
        # fd and ripgrep are needed for telescope plugin in nvim
        fd
        ripgrep
        watchman
        zulu17
        cocoapods
        rustup
      ]
    else
      [
        iterm2
        telegram-desktop
        raycast
        spotify
        vscode
        neovim
        git
        karabiner-elements
        discord
        #does not start for some reason
        #synology-drive-client
        tmux
        yt-dlp
        go
        bun
        ansible
        # darwin.xcode_15_1
        darwin.xcode_16_1
        # blender
        keka
        iina
        nodejs_20
        ffmpeg-full
        obsidian
        scrcpy
        # fd and ripgrep are needed for telescope plugin in nvim
        fd
        ripgrep
        transmission_4
        scrcpy
        watchman
        zulu17
        cocoapods
        rustup
        #monero-gui
        #sweethome3d.application
        #signal-desktop
        #enpass
        #firefox
        #steam
        #vlc
        #the-unarchiver or unar (the one available in nix seems to be cli only)

        # # It is sometimes useful to fine-tune packages, for example, by applying
        # # overrides. You can do that directly here, just don't forget the
        # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
        # # fonts?
        # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

        # # You can also create simple shell scripts directly inside your
        # # configuration. For example, this adds a command 'my-hello' to your
        # # environment:
        # (pkgs.writeShellScriptBin "my-hello" ''
        #   echo "Hello, ${config.home.username}!"
        # '')
      ];

  programs.git = {
    enable = true;
    userName = "Jan Jaworski";
    userEmail = if type == "work" then "jmm.jaworski@gmail.com" else "jaworek3211@gmail.com";
    extraConfig = {
      core.editor = "/etc/profiles/per-user/john/bin/nvim";
      push.autoSetupRemote = true;
      init.defaultBranch = "master";
      pull.rebase = true;
      merge.conflictstyle = "zdiff3";
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
    };
    enableCompletion = true;
    syntaxHighlighting.enable = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/karabiner".source = ./karabiner;
    ".config/tmux".source = ./tmux;
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/davish/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
    # need to manually define it for tmux to find config correctly
    XDG_CONFIG_HOME = "$HOME/.config";
    JAVA_HOME = "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
