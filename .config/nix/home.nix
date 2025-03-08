{
  config,
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

  imports =
    if type == "work" then
      [
        ./common-apps.nix
        ./work-apps.nix
      ]
    else
      [
        ./common-apps.nix
        ./personal-apps.nix
      ];

  programs.git = {
    enable = true;
    userName = "Jan Jaworski";
    userEmail = if type == "work" then "jan.jaworski@callstack.com" else "jaworek3211@gmail.com";
    extraConfig = {
      core.editor = "/etc/profiles/per-user/john/bin/nvim";
      push.autoSetupRemote = true;
      init.defaultBranch = "master";
      pull.rebase = true;
      merge.conflictstyle = "zdiff3";
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      delta = {
        navigate = true;
      };
    };
  };

  # programs.zsh = {
  #   enable = true;
  #   autosuggestion = {
  #     enable = true;
  #   };
  #   enableCompletion = true;
  #   syntaxHighlighting.enable = true;
  # };
  #
  # programs.starship = {
  #   enable = true;
  # };

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
    ".config/tmux".source = config.lib.file.mkOutOfStoreSymlink ./tmux;
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink ./zsh/.zshrc;
    ".config/ghostty".source = ./ghostty;
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
